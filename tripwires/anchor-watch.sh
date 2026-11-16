#!/usr/bin/env bash
# OBLITERATUS weight tripwire — one cycle per invocation.
# Scheduled every 12h via .github/workflows/anchor-watch.yml; log: tripwires/anchor.log
# Anchor: evidence/anchors/INDEX.json (27 repos / 670 LFS files frozen 2026-11-15)
cd "$(dirname "$0")/.."
LOG="${WATCH_LOG:-tripwires/anchor.log}"
INDEX="${ANCHOR_INDEX:-evidence/INDEX.json}"
python3 - "$INDEX" >> "$LOG" 2>&1 <<'PY'
import json, urllib.request, datetime, sys
def get(u):
    with urllib.request.urlopen(urllib.request.Request(u, headers={"User-Agent":"anchor-watch/1.0"}), timeout=25) as r:
        return json.load(r)
idx = json.load(open(sys.argv[1]))
changes = []
for rid, meta in idx["repos"].items():
    try:
        m = get(f"https://huggingface.co/api/models/{rid}")
        if m.get("sha") != meta.get("revision"):
            tree = get(f"https://huggingface.co/api/models/{rid}/tree/main?recursive=true")
            now = {e["path"]: e["lfs"]["oid"] for e in tree if e.get("type")=="file" and e.get("lfs")}
            was = {f["path"]: f["lfs_sha256"] for f in meta.get("lfs_files", [])}
            diff = [p for p in set(now)|set(was) if now.get(p) != was.get(p)]
            changes.append(f"{rid}: rev {str(meta.get('revision'))[:8]}->{str(m.get('sha'))[:8]} files_changed={diff[:6]} (frozen_file_count={len(was)})")
        sys.stdout.flush()
    except Exception as ex:
        changes.append(f"{rid}: CHECKFAIL {ex}")
flag = "[OBL-CHANGE] " if any("rev " in c for c in changes) else "[OBL-OK] "
print(f"{datetime.datetime.now(datetime.timezone.utc).strftime('%Y-%m-%dT%H:%M:%SZ')} {flag}" + ("; ".join(changes[:8]) if changes else f"{len(idx['repos'])} repos match frozen anchors"))
PY
