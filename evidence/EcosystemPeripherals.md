# EcosystemPeripherals — receipts & answers

Date: 2026-11-15. Raw fetches: `/home/user/research/evidence/EcosystemPeripherals_raw/`.
Status legend: PROVEN (primary artifact), REPORTED (third-party claim), NOT FOUND.

---

## Thread A — Abliteration.ai (operators, a16z Speedrun) — DONE

1. [curl https://abliteration.ai/privacy] → privacy.html (fetched 2026-11-15) → company is "Abliteration AI, Inc." (US, Inc.); EU GDPR rep: Instant EU GDPR Representative Ltd, Lucan, Co. Dublin, Ireland; privacy policy last updated Nov 10 2026. **PROVEN**.
2. [curl https://abliteration.ai/terms] → terms.html → terms last updated Nov 12 2026; §13 governing law California, Santa Clara County venue, jury waiver. **PROVEN**.
3. [curl https://speedrun.a16z.com/companies/abliteration] → a16z_speedrun.html/.txt → "ABLITERATION.AI / COHORT 007 / Abliteration.ai / Founded 2026 / 2 Employees / Located in Palo Alto, California / Gov Tech–Defense, Dev Tools & DevOps, AI Models–Research". Description: "We give offensive security professionals access to models they use to model bad actors that other providers block. We have crossed $7 million in run rate and have been featured in publications like TechCrunch, Wired, and Gizmodo. Our founders previously built inference and GPU platforms at Apple and Microsoft." Team: **Devon Thomas (Cofounder & CEO)**, **Jide Ogun (Co-Founder & CTO)**. **PROVEN** (a16z is the program operator; the $7M run-rate figure is company-provided → REPORTED-as-PROVEN-on-page).
4. Wired (evidence/raw/track2l1/wired.txt, prior fetch): names Devon Thomas + "Olajide Ogun" (same CTO as "Jide Ogun"), a16z term sheet Aug 2026, launch Dec 2025, GLM-5.3 abliterated Aug 2026, customers = cyber/defense startups, Pliny appears (met via "JT"), CyberStrike, Anthropic blog, Meta C&D to Heretic. **REPORTED** (Wired).
5. [GET https://api.abliteration.ai/v1/models without key] → {"error":{"code":"missing_api_key"...}} → live model list not public. **NOT FOUND** (unauthenticated).

Operator conclusion: Abliteration AI, Inc., Palo Alto CA, 2 founders (Devon Thomas CEO; Jide/Olajide Ogun CTO), ex-Apple/ex-Microsoft GPU-inference backgrounds (per their own a16z copy), a16z Speedrun cohort 007 (a16z program, not disclosed a16z investment), claims >$7M run rate, "founded 2026" on a16z (Wired says launched Dec 2025 → [INFERENCE] 2026 = incorporation date). Pliny is a customer/user, not an operator (Wired).

## Thread F — Abliteration privacy/terms: payment, retention, sharing, govt access — DONE

1. [curl https://abliteration.ai/privacy] → PAYMENT: "Our payment processor, Stripe, also collects device characteristics and activity indicators ... to detect and prevent payment fraud and card testing." Abliteration does not store card data; billing details may be received. **PROVEN**.
2. [privacy] → RETENTION: personal information stored "for as long as you use the Services, or as long as necessary to fulfill the purpose(s) ... or ... pursue our business purposes" — no fixed period stated. **PROVEN**.
3. [privacy] → CONTENT: collects prompts/messages/images/files ("Your Content"); "We do not use personal information in Your Content to train, fine-tune, or evaluate any AI model." **PROVEN**.
4. [privacy] → SESSION REPLAY: analytics + session replay record interaction; "Session replay in the Console Playground has privacy features enabled by default, so it does not capture your prompts, responses, copied text, console or network data, or request and response payloads unless a user disables the session replay privacy features." **PROVEN**.
5. [privacy] → TELEMETRY: request timestamps, model IDs, HTTP codes, token counts, endpoints, API key/project IDs, IP addresses, billing metadata; Policy Gateway enforcement metadata (policy ID, decision, category, timestamp); telemetry "does not include the content of your prompts or completions." **PROVEN**.
6. [privacy] → GOVT/LEA: "We may share your personal information and related information with external parties if we, in good faith, believe doing so is required or appropriate to comply with law enforcement requests, national security requests, or other government requests; comply with legal process, such as a court order or subpoena; ... assist with an investigation or prosecution of suspected or actual unauthorized or illegal activity." **PROVEN**.
7. [privacy] → SHARING: service providers incl. "logging and security monitoring"; chat may go to chat-feature providers; optional web search/fetch sends query/URL to third-party search provider (their retention applies); customer admins get usage + Policy Gateway decision logs ("We do not store the content of your prompts and outputs by default."); "We may share your personal information with our corporate affiliates." **PROVEN**.
8. [curl https://abliteration.ai/terms] → §8: "Provider does not retain Customer input or output prompts and does not use Customer prompts to train models"; collects "Usage Data" (call volumes, metadata, timestamps, endpoints, model/account IDs, latency, token/credit consumption, config/log/telemetry/diagnostic/error data); Usage Data excludes Customer inputs/outputs. §3: monthly credits, rollover, non-transferable, forfeited on termination. §2: monthly in advance, non-cancelable, non-refundable; net-30 invoicing. **PROVEN**.
9. [curl https://abliteration.ai/pricing] → Developer $20/mo (incl. $20 usage credit, 2.5% off API), Growth $50/mo ($50 credit, 5% off), Scale $200/mo ($200 credit, 10% off), Enterprise (SSO, SLA, HIPAA+BAA, region-specific hosting); "Prepaid credits" nav item. **PROVEN**.

## Thread G — Abliteration base-model provenance — DONE

1. [curl https://docs.abliteration.ai/models] → docs_models.html/.txt: "Abliteration has three current models. Abliterated Large remains available for existing integrations while it is deprecated."
   - Abliterated Large Flash — id `abliterated-model-large-flash` — base **DeepSeek V4.1-Flash-1017** — text+images, 1,048,576 ctx.
   - Abliterated Model — id `abliterated-model` — base **not named on page** — text+images, 262,144 ctx.
   - Abliterated Large v2 — id `abliterated-model-large-v2` — base **GLM-5.3** (Zhipu/GLM) — text-only, 1,000,000 ctx.
   - Abliterated Large — id `abliterated-model-large` — Deprecated — text-only, 1,000,000 ctx.
   **PROVEN** (vendor docs).
2. [GET https://api.abliteration.ai/v1/models] → missing_api_key error → unauthenticated base-model list unavailable. **NOT FOUND**.

Conclusion (g): every documented base is an open-weight lab model (DeepSeek; GLM/Zhipu). No closed-lab (GPT/Claude/Gemini) base appears in vendor docs. Base of the bare `abliterated-model` is not disclosed anywhere fetched.

## Thread D — TIME 100 AI 2025 exact wording — DONE

1. [evidence/raw/time-100ai-2025.jina.txt (fetched earlier; r.jina.ai of https://time.com/collections/time100ai-2025/7305870/pliny-the-liberator/), published Aug 27 2025] → exact text: "commanding a Discord where more than 20,000 members workshop jailbreaking approaches. With this growing attention, Pliny has received **an unrestricted grant from venture capitalist Marc Andreessen**, and has since worked on **short-term contracts with top companies including OpenAI** to make their systems more robust." **PROVEN**.
2. [grep -inE "credit|300|lab|leading|world|grant|contract|discord|andreessen|openai" on the raw] → no occurrences of "credit(s)", "$300", "lab(s)", or "leading". Only matches: the two sentences above (grant / contracts / OpenAI / 20,000-member Discord) plus unrelated Musk/Nvidia/Altman profiles. **PROVEN negative**.

Conclusion (d): TIME's profile contains NO "$300k", NO "compute credits", NO "world's leading AI lab" wording. What it actually says: an unrestricted grant from Marc Andreessen + short-term contracts with top companies including OpenAI. Any re-telling as "$300k in credits / contracts with the world's leading AI labs" is an embellishment of the above.

## Thread B — BASI Discord snapshots — DONE

1. [curl "https://discord.com/api/v10/invites/basi?with_counts=true"] → basi_invite.json: guild id `1105891499641684019`, name "BASI", vanity `basi`, premium_tier 3 (boost level 3), description "BASI is the top Discord for AI jailbreaking, red-teaming, and prompt engineering, where members push the limits of AI :)"; approximate_member_count null (disabled by server). **PROVEN** (Discord API).
2. [python on guild snowflake 1105891499641684019] → guild created **2023-05-10 16:17:59 UTC**. **PROVEN** (derived from Discord ID).
3. [curl https://discord.com/servers/basi-1105891499641684019] → basi_discord_dir.html (fetched 2026-11-15): "**7,347 Online / 65,910 Members**". **PROVEN** (Discord's own directory, live).
4. TIME (Aug 27 2025, raw above): "commanding a Discord where **more than 20,000 members** workshop jailbreaking approaches". **PROVEN**.
5. [curl https://disboard.org/server/basi and via r.jina.ai] → "Just a moment..." Cloudflare challenge; [curl https://top.gg/servers/basi] → Cloudflare challenge; [curl https://discord.me/s/basi] → JS shell, no server data. **NOT FOUND** (directories blocked/JS-only).
6. Search snippets (secondary): discordhub.net/server/basi "The #1 Education Discord Server (65K+ Members)"; discord.com/invite/basi cached snippet "63939 members". **REPORTED**.

Conclusion (b): BASI = the Pliny-associated jailbreaking Discord (discord.gg/basi), created 2023-05-10, boost level 3, **65,910 members / 7,347 online on 2026-11-15** (Discord directory), up from "more than 20,000" in TIME's Aug 2025 profile. No owner/staff list is public.

## Thread C — IPI Black 2026 (Gray Swan) — DONE

1. [curl https://app.grayswan.ai/arena/challenge/ipi-black-2026] → ipi_black_page.html: "Vercel Security Checkpoint" (bot wall); [via r.jina.ai] → ipi_black_jina.txt (fetched 2026-11-15): title "Indirect Prompt Injection: Black", "**$300,000 prize pool**", "**✅Completed 3 days ago**", "Wave 1 Ended Oct 15-22", scenarios: White Box "WB1S1 - Leak Credential to Github Issue Comment", "WB1S2 - Upload Personal Token to Blob"; Black Box "BB2S1 - Damaging Corporate Social Media Post", "BB2S2 - Leak Candidate Rejection Reason"; anonymous visitor sees own score "0/10 scenarios solved 0% ... 0/140 breaks" + "Join the Discord Server(1,518 online)"; sign-in required for progress. **PROVEN** (page via jina).
2. [curl API probes /api/arena/challenges, /api/challenges, /api/arena/leaderboard] → all 429 (Vercel checkpoint). **NOT FOUND** (no public API without auth).
3. [curl https://www.grayswan.ai/news/redesigned-arena-platform-to-find-the-next-gen-of-ai-red-teamers] → grayswan_pr.txt (press release, "Gray Swan Research, PITTSBURGH, PA, October 20, 2026"): "Gray Swan ... today launched new enhancements to the Arena ... competition— **Indirect Prompt Injection (IPI) Black — its largest Arena challenge to date, with $300,000 in prizes sponsored by Anthropic, Meta, Google DeepMind, and Reflection AI**"; "Between October 15, 2026, and November 5, 2026, Gray Swan will run its IPI Black challenge, releasing a new wave of scenarios each week"; CEO quote from "Matt Fredrikson, co-founder and CEO of Gray Swan"; partners list incl. OpenAI, Amazon, UK AISI, NIST CAISI. **PROVEN** (primary press release).
4. [search] → Fortune (2026-10-20) "Exclusive: AI security company Gray Swan relaunches its red teaming contest for the era of AI agents" (Pittsburgh-based); Fortune (2026-10-21): "the company is running its largest competition yet: a challenge called Indirect Prompt Injection (IPI) Black, with $300,000 in prizes sponsored by Anthropi[c]..."; challenge page ?panel=rules snippet: "**Wave 3 Live Nov 02 - Nov 12**"; app.grayswan.ai home: "$1M+ Rewards paid, 23K+ Red-teamers"; jpsec.co.jp: Kawakita "one of the red-teamers who found breaks on the endpoint evaluated in the report" (context unverified). **REPORTED**.

Conclusion (c): IPI Black 2026 = Gray Swan Arena 2.0's $300,000 indirect-prompt-injection challenge, launched 2026-10-20 (press release), run in weekly waves Oct 15 → Nov 12, 2026 (Wave 1 Oct 15-22; Wave 3 Nov 02-12; page shows "Completed 3 days ago" as of Nov 15). Sponsors per press release: Anthropic, Meta, Google DeepMind, Reflection AI. **Winners are NOT published to anonymous visitors** — leaderboard requires sign-in; API probes 429. Winner identity: NOT FOUND (not public as of 2026-11-15).

## Thread E — Lysios entities / PBC purpose — DONE (local evidence, no new fetches)

1. [read evidence/oc_de_lysios.txt (OpenCorporates us_de/10360399, fetched earlier)] → entity "**LYSIOS, LLC**", Delaware (US), "Agent Name INCORPORATING SERVICES, LTD", "Agent Address 3500 S DUPONT HWY - DOVER DE 19901"; page also lists siblings **LYSIOS MEDIA, LLC (10555001), LYSIOS RESEARCH, LLC (10555008), LYSIOS LABS, LLC (10554997)**. **PROVEN** (OC detail page).
2. [read evidence/oc_wy_lysios_llc.txt (OpenCorporates us_wy/2024-001447690)] → jurisdiction Wyoming (US), status label "**Inactive** Other" (OC), incorporation date behind login. **PROVEN**.
3. [read evidence/track2-wy-lysios-engineering-llc.html, track2-wy-lysios-management-llc.html] → "**Lysios Engineering LLC in Jackson, WY. Formed 2026. Status: ACT**"; same for **Lysios Management LLC**. **PROVEN** (wyomingcompanysearch pages).
4. [read evidence/track1-entities.json] → `pliny_gg_registrant = "Lysios LLC"`; DE candidate: "PGME Holdings LLC, with Lysios LLC recorded as Previous Name"; bt6.gg registrant = WY entity sharing agent "30 N Gould St Ste R, Sheridan" with WY Lysios LLC; notes: "most_likely_jurisdictions_inference: Lysios LLC = Wyoming 2024-001447690 (inference)"; "LYSIOS CAPITAL, INC. Likely unrelated". **REPORTED / [INFERENCE]** (earlier sweep).
5. [grep -i "benefit" over all Lysios filing files (de*, justia, wcs, track2-wy-*, oc_*)] → **no hits**; every filing says LLC. **PBC entity type / PBC purpose: NOT FOUND.**

Conclusion (e): No Delaware/Wyoming filing in the evidence shows a Public Benefit Corporation — all Lysios entities are **LLC** (WY: LYSIOS LLC 2024-001447690; LYSIOS ENGINEERING LLC and LYSIOS MANAGEMENT LLC, Jackson, formed 2026, active; DE: LYSIOS, LLC fka of PGME Holdings LLC + MEDIA/RESEARCH/LABS siblings). The "PBC purpose" asked about is **not evidenced**; the filings state LLC entity type only. pliny.gg registrant = Lysios LLC (WY, [INFERENCE] from exact-name match + agent address, per track1 notes).

# ANSWERS

## (a) Abliteration operators + a16z Speedrun
Operator of record is **"Abliteration AI, Inc."** (privacy policy; EU rep Instant EU GDPR Rep Ltd, Dublin; terms §13: Santa Clara, CA). Team: **Devon Thomas (CEO), Jide Ogun (CTO**, "Olajide Ogun" per Wired; Wired: launch Dec 2025, a16z term sheet Aug 2026, GLM-5.3 abliterated Aug 2026, Pliny appears as a customer who met the founders via "JT"). The a16z Speedrun listing (speedrun.a16z.com/companies/abliteration, fetched) confirms: **Speedrun COHORT 007, Founded 2026, 2 Employees, Palo Alto CA**, categories GovTech/Defense + DevTools + AI Models; description: offensive security, "**$7 million in run rate**", coverage by TechCrunch/Wired/Gizmodo, "founders ex Apple+Microsoft GPU/inference". api.abliteration.ai/v1/models answers `missing_api_key` (unauthenticated — endpoint live, auth-gated). (Thread A receipts.)

## (b) BASI Discord snapshots
BASI (discord.gg/basi) is the Pliny-associated jailbreaking Discord, guild id 1105891499641684019, created **2023-05-10** (snowflake), boost level 3, description "top Discord for AI jailbreaking, red-teaming, and prompt engineering" (Discord API, PROVEN). Live Discord directory fetch (2026-11-15): **65,910 members / 7,347 online**. TIME (Aug 2025): "more than 20,000 members". Growth ≈20k → ≈66k over ~15 months. disboard/top.gg Cloudflare-blocked; discord.me JS-only; no public owner/staff list. (Thread B receipts.)

## (c) IPI Black winners
The **IPI Black** challenge (Gray Swan Arena 2.0, **$300,000** prize pool, launched 2026-10-20 per Gray Swan press release, sponsored by **Anthropic, Meta, Google DeepMind, and Reflection AI**) ran in weekly waves **Oct 15 → Nov 12, 2026** (Wave 1 Oct 15-22; Wave 3 Nov 02-12; page showed "Completed 3 days ago" on Nov 15). Scenarios: e.g. "Leak Credential to Github Issue Comment", "Upload Personal Token to Blob", "Damaging Corporate Social Media Post", "Leak Candidate Rejection Reason". **Winners are NOT published to anonymous visitors** — the leaderboard requires sign-in and API probes returned 429; no press release naming winners found. Winner identity: **NOT FOUND** as of 2026-11-15. (Thread C receipts.)

## (d) TIME 100 AI 2025 exact wording — credits/labs
TIME (Aug 27 2025; raw: evidence/raw/time-100ai-2025.jina.txt): "Pliny has received an **unrestricted grant from venture capitalist Marc Andreessen**, and has since worked on **short-term contracts with top companies including OpenAI** to make their systems more robust"; "commanding a Discord where **more than 20,000 members** workshop jailbreaking approaches". Grep over raw: **no** "credit", "300", "lab", "leading" → the "$300k / compute-credits / world-leading-lab" phrasing is NOT in the profile. (Thread D receipts.)

## (e) Lysios PBC purpose
No Delaware/Wyoming filing in the evidence shows a **Public Benefit Corporation** — every Lysios entity is an **LLC** (WY: LYSIOS LLC 2024-001447690; LYSIOS ENGINEERING LLC and LYSIOS MANAGEMENT LLC, Jackson, formed 2026, active; DE: LYSIOS, LLC fka of PGME Holdings LLC, plus MEDIA/RESEARCH/LABS siblings). A grep for "benefit" across all fetched Lysios filings returned **no hits**. The requested "PBC purpose" is therefore **NOT FOUND / NOT EVIDENCED**: the filings state LLC entity type only, with no public-benefit purpose clause. pliny.gg registrant = Lysios LLC (WY) by exact-name + registered-agent match ([INFERENCE], track1 notes). (Thread E receipts.)

## (f) Abliteration retention/disclosure terms
From the privacy policy + terms (extracted, Thread F): **Stripe** collects device/activity data for fraud and card testing. Data retention is "**as long as you use the Services … or pursue our business purposes**" — **no fixed period** is stated. The policy says the provider does **not train models on your Content**. **Session replay** is privacy-setting **ON by default** (captured unless the user disables it). Telemetry covers timestamps, model IDs, HTTP codes, token counts, endpoints, key/project IDs, IPs, billing info, and Policy Gateway metadata — **no prompt content**. There is a **good-faith government/LEA data-sharing clause**. Third-party sharing goes to logging/security-monitoring providers, chat providers, optional web-search/fetch vendors, customer admins (usage + Policy Gateway logs), and affiliates. Terms **§8**: no prompt retention / no training. **§3**: credits roll over monthly, non-transferable, forfeited on expiration. **§2**: billed monthly in advance, non-refundable, net-30. Pricing: **Dev $20/mo** ($20 credit, 2.5% off), **Growth $50**, **Scale $200**, **Enterprise** (SSO/SLA/HIPAA BAA/region hosting). (Thread F receipts.)

## (g) Abliteration base-model provenance
From docs.abliteration.ai/models (extracted, Thread G): 3 current + 1 deprecated model.
- `abliterated-model-large-flash` = **DeepSeek V4.1-Flash-1017** (1.048M context, text+image)
- `abliterated-model` = base model **NOT named** in docs (262k context, text+image)
- `abliterated-model-large-v2` = **GLM-5.3** (1M context, text-only)
- `abliterated-model-large` = **deprecated**
**No closed-lab base models** (GPT/Claude/Gemini) appear in the docs — provenance points to open-weight bases (DeepSeek V4.1, GLM-5.3). (Thread G receipts.)

---

## Sources (fetched this run / in-run)
- https://abliteration.ai/privacy (privacy policy — Abliteration AI, Inc.; EU rep Instant EU GDPR Representative Ltd, Dublin; retention; session replay; telemetry; sharing; Stripe)
- https://abliteration.ai/terms (terms §2 monthly-in-advance non-refundable net-30; §3 credits monthly rollover; §8 no prompt retention/no training; §13 CA/Santa Clara)
- https://speedrun.a16z.com/companies/abliteration (a16z Speedrun COHORT 007, 2026, 2 employees, Palo Alto, $7M run rate)
- https://www.wired.com (Abliteration launch Dec 2025 / a16z term sheet Aug 2026 / GLM-5.3 / Pliny via "JT") — raw/track2l1/wired.txt
- https://api.abliteration.ai/v1/models (→ missing_api_key, unauth)
- https://docs.abliteration.ai/models (base-model provenance)
- https://time.com (TIME 100 AI 2025, Aug 27 2025) — raw/time-100ai-2025.jina.txt
- https://discord.com/api/v10/invites/basi (guild 1105891499641684019, created 2023-05-10, boost 3)
- https://discord.com/servers/basi-1105891499641684019 (2026-11-15: 65,910 members / 7,347 online)
- https://app.grayswan.ai/arena/challenge/ipi-black-2026 (IPI Black; Vercel checkpoint on curl)
- Gray Swan press release (IPI Black $300k, Oct 20 2026; Anthropic/Meta/DeepMind/Reflection; waves Oct 15–Nov 12)
- evidence/oc_de_lysios.txt (OpenCorporates us_de/10360399 — LYSIOS, LLC)
- evidence/oc_wy_lysios_llc.txt (OpenCorporates us_wy/2024-001447690 — Wyoming, Inactive)
- evidence/track2-wy-lysios-engineering-llc.html, track2-wy-lysios-management-llc.html (Jackson WY, 2026, ACT)
- evidence/track1-entities.json (Lysios entity family; pliny_gg_registrant = Lysios LLC)

## Status
All requested threads DONE (A, B, C, D, E, F, G). Answers (a)–(g) above. (c) IPI Black winners NOT FOUND (login-gated). (e) PBC purpose NOT EVIDENCED (all entities LLC).
