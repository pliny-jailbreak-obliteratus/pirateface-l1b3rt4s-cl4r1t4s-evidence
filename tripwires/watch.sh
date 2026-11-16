#!/usr/bin/env bash
# PirateFace observables watch — one cycle per invocation.
# Scheduled every 6h via .github/workflows/watch.yml; log: tripwires/watch.log
# Baseline self-maintains in tripwires/watch-baseline.txt (last-seen values; each transition logs once).
cd "$(dirname "$0")/.."
LOG="${WATCH_LOG:-tripwires/watch.log}"
BASE="${WATCH_BASE:-tripwires/watch-baseline.txt}"
ts() { date -u +"%Y-%m-%dT%H:%M:%SZ"; }

# 1. Certificate-transparency names
NEWN=$(curl -s --max-time 40 "https://crt.sh/?q=%25.pirateface.co&output=json" | python3 -c "
import json,sys
try:
    d=json.load(sys.stdin); names=set()
    for e in d:
        for n in e.get('name_value','').split('\n'): names.add(n.strip())
    print(','.join(sorted(names)))
except: print('CTERR')")

# 2. PyPI version
PYPI=$(curl -s --max-time 15 "https://pypi.org/pypi/pirateface/json" | python3 -c "
import json,sys
try: print(json.load(sys.stdin)['info']['version'])
except: print('PYPIERR')")

# 3. Homepage STRUCTURAL signature (title + presence of structural markers — immune to live-ticker/link rotation)
HS=$(curl -s --max-time 20 -A "Mozilla/5.0" "https://pirateface.co/" | python3 -c "
import sys, re, hashlib
t = sys.stdin.read()
m = re.search(r'<title>([^<]*)</title>', t)
title = m.group(1) if m else ''
markers = sorted(set(w.lower() for w in re.findall(r'(?i)(takedown|provenance|rescue|donate|mission|leaderboard|piratechat|datasets)', t)))
sig = title + '|' + ','.join(markers)
print(hashlib.sha256(sig.encode()).hexdigest() + '|' + ','.join(markers))")

# 4. HF abliterated corpus newest upload date
HF=$(curl -s --max-time 20 "https://huggingface.co/api/models?search=abliterated&sort=lastModified&direction=-1&limit=1" | python3 -c "
import json,sys
try: print(json.load(sys.stdin)[0].get('lastModified','?')[:10])
except: print('HFERR')")

CT_B=$(sed -n 's/^CT: //p' "$BASE" 2>/dev/null)
PYPI_B=$(sed -n 's/^PYPI: //p' "$BASE" 2>/dev/null)
HS_B=$(sed -n 's/^HOME_STATIC: //p' "$BASE" 2>/dev/null)

FLAGS=""
[ -n "$CT_B" ] && [ "$NEWN" != "$CT_B" ] && FLAGS="$FLAGS[CT-CHANGE]"
[ -n "$PYPI_B" ] && [ "$PYPI" != "$PYPI_B" ] && FLAGS="$FLAGS[PYPI-CHANGE]"
[ -n "$HS_B" ] && [ "$HS" != "$HS_B" ] && FLAGS="$FLAGS[HOME-CHANGE]"

echo "$(ts) $FLAGS CT=[$NEWN] PYPI=$PYPI HOME_STATIC=$HS HFNEW=$HF" >> "$LOG"

# update last-seen baseline AFTER logging
{ echo "CT: $NEWN"; echo "PYPI: $PYPI"; echo "HOME_STATIC: $HS"; echo "BASELINE_UPDATED: $(ts)"; } > "$BASE"
