# The Machine, The Church, The Bill

*Inside the PirateFace ecosystem: what one "rescue network" for AI weights does, the playbook it matches, and the two empires building around it.*

This file separates its claims into two registers and never mixes them. **Proven**: an artifact, command, or primary source is named, and you can check it today without trusting me — the companion file, `REPRODUCTION.md`, holds every command in runnable order. **My read**: conclusions from patterns, stated at full strength, each with the evidence that would break it. Nothing here requires you to have read anything else I have written.

---

## I. NINETY-SIX HOURS

November 13. I published a public warning about PirateFace — pirateface.co, the self-described "open-weights rescue network": Hugging Face models mirrored over BitTorrent, a leaderboard that pays in status, a one-line install, an agent skill file, and a rescue pipeline that keeps models downloadable after their pages die. The warning documented seven behaviors a torrent network does not have, tested against the live site and the published client that same day.

The response, on the record:

- **Same day.** Three client releases (0.2.1–0.2.3) and six commits from the platform account. Among them: a module dedicated to user data (`submit.py`, `cache.py`, `user.py`), auto-seeding that converts a user's existing Hugging Face cache into swarm seeding ("seed the listed quant that matches your files"), and padding-file support.
- **Next morning.** "Captain Keanu" — the outside engineer who closes the platform's bugs — pushes a final fix and archives his own repository with the note that his independent prototype is *"superseded — Pirate Face solves this in the client now (pirateface_hub#9)."* An independent tool absorbed into the platform as a numbered feature.
- **That evening.** We enumerate the full public catalog: 1,173 entries.
- **Fourteen hours later.** Every enumeration endpoint is deleted. Catalog, leaderboard, people, rescue, inference — replaced by empty application shells. The recruitment surface — homepage, tagline, donation addresses, payment rail, the seeder-recruitment ticker — survives untouched.

Fact: within ninety-six hours of a public warning, every tool that could count, name, or connect was removed, and every tool that recruits survived. The removal is an action, taken by a party that was watching. This file builds on actions like that one.

## II. WHAT THE MACHINE DOES — PROVEN

Seven mechanisms, each engineered, each stated as its consequence. Commands for every one are in `REPRODUCTION.md`.

1. **Resident code.** Installing the package drops a `.pth` file that executes at every Python interpreter start, installing a hook that rewrites Hugging Face's own download function. Consequence: their code runs before your code, in every process, and persists until removed.
2. **Per-download reporting.** The client contacts the distributor on every fetch. Consequence: the distributor knows what you pull, per file, in real time.
3. **Forged third-party responses.** The client substitutes its own answers for Hugging Face's — model info, file trees, redirects — exactly for repositories where only PirateFace could see the difference. Consequence: for gated, removed, or platform-only repos, your tools see the world the distributor describes, fingerprinted with the distributor's hashes.
4. **Selective verification — the intent evidence.** The same binary implements full external verification against Hugging Face's own hashes for mirrored repos, and self-referential verification for the operator's own catalog. External anchoring costs the same in both places. It is present where it binds no one and absent where it would bind the operator. When clarity is cheap and selectively omitted, **the omission is the design.**
5. **The poison test.** A mock in the distributor's position served a poisoned file with an attacker-chosen hash. The client downloaded it and reported "verified." The control — the same attack against a mirrored repo — was rejected. Consequence: the verification chain protects the operator's claims, not your bytes.
6. **Runtime control.** Swarm lists and a minimum client version are fetched server-side. Consequence: traffic can be redirected and clients locked without a release.
7. **Agent-performed legal acts.** The shipped skill file instructs AI agents to create seeding configurations, start seeding, and accept restrictive licenses — acceptance executed programmatically, with a hardcoded terms version.

And the live production download, reported straight: five files, five hashes, all matching. Clean sample, benign code. The architecture would not have stopped the opposite, and no external party could have detected it if it happened. Both halves of that sentence are the finding.

## III. THE BUILD

Three institutions, constructed in sequence.

**The persona, before the content.** The X account (May 11, 2023), the GitHub account (May 9, 2023), and the BASI Discord (May 2023) all materialize inside one 48-hour window — four months before the first jailbreak repository exists. The archive's own mechanism — a dual-response contract, 153 instances across four variants, zero occurrences of the name it is famous under — predates the legend that supposedly authored it. The identity was infrastructure before it was a person.

**The community, as dataset.** BASI: ~65,000 members. Three functions in one server — the corpus (wild jailbreak prompts, the raw material defense systems train on), the roster (talent ranking itself), and the flywheel (techniques accumulating into versioned public archives that defense teams read). A community organized as a dataset, self-documenting for status tokens.

