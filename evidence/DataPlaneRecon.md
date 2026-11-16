# DataPlaneRecon — data plane, registry, pay-rail, governance pages

Task: DataPlaneRecon · Run: 2026-11-15 12:31–12:50Z · Working dir: /home/user/research · Raw: /home/user/research/evidence/DataPlaneRecon_raw/
Budget: max 5 HTTP requests to any pirateface.co host/IP. **Used: 5/5** (see Request log). One additional probe — HEAD to the data-plane IP :8787 — is explicitly authorized by the task ("one optional HEAD … 5 s timeout, no retries") and is logged separately as `OPT`.

## Request log

| # | Time (UTC) | Host/IP | URL | Status | Size | Note |
|---|-----------|---------|-----|--------|------|------|
| 1 | 2026-11-15T12:31:41Z | tracker.pirateface.co:6969 | `http://tracker.pirateface.co:6969/scrape` | 000 (TCP timeout, 20 s) | 0 | Budget req 1 |
| 2 | 2026-11-15T12:32:03Z | tracker.pirateface.co:6969 | `http://tracker.pirateface.co:6969/announce` | 000 (TCP timeout, 20 s) | 0 | Budget req 2; no further retries per task |
| 3 | 2026-11-15T12:44:15Z | pay.pirateface.co | `https://pay.pirateface.co/` (verbose, cert capture) | 404 | 1 009 B | Budget req 3 |
| 4 | 2026-11-15T12:44:20Z | pay.pirateface.co | `https://pay.pirateface.co/` (meta check) | 404 | 1 009 B | Budget req 4 — unintended duplicate of req 3, logged as such |
| 5 | 2026-11-15T12:48:13Z | pirateface.co | `https://pirateface.co/takedown` | 200 | 148 303 B | Budget req 5 — takedown prioritized per task |
| OPT | 2026-11-15T12:40:57Z | 187.127.110.248:8787 | `http://187.127.110.248:8787/` (HEAD, 5 s timeout) | 000 (TCP timeout, 5.00 s) | 0 | Task-authorized optional probe; no retry |

Non-budget requests (not HTTP to pirateface.co hosts/IPs): DNS lookups for tracker/pay/apex/www subdomains; RDAP via rdap.org (redirected to rdap.db.ripe.net); whois for 187.127.110.248. **Skipped due to budget:** live fetch of `/terms`, `/mission`, `/provenance` (no local archive copy of terms/mission exists; provenance archive copy analyzed as secondary).

---

## 1. Tracker state — tracker.pirateface.co:6969

**Receipt T-1** (objective 1, req 1):
- `[cmd]` `curl -sv http://tracker.pirateface.co:6969/scrape -m 20` (raw: `tracker_scrape_headers.txt` — empty; meta: `req1_meta.txt`)
- `[obs]` `*   Trying 187.127.110.248:6969...` … `* connect to 187.127.110.248 port 6969 failed: Connection timed out` … `curl: (28) Connection timed out after 20001 milliseconds` (http_code 000, remote_ip empty — TCP never completed)
- `[conclusion]` **PROVEN** from this vantage: TCP 6969 is closed or filtered. No bencoded (`d`-prefixed) response, no compact error — the tracker is not answering HTTP tracker requests.

**Receipt T-2** (objective 1, req 2):
- `[cmd]` `curl -sv http://tracker.pirateface.co:6969/announce -m 20` (raw: `tracker_announce_headers.txt` — empty; meta: `req2_meta.txt`)
- `[obs]` same: `Trying 187.127.110.248:6969...` → `connect ... failed: Connection timed out` → `curl: (28) ... after 20001 milliseconds` (http_code 000)
- `[conclusion]` **PROVEN** (this run): `/announce` also unreachable; endpoint set cannot be probed. Consistent with prior data:
  - **REPORTED** (evidence/pirateface-pentest-2026-11-13.md, §2 table): "Tracker `tracker.pirateface.co` → **187.127.110.248** (Hostinger, MY). TCP 6969 **closed/filtered** at test time; `/api/trackers` serves it as the only tracker (udp + http), changeable server-side 'so changes need no release.'"
  - DNS (this run, non-budget): `tracker.pirateface.co` → `187.127.110.248` — the A record still points at the same box as the web-seed origin. The catalog API (`/api/trackers`, per the 11-13 pentest) still advertises it; we did not re-fetch it (budget).

**Net:** tracker host is still name-resolving to the same IP, but the tracker process/port is not reachable from this vantage — same result as the 2026-11-13 pentest, reproduced 2026-11-15.

