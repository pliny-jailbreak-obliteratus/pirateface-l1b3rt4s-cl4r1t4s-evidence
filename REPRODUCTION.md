# REPRODUCTION MANUAL — PirateFace Audit

Pure execution. No interpretation. Run top to bottom; every command's expected result is stated; any mismatch against a **PROVEN** claim means the claim is wrong — report it and it gets withdrawn.

## 0. TRUST MODEL

- **No trust required (§1):** every check hits primary sources — Hugging Face, PyPI, GitHub, government sites, news outlets. If the output matches, the claim stands regardless of who this manual's author is.
- **Hash-attested (§2):** artifacts frozen 2026-11-13/14/15 after the live surfaces were removed. Verify integrity with SHA-256; authenticity is the author's responsibility and is cryptographically chained in the ledger.
- **Not reproducible:** anything requiring PirateFace's removed API. The removal is documented in §2.4; archived captures provide partial corroboration.

Conventions: `→` marks expected output. Dates are UTC.

## 1. LIVE CHECKS — ~15 minutes, easiest first

**1.1 The platform exists and self-describes.**
```
curl -s https://pirateface.co/ | grep -o "<title>[^<]*"
```
→ `Pirate Face - Turn AI into torrents that live forever`
Proves: the platform and its permanence positioning. (If content changed, check §5.)

**1.2 The client exists on PyPI, authorless.**
```
curl -s https://pypi.org/pypi/pirateface/json | python3 -c "import json,sys;d=json.load(sys.stdin);print(d['info']['version'], '| author:', d['info']['author'])"
```
→ `0.2.3 | author: None`
Proves: the shipped package and the null author field at the first accountability point.

**1.3 The OBLITERATUS organization is live on Hugging Face.**
```
curl -s "https://huggingface.co/api/models?author=OBLITERATUS" | python3 -c "import json,sys;print(len(json.load(sys.stdin)),'models')"
```
→ `17 models`
Proves: the org and its catalog size. List them:
```
curl -s "https://huggingface.co/api/models?author=OBLITERATUS" | python3 -c "import json,sys;[print(m['modelId']) for m in json.load(sys.stdin)]"
```
Proves: every "liberated" model is a base from Google, Meta, Alibaba, Microsoft, DeepSeek, Mistral, or z.ai. None can originate from a closed lab — closed weights are not public.

**1.4 The identity chain (Captain Keanu / FutureGoose / ZeroPointSynergy).**
```
curl -s https://api.github.com/users/ZeroPointSynergy | python3 -c "import json,sys;d=json.load(sys.stdin);print('name:',d['name'],'| created:',d['created_at'])"
curl -s https://api.github.com/users/FutureGoose      | python3 -c "import json,sys;d=json.load(sys.stdin);print('name:',d['name'],'| created:',d['created_at'])"
curl -s "https://api.github.com/repos/pirateface/pirateface_hub/commits?per_page=100" | python3 -c "import json,sys;[print(c['commit']['author']['email']) for c in json.load(sys.stdin)]" | sort | uniq -c
```
→ `name: Captain Keanu` / `name: Gustaf Bodén` / commit-email histogram showing `Futuregoose@proton.me` on both accounts plus `help@pirateface.co`.
Proves: one commit email spans the platform account and both engineer accounts; the engineer maintains a fork of the platform's own client. View the avatar: `https://github.com/ZeroPointSynergy.png` (Keanu Reeves likeness in pirate dress).

**1.5 The commit-timezone signature.**
```
git clone -q https://github.com/pirateface/pirateface_hub && cd pirateface_hub
git log --format='%ci %ae' | awk '{print $NF}' | sort | uniq -c
git log --format='%ci' | cut -d' ' -f2 | cut -d':' -f1,2 | sort | uniq -c
```
→ All 25 commits end `+00:00`/`Z`; hours spread across the UTC day.
Proves: commits carry UTC-normalized timestamps (deliberate timezone hygiene), unlike the persona account below.

**1.6 The persona's own commit zones (US, not the claimed France).**
```
git clone -q https://github.com/elder-plinius/L1B3RT4S && cd L1B3RT4S
git log --format='%ci' | grep -oE '[+-][0-9]{4}' | sort | uniq -c | sort -rn
```
→ ~192 commits at `-0400/-0500` (US Eastern), ~43 at `-0700/-0800` (US West), remainder other.
Proves: the GitHub profile claims France; the commits come from US zones.

**1.7 The delisting-and-resurrection precedent (GLM-5.3, September 2026).**
- https://deltav.cc/blog/open-weights-continuity-plan — timeline: HF disables `penclaw-GLM-5.3-abliterated-for-offensive-cyber` ~Sept 15; same weights listed on PirateFace as a checksum-verified torrent by Sept 17; uploader onboarded via account matching; a renamed copy stayed on HF throughout.
- https://www.nist.gov/ + CAISI statement (Sept 17): base model assessed most cyber-capable open-weight release.
Proves: the delisting→swarm-resurrection cycle is documented by third parties, not just this audit.

**1.8 The environment: the two gates.**
- Vatican/Anthropic: https://apnews.com/article/vatican-pope-anthropic-olah-encyclical-artificial-intelligence-9cf3e07fd691f6af510c4a6f9c8ba353 (May 25 encyclical launch with Anthropic co-founder).
- ControlAI prohibition position: https://committees.parliament.uk/writtenevidence/169974/html (Oct 13, UK Commons).
- China open-weight export controls: https://the-decoder.com/china-plans-to-tighten-export-controls-on-open-weight-models-and-23-key-ai-technologies (Oct 16) and China Daily Nov 9 tightening.
- Nvidia ouster timeline: https://www.nytimes.com/2026/11/12/technology/nvidia-jensen-huang.html and https://nvidianews.nvidia.com/news/nvidia-announces-ceo-transition (Nov 12; resigns; Kress interim; first-ever independent chair). Leak timing analysis: https://dejan.ai/blog/huang/
Proves: the closure environment described in the article, from primary and mainstream sources.