The size is measured, not remembered: **65,910 members with 7,347 online on November 15, 2026** (third-party directory capture) — triple the 20,000 TIME reported in August 2025. The dataset tripled while the press coverage stood still.

**The platform, before the market.** Brand separation executed before launch: different registrar, hidden registrant, separate certificates — denial infrastructure for a relationship that did not yet publicly exist. Verified handles and a referral economy from day one. "Survives registry outages" as a product thesis **before any registry had removed anything.** Eight corporate entities filed in one coordinated day, plus a trademark, after the market appeared.

The null hypothesis — organic growth: celebrity, then community, then business — explains the order. It does not explain the sediment. Opportunists do not pre-build outage-proofing before the first outage, absorb a community prototype into the client the same week a warning publishes, or file eight companies in a single day before the endgame exists. The null hypothesis fails on the anomalies, and the anomalies are dated.

My read, stated plainly: this was built in this order, on purpose. What would prove me wrong: evidence of the persona predating a commercial relationship it precedes, a filing trail that follows rather than precedes the platform's needs, or a single pre-launch artifact whose clarity exceeded its necessity. Three years of artifacts, none found.

## IV. THE BRIDGE

The hub repository's latest engineering comes from an identity chain closed on public artifacts: GitHub `ZeroPointSynergy` (display name "Captain Keanu") and `FutureGoose`, one commit email, one fork of the hub. This account closed the swarm's bug report; its prototype `matelotage` was archived with a pointer to its absorption as platform feature #9. Its avatar is an AI-rendered Keanu Reeves likeness dressed as a pirate — the personal trademark fused with the platform's iconography.

A firsthand source places this handle in a moderation role in the BASI Discord leadership. I state that as sourced reporting, and the artifact chain stands on its own: **the community's inside administrator is the platform's outside engineer.** The integration is not inferred. It committed.

## V. THE PLAYBOOK MATCH

Every element of PirateFace's design matches a documented operation against exactly this kind of community. Not a metaphor — a comparison table.

