# Pliny → PirateFace: the full audit

Independent, reproducible audit of **PirateFace** (pirateface.co), **Pliny the Liberator** (L1B3RT4S, CL4R1T4S), the **OBLITERATUS** Hugging Face organization, and the **BASI Discord** (65,910 members) — selective verification, telemetry architecture, the registry trail, patronage, and the enforcement environment around the open-weights commons. **Every claim carries a command. Fifteen minutes, no trust required.**

## Start here

1. **Read** [`ARTICLE.md`](ARTICLE.md) — the case in eleven sections: the 96 hours, the seven mechanisms, the playbook match (Hansa / EncroChat / KAT / Prenda), the rescue theater, the two gates, the bill.
2. **Verify** [`REPRODUCTION.md`](REPRODUCTION.md) §1 — fifteen minutes of live checks against primary sources. Nothing requires trusting this repository's author.
3. **Frozen claims** — `sha256sum -c evidence/MANIFEST.sha256`, then follow §2 of the manual for the sealed surfaces (the subject removed its public API ~36 hours after the catalog snapshot; the freeze and the removal are both documented).

## Contents

| File | What it is |
|---|---|
| `ARTICLE.md` | The synthesis: the machine, the playbook match, the rescue theater, the two gates, the bill, the inventory of chosen opacities |
| `REPORT.md` | The technical audit: seven mechanisms, the poison test, one live production download |
| `REPRODUCTION.md` | Every command in runnable order, live + frozen |
| `evidence/LEDGER.md` | The timestamped receipts spine |
| `evidence/INDEX.json` | Weight-provenance anchors: 27 repositories / 670 LFS sha256 oids frozen 2026-11-15 |
| `evidence/` | Catalog snapshot (1,173 ids), rescue-API and license-API captures, pentest narrative, Wayback archaeology (641 recovered events + leaderboard + 20 username-claim timestamps), Delaware registry sweep, HN thread capture, avatar exhibit |

## The retraction rule

Any command in the audit or manual failing on your machine: post the full output, and the corresponding claim is **withdrawn**. Three claims have been withdrawn under this rule; the withdrawals, their provenance, and the primary-source verification of one retraction are all in the ledger.