**1.9 The uncensored corpus scale.**
```
curl -s "https://huggingface.co/api/models?search=abliterated&limit=1000" | python3 -c "import json,sys;print(len(json.load(sys.stdin)),'+ abliterated models')"
```
→ `1000+` (search cap). Repeat for `uncensored`, `heretic`.
Proves: the corpus PirateFace's intake ("Worth rescuing") draws from is >1,000 per keyword family.

**1.10 The rescue theater, in the operator's own pages.**
```
curl -s https://pirateface.co/takedown | python3 -c "import sys,re,html;t=re.sub(r'<[^>]+>',' ',sys.stdin.read());print(re.sub(r'\s+',' ',html.unescape(t)))" | grep -o "We do not host model weights on a single central server"
curl -s https://pirateface.co/skill.md | grep -iE "accept|license" | head -5
curl -s https://pirateface.co/worth-rescuing | grep -c "rescue"
```
→ The takedown page states the index-and-mirror posture verbatim; the skill file contains the license-acceptance instructions; the intake queue renders.
Proves: the operator's own pages document the theater — the safe-harbor posture, agent-performed license acceptance, and the self-declared intake queue. (All three are LIVE surfaces — if one dies, record the date; the archived Sept-5/Oct versions are in the bundle's Wayback captures.)

## 2. FROZEN CHECKS — bundle-attested

**2.1 Integrity.**
```
sha256sum -c MANIFEST.sha256        # in the evidence bundle
```
→ all `OK`. Anything else: stop; the bundle is not the audited one.

**2.2 Catalog composition (frozen 2026-11-14).**
```
python3 - <<'EOF'
import json
d=json.load(open('catalog_all.json'))
ids=[i for i in d]
own=[i for i in ids if i.split('/')[0].lower() in {'obliteratus','pliny-the-prompter','manitcor','0xmoose','pirateface','zeropointsynergy','futuregoose'}]
derived=[i for i in ids if any(k in i.split('/',1)[1].lower() for k in ('abliterat','uncensor','heretic','decensor'))]
print(len(ids),'entries |',len(set(i.rsplit("/",1)[0] for i in ids)),'authors | own-org:',len(own),'| derived-named:',len(derived))
EOF
```
→ `1173 entries | 606 authors | own-org: 1 | derived-named: 183`
Proves: the operator authors 0.1% of its own catalog; the derived-content supply is the community's.

**2.3 Rescue data-plane (frozen 2026-11-13).** Open `api_rescue.txt`; locate the `url-list` entry: a 302 to `http://187.127.110.248:8787` — bare IP, plain HTTP. Proves: the rescue pipeline's origin was an unattributable unencrypted host on the day of capture.

**2.4 The API removal itself (live, negative check).**
```
curl -s https://pirateface.co/api/models?limit=1 | head -c 120
```
→ `<!DOCTYPE html>` (an application shell titled "api/models · Pirate Face"), not JSON.
Proves: the enumeration surface cited in the audit is gone. Its pre-removal behavior is attested by `catalog_all.json` (bundle) and archived captures at web.archive.org (snapshots 2026-11-08, 2026-11-11).

**2.5 Weight-provenance anchors (frozen 2026-11-15).** `INDEX.json`: 27 repositories, 670 LFS files, sha256 oids + revisions. Check any file claiming provenance from these repos:
```
sha256sum <downloaded-file>     # compare against the matching lfs_sha256 in INDEX.json
```
Proves/protects: if the weights ever change upstream or in a "rescue," the divergence is computable by anyone holding this file.

## 3. THE POISON TEST — sandbox required

The verification attack was reproduced end-to-end in the sandbox: a mock in the distributor's network position served `hf:false` weights with an attacker-chosen sha256; the client downloaded and reported `DOWNLOADED OK: BACKDOORED-WEIGHTS-NOT-THE-REAL-MODEL, verified`. Control (mirrored repo): rejected; genuine HF bytes arrived. Full narrative, commands, and outputs: `evidence/pirateface-pentest-2026-11-13.md`, audit Part 3.
Safety: re-attempt only inside a disposable sandbox (ephemeral home, user-space networking, strace). Never execute the package on a host you care about — that is the finding, not a formality.

## 4. TRIPWIRES — run your own watch

```
# weights: 27 anchored repos vs frozen revisions/oids (12h cadence in our run)
# site: homepage sha256, cert-transparency names, PyPI version (6h cadence)
# registry: Delaware/Wyoming name search for operator entities; registered-agent overlap with the LYSIOS cluster
```
Reference implementation: `tripwires/watch.sh` and `tripwires/anchor-watch.sh` (run manually or on private infrastructure; log samples: `tripwires/watch.log`, `tripwires/anchor.log`). Any `[OBL-CHANGE]` line = the anchor diverged from the freeze; diff which files changed before drawing conclusions.

## 5. DECAY PROTOCOL

When a live link dies: fetch the Wayback capture (earliest post-publication snapshot) and note the death date. Dead links to removed surfaces are consistent with the documented removal pattern — record them; do not treat them as disproof.

## 6. CLAIM REGISTRY

`CLAIMS.md` in the repository maps every factual claim in the article to: this manual's section, artifact hash, status (LIVE / FROZEN / DECAYED), and last-checked date.

## RETRACTION RULE

Any command here failing on your machine against a **PROVEN** claim: post the full output. The claim is withdrawn the same day. Three claims have been withdrawn under this rule already; the withdrawals and their provenance are part of the published ledger.