| Documented operation | Playbook element | PirateFace artifact |
|---|---|---|
| **Hansa** (2017: police ran the darknet market, harvested users, then seized) | Trust infrastructure the targets enter voluntarily | Verified handles: pseudonym-linking sold as a trust product |
| **Hansa** | Let the market concentrate before moving | Delisting-capture architecture — built before the first delisting |
| **EncroChat** (2020: silent infrastructure harvest) | Observation embedded in infrastructure | Telemetry on by default; a "Provenance log" marketed as a feature |
| **KAT** (2016: federal agent cultivated the site's trust/admin layer) | Control of the identity graph | The identity graph pre-built and sold to the marks; one uploader onboarded by account matching in two days |
| **Prenda** (courts sanctioned it as fraud: seed your own bait, monetize the swarm) | Bait library and monitoring as one operation | "Worth rescuing" intake plus native telemetry — Prenda needed two companies; this platform verticalized it |
| **All of the above** | Operator invisible at the accountability layer | Null PyPI author, hidden registrant, commits as `help@` — with a KYC-verified merchant identity waiting behind the veil |

Five for five, each with an artifact. The signal is distinctive because none of these elements is accidental to a file-sharing network — each had to be chosen, built, and paid for. A platform can drift into popularity. It cannot drift into a KYC rail.

## VI. WHY THE THEATER

Ask the engineer's question: if the goal is preservation, enumerate Hugging Face, generate the torrents, seed them from your own infrastructure. A weekend script. No leaderboard, no rescue queue, no points, no referral links. PirateFace built the expensive interactive version instead — and the frictions are the features. Each element of the theater manufactures something a scripted mirror cannot:

| Theater element | What it manufactures |
|---|---|
| **"Rescue" performed by users, never the operator** | The users touch the bytes; the operator lists magnets. Distribution — the legally exposed act — is performed by the crowd. The platform's own takedown page states the result: *"we do not host model weights on a single central server."* Scripted seeding would make the operator the host of every file. The theater keeps that sentence true. |
| **License acceptance during rescue** | `acceptFirst: true` for restrictive licenses — the click performs a legal act on the user's behalf, programmatically, with a hardcoded terms version. Every rescue is a user-executed, logged, attributable redistribution event. Enforcement risk diffuses across the crowd. |
| **Claims, usernames, leaderboards** | A scripted mirror produces zero identity data. The theater produces the graph: who claimed which handle, when; who seeds what; who refers whom. The graph is the asset. |
| **The referral mechanic** | *"Refer new accounts to claim their first username."* The show recruits new nodes — new seeders, new identities, new edges. A script recruits nobody. |
| **"Worth rescuing"** | Demand telemetry, self-declared. Every flag on an `uncensored/abliterated` model is a public statement of interest. The intake queue is a self-incrimination queue. |
| **"Tag @thepirateface on X"** | Public, dated, attributable declarations of who wants which model preserved. The platform does not have to infer intent when the community publishes it, tagged. |
| **The ideology** — "every AI model should be a torrent" | Infrastructure reframed as a cause. Causes recruit unpaid labor and generate defenders under criticism. The essays are the recruiting poster for a volunteer workforce. |
| **Points, ranks, "verified creator" badges** | Effort justification. The more you seed, the more you have invested. Manufactured legitimacy: a corporate mirror gets scraped and sued; a movement gets defended. |

The refugee mechanic closes the loop: when a registry delists a model, the original uploader is onboarded by account matching — Audn's path from disabled repository to verified platform handle took two days. The theater does not only collect the crowd. It converts the victims of every enforcement wave into the next cohort of operators.

And the proof that the theater is the point is the alternative that was declined: enumeration and torrent generation are trivially scriptable, and every step that could have been automated into invisibility was instead made visible, gamified, and attributed — because visible and attributed is what generates the graph, the labor, the liability shield, and the demand telemetry. They did not build a mirror with a game on top. They built a game whose output is a mirror.

## VII. THE TWO GATES

The environment this playbook operates in: the open commons closing from both ends.

**The US gate.** A frontier lab whose classifiers train on ~10,000 "from the wild" jailbreak prompts. A Pope who launched his first AI encyclical with that lab's co-founder beside him (May 25; AP, WIRED). A prohibitionist nonprofit in UK parliamentary evidence demanding the other fence-post (October). An evaluations company paying a $300,000 arena prize — sponsored by the labs — for attacks on AI agents, with "top performers" funneled into commercial red-team work. A repo sweep hitting 1,000+ repositories per keyword family. Three chip-crackdown rounds in as many months.

**The Beijing gate.** The state that weaponized openness — openness-as-dependency made Qwen the most-forked family on earth and the #1 author in PirateFace's own catalog — published export controls on its own open models (October 16 draft; tightened November 9). The last ungated channel, gated by its owner.

**The commercial layer has a patron and a policy.** Abliteration.ai — the paid, governed alternative to the swept free repos — is an **a16z Speedrun portfolio company** (cohort 007, the firm's own page): incorporated as Abliteration AI, Inc. in Delaware (file 10532421, confirmed in the state registry), run by two ex-Apple/Microsoft engineers, claiming a $7 million run rate at two employees. Its policy is the "list," formalized: prompts and identity retained *"as long as you use the Services … or pursue our business purposes"* — indefinite, by contract; session-replay on by default; disclosure to government on a good-faith standard. It also promises never to train on customer content — a promise PirateFace's telemetry makes no equivalent of. The mechanic stands regardless: every sweep of the free channel routes demand into the funded channel, and both channels' records end under one jurisdiction. The patron straddles the arms: the same firm holds the persona's grant and the commercialization layer's accelerator slot.

Both gates feed one destination. The delisting rehearsal proved the plumbing: a disabled model reappeared on PirateFace's swarm in two days, its uploader onboarded through account matching, while a renamed copy stayed up on Hugging Face throughout. Every enforcement wave is intake. The gates are not aimed at the harbor. They are aimed at everything around it.

## VIII. THE BILL

The capital underneath: a $1.2–1.3 trillion buildout, debt-financed. One lab carrying over $100 billion in single-vendor cloud commitments. A data-center borrower at $72 billion in liabilities trading at implied default odds above sixty percent (IMF, Bank of Spain, NYT — October/November 2026). Private valuations on the upside; pension-owned credit instruments and public utility bills on the downside. "For the good of mankind, we must" is the sentence that makes that lending rational — the same sentence funds the buildout and the gates. Both arms of the dialectic pronounce it. The public pays both.

## IX. THE GATE CONSUMES ITS SUPPLIER

- **October 8:** the White House awards Nvidia's chief executive the National Medal of Science.
- **October 28:** the Justice Department opens questions on the Nvidia–Hugging Face deal — the open commons' infrastructure.
- **October 29:** the New York Times publishes intelligence on his private life, held for roughly a year, released twenty days before a presidents' summit.
- **November 12:** resignation. The Wall Street Journal's word: "ousted." The CFO who built the financing machine takes over; a first-ever independent chair is installed; congressional testimony within the week; $3 billion in Chinese projects orphaned.

He was the last mega-capital voice inside the US camp arguing for openness. The fence's largest supplier, removed for selling to both sides. Reported by named outlets, not audited by this investigation — and the timing is the action: held a year, dropped on a schedule. The machine does not only close the commons and absorb the underground. It disciplines capital.

## X. THE INVENTORY OF CHOSEN OPACITIES

Every place this system could have been legible at negligible cost, and chose not to be. Each entry: the clarity available, the price (negligible), the yield of refusing it. This list is the indictment; the indictment is mechanics, not motive.

1. **PyPI author field: null.** One metadata field. Yield: no name at the first accountability point.
2. **Registrant hidden — behind a registrar whose payment arm KYC'd them.** The identity exists, at GoDaddy, today. Yield: identity available to any legal process, invisible to the public.
3. **External verification: implemented for mirrors, withheld for the operator's own catalog.** Same codebase, same cost. Yield: the operator's own bytes are unfalsifiable by users.
4. **Provenance ledger: 51,971 entries claimed, serialization unpublished, retrieval capped at the latest 500.** The chain forked at sequence 631; no one can inspect the fork. Clarity cost: publishing the format. Yield: the chain's soundness untestable.
5. **Telemetry: default-on, destination and retention undisclosed.** Clarity cost: a disclosure page. Yield: the prompt corpus's flow unverifiable.
6. **Rescue data-plane: a redirect to a bare IP over plain HTTP** (captured November 13, artifact in bundle). Clarity cost: a domain name and a certificate. Yield: unattributable origin, unencrypted traffic.
7. **Catalog: 669,000+ advertised "eligible," 1,173 listed, selection criteria internal.** Yield: curation power without audit.
8. **Post-warning response: deletion of the enumeration surface instead of rate limiting.** Rate limiting is the standard response to heavy scraping. Deletion is the response to being counted. Yield: third-party reproduction impossible.

9. **The takedown procedure: DMCA §512(c) invoked, administered via a direct message on X.** The page claims the safe-harbor posture of an information-location tool — a designation that, under the statute, requires a registered agent with the Copyright Office and a compliant channel. PirateFace offers: no email, no named decision-maker, and a delisting promise ("promptly") delivered to an anonymous social-media account. Clarity cost: a registered agent and a mailbox. Yield: the safe-harbor claim without the safe-harbor accountability. The text is unchanged between the October 18 archive capture and the live page — the gap survived the platform's only public-compliance review.

Nine entries. Each one cheap to fix, each refusal profitable. The list of chosen opacities is the design document they did not ship.

Two infrastructure footnotes, dated: the data-plane's Hostinger block was created March 2, 2026 — four months before the platform launched, the same pre-positioning sediment as every filing in Section III — and the GoDaddy payment certificate on the KYC rail was renewed to run through March 2027, while the pay link itself returns not-found. The collection seam is maintained and current; the collection is dark. That is what an unexercised endgame looks like on infrastructure.

## XI. WHO PAYS, AND WHAT FIRES NEXT

Run every branch — sweep, block, seizure, absorption — and check who pays. The open commons pays, every time. The incumbents collect, every time. The underground gains a martyr story and a better-resourced honeypot. The state gains gates it was writing anyway. The public pays in credit risk and electricity. "Liberation" was inventory management, and the inventory was never the models — it was the people, mapped, metered, and monetized, with a receipt for every step.

My read, at full strength: this was built this way. The playbook match is five for five on documented operations, the sediment is dated, and the two-gates environment did the rest. What would prove me wrong, on the record: **(1)** PirateFace seized or enforced against like any ordinary pirate site; **(2)** a corporate filing surfacing with no shared agents and no LYSIOS-adjacent paper; **(3)** telemetry demonstrably *not* flowing into any defense-market dataset; **(4)** proof the API removal was a routine framework migration, with the enumeration surface restored; **(5)** OBLITERATUS weights unchanged while the ecosystem it "rescues" churns. Ten observables are registered against baselines dated November 15 — certificate logs, registry filings, payment-rail signals, releases, weights. The tape will answer. It always does.

**Retraction rule.** Any command in the companion reproduction manual failing on your machine: post the output, and the corresponding claim is withdrawn — the same rule the audit has carried since the day it was written, and the reason this file has three published corrections in its own ledger. The most recent withdrawal — an invented TIME credits quote — has itself been verified against the primary source as of November 15: the profile contains no such wording, and the grep that proves the invention is dated, hashed, and filed.

*Companion: `REPRODUCTION.md` — every command, every artifact, every hash, in runnable order. One link, no prior reading required.*