## 2. Data-plane IP — 187.127.110.248 (web-seed origin, port 8787)

**Receipt D-1** (RDAP, non-budget; 2026-11-15T12:37:01Z, 200 OK, 7 292 B — raw: `rdap_187.json`):
- `[cmd]` `curl -sL https://rdap.org/ip/187.127.110.248` (redirected to `rdap.db.ripe.net`)
- `[obs]` RIPE NCC RDAP: `cidr0i "187.127.96.0/19"`, `name "HOSTINGER-HOSTING"`, `country "MY"`, `status ["active"]`, `last changed 2026-03-02` (mnt `HOSTINGER`). Entities: registrant **Hostinger International Limited**, SODURIU GATVE 14, VILNIUS, LT-08412; admin/tech **Hostinger NOC** (HN2912-RIPE), phone +370-5-2122900, NOC@hostinger.com; **abuse: abuse@hostinger.com** (AR77018-RIPE).
- `[conclusion]` **PROVEN** (primary registry source): the /19 containing 187.127.110.248 is assigned to Hostinger (Malaysia pool), active, allocated 2026-03-02, org HQ Vilnius (Lithuania).

**Receipt D-2** (whois, non-budget; 2026-11-15T12:37:05Z — raw: `whois_187.txt`):
- `[cmd]` `whois 187.127.110.248`
- `[obs]` `inetnum: 187.127.96.0 - 187.127.127.255`, `netname: HOSTINGER-HOSTING`, `country: MY`, `status: ASSIGNED PA`, `created: 2026-03-02T10:58:58Z`, `e-mail: abuse@hostinger.com`, `geoloc: 2.904340 101.650938` (Kuala Lumpur), mnt-by HOSTINGER, mnt-lower HNO21-RIPE (Hostinger NOC, Vilnius). Route: `187.127.96.0/19 AS47583` — "AS-NAME: **Hostinger MY**" (Vilnius address, +370-5-2122900, NOC@hostinger.com), `last-modified 2026-11-11T14:16:36Z`.
- `[conclusion]` **PROVEN**: autonomous system is **AS47583 "Hostinger MY"**; geolocation pin = Kuala Lumpur, MY. The /19's route entry was last modified **2026-11-11** (4 days before this run) — the block is actively maintained.

**Receipt D-3** (direct probe, OPT req):
- `[cmd]` `curl -sSI -m 5 http://187.127.110.248:8787/` (raw: `head_8787_meta.txt`)
- `[obs]` `curl: (28) Connection timed out after 5001 milliseconds`; http_code 000; no headers.
- `[conclusion]` **PROVEN** (this vantage): port 8787 does not answer HEAD from here. **REPORTED** context: the 2026-11-13 pentest also found :8787/:443 "unreachable at test time" *directly*, while the swarm served files through it when reached via the `https://pirateface.co/api/ws/…` 302 hop (pentest §2); the 2026-11-14 strace run (different exit/VM) reached it repeatedly (33 observed transfers per ledger). Interpretation [INFERENCE]: the box is likely firewalled or geo/vantage-filtered — reachable from some networks, not from ours.

## 3. Pay rail — pay.pirateface.co

**Receipt P-1** (req 3; raw: `pay_headers.txt`, `pay_body.html`, `pay_verbose.txt`):
- `[cmd]` `curl -sv https://pay.pirateface.co/ -m 25`
- `[obs]`
  - DNS: `pay.pirateface.co` → `t1kpay-hapro-brerpx815yxp-ac89608e147b66ef.elb.us-east-1.amazonaws.com` → `100.49.110.141` / `100.49.0.246` — the same ELB name/IPs that `paylinks.commerce.godaddy.com` and `t1k.poynt.net` resolve to (DNS this run, non-budget).
  - TLS 1.3, ALPN http/1.1; **cert: CN=pay.pirateface.co, issuer `GoDaddy TLS Intermediate CA DV - R1v1` (US), valid 2026-09-01 20:39:59 GMT → 2027-03-18 02:39:59 GMT**, SAN `pay.pirateface.co`, verify ok.
  - `HTTP/1.1 404 Not Found`, 1 009 B; headers: `content-security-policy: frame-ancestors 'self' https:`, `access-control-expose-headers: X-Trace-Id`, `x-trace-id: ae98d9bec78d0cedb4ab7673e7f44eb4`, `etag W/"3f1-…"`.
  - Body: GoDaddy Payments pay-links error page — `<title>Pay Link Not Found</title>`, `<h2 class="error-message">Pay Link Not Found</h2>`, assets from `web-static-gd-payments.godaddy.com` and `d85ecz8votkqa.cloudfront.net/payments-hub/`, footer "Websites and Payments powered by [GoDaddy]".
