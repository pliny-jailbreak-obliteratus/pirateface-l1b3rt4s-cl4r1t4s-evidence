# WaybackArchaeology — COMPLETED (main line, after agent context-death)

## Method
CDX full-domain enumeration (9,540 captures / 2,694 unique paths, Aug 5 → Nov 13 2026,
saved: wayback_raw/cdx_full.jsonl). Eight SSR pages fetched from Wayback replay
(wayback_raw/pages/): /zh/leaderboard (Oct 13), /zh/provenance (Nov 8), /zh/activity
(Nov 3), /worth-rescuing (Nov 12), /takedown (Oct 18), /zh/audnai/penclaw-GLM-5.3-abliterated
(Oct 1), /zk-inference.md (Oct 18), /zh/articles/every-ai-model-should-be-a-torrent (Nov 12).
Next.js flight payloads extracted (self.__next_f regex) and parsed.

## FINDINGS
1. **Activity event stream recovered: 641 events** (snapshot Nov 3, 2026):
   - 355 firstSeeded (first observed peer per model)
   - 242 witness (provenance-log revisions; sequence IDs 44119 → 44361 — the chain's
     actual sequence numbering, previously capped/uninspectable via API)
   - 12 community, 12 verified
   - **20 username-claim events with millisecond timestamps (Nov 3 alone):**
     crypto 22:01, rambo 21:37, mrfox 21:28, ohtyoma17 21:15, impericore 19:47,
     kahlnen 19:31, rene 19:29, faceofbo 17:51, thedhara 17:43, richydrinkbeer 16:29,
     warpfusion001 16:24, convictintegrity 15:48, leftwithnothing 15:31, nonmame 15:26,
     saniyo 15:17, razman 14:07, izf 13:05, insansimple 10:37, ekiine233 10:37, jrcp 10:35
   - Action taxonomy (platform's own i18n strings): "Genesis: first share (optional)",
     "rescue model: click rescue on the model page, OR tag @thepirateface on X",
     "refer new accounts to claim their first username" — the referral mechanic,
     in the platform's own words.
2. **Leaderboard (Oct 13 snapshot), top rows (visible-table capture):**
   nemisishubris 25/0/1025/26k · roggied 100/1/1011/25k · sherpa 100/4/862/22k ·
   alogotron 100/0/664/17k · azurestrix 100/0/631/16k · pinocookie 0/0/153/3.8k ·
   ensign-baker… (+ handles: leolaporte, mia, blackfrost-ai, mr_r0b0t, vwade,
   catplusplus, keys, queencaffeine)
   Referral column CONFIRMED: sherpa = 4 referrals as of Oct 13 (grew to ~10 by Nov).
3. **Provenance page: 600 sha256 hashes** in the flight payload + witness sequence range.
4. **Takedown page (Sept 5 version)**: "index and mirror of publicly available, open-weight
   AI models… checksum-verified magnet link that also downloads straight from Hugging Face.
   We do not host model weights on a single central server." Classic safe-harbor posture.
5. **Audn AI's penclaw page archived (Oct 1)** — the delisted model's PirateFace presence.
6. **Full Chinese locale (/zh/**)** — ~200+ paths, parallel to English site.
7. **Ideology essays archived**: "every AI model should be a torrent", "introducing Pirate
   Face hub", "making models permanent", "one model one swarm".
8. `/zk-inference.md` archived (Oct 18) — 4.2KB, the ZK inference documentation.
9. `/submit` captured 124x — heavy crawler attention on the submission surface.

## ANSWERS
(a) 2,694 archived paths incl. leaderboard/provenance/activity/claim/account renders.
(b) Removed-API endpoint map: partially reconstructed from bundle references; SSR pages
    carried the data server-side, which is why the archive captured it.
(c) People/leaderboard data: RECOVERED (rows above + 20-claim timeline + 641 events).
(d) Infra hostnames: none new in sampled bundles (raw-IP data plane already known).

## THE CONCLUSION
The API removal on Nov 15 destroyed the *live* enumeration surface but **failed to
destroy the record**: Wayback's crawlers had already swept the server-rendered pages,
freezing 641 activity events, the username-claim timeline, provenance chain samples,
referral counts, and the platform's own governance and ideology texts. The opacity
was chosen after the snapshots existed. Removal ≠ deletion.