- `[conclusion]` **PROVEN**: the GoDaddy Payments pay-link product is still wired up (dedicated CNAME to GoDaddy's T1K haproxy ELB pool, valid DV cert for the subdomain, platform responding with its standard error page) but the specific pay link at `/` is **not found** — the rail is live, the link is dead/expired. This reproduces the 2026-11-14 ledger finding (LEDGER.md L34–L35: "pay.pirateface.co exists (cert 2026-09-01) → 'Pay Link Not Found' … Payment rail = GoDaddy Payments pay-link product").

**Receipt P-2** (req 4, duplicate):
- `[cmd]` `curl -s https://pay.pirateface.co/ -o /dev/null -w 'http_code:%{http_code} remote_ip:%{remote_ip} ssl_verify:%{ssl_verify_result} size:%{size_download}'`
- `[obs]` `http_code:404 remote_ip:100.49.110.141 ssl_verify:0 size:1009`
- `[conclusion]` **PROVEN**: same 404, same upstream ELB IP, cert verified — result of req 3 confirmed with a second identical request (logged as budget req 4).

**Cert-date cross-check [REPORTED]:** certspotter history in the ledger (LEDGER.md L36) shows the pay cert first seen 2026-09-01; the live cert we observed is that same lineage (start Sep 1 2026, end Mar 18 2027, DV, GoDaddy). No reissuance of the pay cert since then.

## 4. Governance pages

### 4.1 /takedown (live, budget req 5) — PRIMARY

**Receipt G-1** (req 5; raw: `takedown_headers.txt`, `takedown.html`, 148 303 B):
- `[cmd]` `curl -s https://pirateface.co/takedown` (HTTP/2 200, `server: Vercel`, `x-matched-path: /takedown`, `x-vercel-id: fra1::iad1::…`)
- `[obs]` Visible text (extracted via python3, raw: `takedown_visible.txt`). Page header: **"Takedown / DMCA"**, **"Last updated September 5, 2026"**.
- `[conclusion]` **PROVEN** (primary, live). Full procedure quoted:

  > "Pirate Face is an index and mirror of publicly available, open-weight AI models. Each model is published as a checksum-verified magnet link that also downloads straight from Hugging Face. We do not host model weights on a single central server - files are distributed peer-to-peer across the swarm."
  >
  > "We respect intellectual-property rights and licenses. If you are a rights holder and believe material indexed here infringes your rights, you can ask us to remove the listing."

  **Filing (what it accepts):** "Message **@ThePirateFace on X** and say that you need to file a takedown notice. Include the exact Pirate Face URL at issue and we will give you instructions for providing the complete notice privately. A complete notice must include:" — (1) identification of the copyrighted work/right infringed; (2) exact Pirate Face URL(s) or handle(s) (e.g. `pirateface.co/author/model`); (3) name, organization, contact details; (4) good-faith belief the use is not authorized by the rights holder, its agent, or the law; (5) statement **under penalty of perjury** of accuracy and of being the rights holder or authorized to act; (6) physical or electronic signature. This is the standard US DMCA §512(c) notice set, administered via X DM rather than an email address — **no email/mailto appears anywhere in the page** (grep of raw HTML: none).

  **Promises:** "On a valid notice we will delist the model from our index, remove its magnet and Hugging Face download link, and stop seeding it from any infrastructure we control, promptly." Scope limit: "Because magnets are peer-to-peer, a file that has already been distributed may continue to exist on copies held by independent peers we do not operate. We cannot recall those copies, but we will remove the listing and cease our own distribution." Open-license note: "Most models mirrored here are released under permissive or open licenses (for example Apache-2.0, MIT, or an open RAIL variant). … If you published a model openly and want it removed anyway, the same process applies." Counter-notice: "If your content was removed and you believe that was a mistake or misidentification, continue the X message thread to request counter-notice instructions … include a statement, under penalty of perjury, that you have a good-faith belief the material was removed in error." Repeat infringers: "Handles used to repeatedly publish infringing or mislabeled content may be suspended or reclaimed." Language clause: English version controls.

  **Who decides:** not stated in the text — the page gives no named decision-maker, SLA number, or public log; the decision is implied to rest with the site operator (the "we" of @ThePirateFace), and the counter-notice route is the same X thread. [INFERENCE: "promptly" is the only commitment on timing.]

**Receipt G-2** (staleness check, non-budget; local archive copy `evidence/wayback_raw/pages/takedown.html`, snapshot **2026-10-18T18:16:04Z**):
- `[cmd]` python3 visible-text diff of archive snapshot vs live fetch
- `[obs]` policy body identical (nav/footer chrome only); both carry "Last updated September 5, 2026".
- `[conclusion]` **PROVEN**: the live takedown page text is unchanged since at least 2026-10-18; the Sep 5 2026 "last updated" date is stable across a month of snapshots. CDX (evidence/wayback_raw/cdx_full.jsonl) shows earlier snapshots: 2026-09-15 (6 039 B), 2026-09-20 (5 857 B), 2026-09-28 (26 785 B) — the page grew substantially around the Sep 28 snapshot (consistent with the Sep 5 policy text being the current one).

### 4.2 /provenance (budget-skipped; archived copy, secondary)

**Receipt G-3** (local archive copy `evidence/wayback_raw/pages/provenance.html`, snapshot **2026-11-08T18:31:31Z** — not re-fetched live):
- `[cmd]` python3 visible-text extraction (raw: `provenance_visible.txt`)
- `[obs]` (Chinese-locale rendering) "Pirate Face 记录过的每个模型的只追加、哈希链接记录 … 修改任何一条过去的记录，之后的每个哈希都会断开。" = an **append-only, hash-chained record** of every model revision it has tracked; each entry seals the exact Hugging Face checksum into the chain; tampering with one historical entry breaks all later hashes. "链已验证 … 已从创世记录重新计算 47,869 条记录 · 签名根 6a9a66d3cf…a2ad01 · 1 个无害分叉（同时记录于 #631）" — chain verified: 47,869 entries recomputed from genesis; signed root `6a9a66d3cf…a2ad01`; **1 benign fork, simultaneously recorded at entry #631**. Entry hash spec: `entryHash = SHA256(prevHash | repo | revision | digest | witnessedAt)`; raw chain data at `/api/provenance`. Latest visible entry: #48020, `huihui-ai/Huihui-Qwen3.8-Flash-Next-abliterated`, 2026-11-08 18:27 UTC.
- `[conclusion]` **REPORTED** (archive.org snapshot 2026-11-08; live page not re-fetched due to budget): the provenance page publicly documents the hash-chain design and the single #631 fork — the same #631 fork the 2026-11-14 catalog task could not inspect externally (LEDGER.md: "no access to seq 631 fork").

### 4.3 /terms and /mission (budget-skipped; index evidence only)

**Receipt G-4** (CDX index `evidence/wayback_raw/cdx_full.jsonl`, non-budget):
- `[cmd]` grep CDX rows for `/terms`, `/mission`
- `[obs]` `/terms` snapshots: 2026-08-05 (5 618 B) → 2026-11-12 07:21:30Z (44 203 B), 12 captures, all HTTP 200; the page has grown ~8× since August — a substantive, maintained terms page exists. `/mission` snapshots: 2026-09-05 (307), 2026-10-15 (307), 2026-11-08 (200, 38 853 B), 2026-11-12 07:21:12Z (200, 41 817 B).
- `[conclusion]` **NOT FOUND (in-run)**: live text of `/terms` and `/mission` — never fetched (budget exhausted by tracker/pay/takedown). **REPORTED** (index-level): both pages are live and actively maintained; `/terms` was last captured 2026-11-12 at 44 KB (vs 5.6 KB on 2026-08-05), i.e. it has been substantially rewritten during the case window. The 2026-08-05 `/terms` snapshot (5.6 KB) predates the Oct–Nov relaunch and is likely the older, shorter terms text — fetching it would require an archive.org request outside this task's budget.

---

## ANSWERS

**(a) Tracker alive / exposed endpoints?** Not reachable from our vantage. Both budget probes — `GET /scrape` (2026-11-15T12:31:41Z) and `GET /announce` (12:32:03Z) to `tracker.pirateface.co:6969` (→ 187.127.110.248) — ended in raw TCP timeouts (20 s, http 000, no bencoded body, no compact error) [Receipts T-1, T-2]. This reproduces the 2026-11-13 pentest result exactly: TCP 6969 closed/filtered, while the catalog's `/api/trackers` still advertises tracker.pirateface.co as the sole tracker (udp + http) (pentest §2, [REPORTED] — we did not re-fetch the API, budget). The A record still points at the same Hostinger box [Receipt D-1 context]. So: the tracker is *announced* but not *answerable* — either the service is down or the port is firewalled from our egress.

**(b) Data-plane IP ownership / country / status?** 187.127.110.248 sits in `187.127.96.0/19` "HOSTINGER-HOSTING", RIPE NCC: **country MY (Malaysia), status active, assigned 2026-03-02**, abuse contact **abuse@hostinger.com**, admin/tech Hostinger NOC (Vilnius, +370-5-2122900, NOC@hostinger.com); routed via **AS47583 "Hostinger MY"**, geoloc pinned to Kuala Lumpur (2.904, 101.651) [Receipts D-1, D-2 — PROVEN, primary registry sources]. The /19 route entry was last modified 2026-11-11, four days before this run — the block is under active administration. Direct `HEAD :8787` timed out at 5 s [Receipt D-3], consistent with the 11-13 pentest's "unreachable directly" and the 11-14 strace run's repeated successful transfers from a different vantage [INFERENCE: vantage/geo-filtered, not universally down].

**(c) Pay-rail live?** The rail is live; the link is dead. `pay.pirateface.co` resolves to GoDaddy's own pay-links platform (`t1kpay-hapro-brerpx815yxp-ac89608e147b66ef.elb.us-east-1.amazonaws.com`, the same ELB as paylinks.commerce.godaddy.com / t1k.poynt.net), presents a valid GoDaddy-issued DV cert for CN=pay.pirateface.co (**2026-09-01 → 2027-03-18**), and answers `GET /` with GoDaddy's standard **"Pay Link Not Found" 404** (1 009 B, `x-trace-id`, CSP frame-ancestors) — twice, identically [Receipts P-1, P-2]. That is the same state as 2026-11-14 (LEDGER L34–35): a GoDaddy Payments pay-link product, KYC-backed merchant onboarding, currently returning no pay link at root.

**(d) Takedown procedure — what it accepts, what it promises?** Live page (fetched 2026-11-15, Vercel; text unchanged since the 2026-10-18 snapshot; "Last updated September 5, 2026") [Receipts G-1, G-2]. **What it accepts:** a rights holder must first **message @ThePirateFace on X** (no email address is published anywhere on the page) and ask to file a takedown; they then receive instructions to submit a *complete* DMCA-style notice privately, requiring the six classic elements: (1) identification of the work/right infringed, (2) exact Pirate Face URL(s)/handle(s), (3) name/org/contact, (4) good-faith belief the use is unauthorized, (5) perjury-backed accuracy and authority statement, (6) physical or electronic signature. **What it promises:** on a valid notice it will "delist the model from our index, remove its magnet and Hugging Face download link, and stop seeding it from any infrastructure we control, **promptly**" — with an explicit carve-out that copies already held by independent peers "we do not operate" cannot be recalled. It adds a counter-notice path (same X thread, perjury-backed misidentification statement), a repeat-infringer clause (handles "may be suspended or reclaimed"), and notes openly licensed models can be removed through the same process. **Who decides:** unstated — no named officer, no timeline number, no public registry; operationally it is the @ThePirateFace operator, with "promptly" as the only timing commitment [INFERENCE].

---

## Source list

Fetched this run:
- `http://tracker.pirateface.co:6969/scrape` (2026-11-15T12:31:41Z) — budget 1
- `http://tracker.pirateface.co:6969/announce` (2026-11-15T12:32:03Z) — budget 2
- `https://pay.pirateface.co/` (2026-11-15T12:44:15Z) — budget 3
- `https://pay.pirateface.co/` (2026-11-15T12:44:20Z) — budget 4 (duplicate)
- `https://pirateface.co/takedown` (2026-11-15T12:48:13Z) — budget 5
- `http://187.127.110.248:8787/` HEAD (2026-11-15T12:40:57Z) — task-authorized optional
- `https://rdap.org/ip/187.127.110.248` → rdap.db.ripe.net (2026-11-15T12:37:01Z) — non-budget
- `whois 187.127.110.248` (2026-11-15T12:37:05Z) — non-budget
- DNS: tracker/pay/apex/www subdomains, paylinks.commerce.godaddy.com, t1k.poynt.net — non-budget

Local artifacts (not re-fetched): `evidence/wayback_raw/pages/takedown.html` (snapshot 2026-10-18T18:16:04Z), `evidence/wayback_raw/pages/provenance.html` (snapshot 2026-11-08T18:31:31Z), `evidence/wayback_raw/cdx_full.jsonl` (CDX index), `evidence/LEDGER.md` L34–36, `evidence/pirateface-pentest-2026-11-13.md` §2.
