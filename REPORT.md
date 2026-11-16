PirateFace: Architecture Report — Design Intent vs Torrent-Inherent Weakness

Tested 13-14 November 2026. Method: passive reconnaissance of pirateface.co, source review of the published client (PyPI pirateface 0.2.1-0.2.3), controlled experiments in a disposable sandbox (a hardened harness: ephemeral home, user-space networking, full syscall capture, egress through a dedicated VPN exit), and one live production download executed inside the sandbox. Every claim below carries its command and its artifact. Nothing on the analyst's host executed PirateFace code outside the sandbox; the host was integrity-baselined and watched throughout (no drift, no escape indicators).

PART 1 — WHAT WAS TESTED AND HOW

Two environments. Host-safe tests: curl fetches, API probes, static file reads, a local mock server substituting for the PirateFace API, and a clean-venv control. Live test: their production client (pirateface 0.2.3) against their production servers inside a sandbox whose home was ephemeral, whose network was user-space virtualized, and whose syscalls were traced. Egress IP observed by their servers: withheld (a dedicated VPN exit address). Host-side watchers checked namespace escapes, /etc/passwd drift, SSH keys, cron, user units, and unexpected listeners on a 10-second loop.

Artifacts: evidence/pirateface-pentest-2026-11-13.md (the full test narrative, commands, and outputs), evidence/LEDGER.md (timestamped entries), evidence/api_rescue.txt, evidence/api_licenses.txt.

PART 2 — THE SEVEN MECHANISMS, WITH PROOF

1. Resident code at interpreter start.
Command: python -c "import sys; print(type(sys.meta_path[0]).__name__)"
With the package: _PatchOnImport. Clean venv control: DistutilsMetaFinder.
Mechanism: pirateface.pth contains "import pirateface._boot". .pth files execute at every interpreter start. _boot installs a sys.meta_path finder that patches huggingface_hub.file_download._download_to_tmp_and_move on import. Default-on; PF_DISABLE opt-out.
Proof it rewrites tooling: hasattr(_download_to_tmp_and_move, "__wrapped__") is True.
Not torrent-inherent: a .torrent file is inert data — the live 65 KB production torrent captured during the test contains no code sections.

2. Every download is reported to the distributor.
Command: run any download with PF_API pointed at a listener.
Observed: REQ /api/torrents?repo=bert-base-uncased (captured in the sandbox run; 2 requests for one file).
Mechanism: lookup() in client/api.py queries the distributor per repo, cached per process.
Not torrent-inherent: torrent clients talk to trackers, not to the file's distributor about your activity.

3. Fabricated third-party API responses.
Code: client transport wraps the HTTP layer; when Hugging Face answers 401 or RepositoryNotFound, or the repo is in the pirateface/ namespace, PirateFace's own answers are substituted — model info, file trees, resolve redirects (transport.py lines 44-58; responses.py).
Consequence: for repos only Pirate Face has, gated repos, and removed repos, the client sees a forged Hugging Face. The forged response carries Pirate Face's own sha256 as the fingerprint.
Not torrent-inherent: no torrent network impersonates a third-party API to your tools.

4. Selective verification — the intent evidence.
For mirrored, live-on-Hugging-Face repos, the client verifies every torrent byte against Hugging Face's own hash (hook.py lines 88-104, _matches(): SHA-256 for LFS etags, git-blob SHA-1 otherwise), and falls back to Hugging Face on mismatch. The recorded hashes matched Hugging Face's, verified 2-for-2 (captured entry manifest vs the Hugging Face tree API).
For pirateface/anonymizer-cpu-v0.1 — their own listing — the manifest is hf:false with self-recorded hashes and no second source anywhere (captured pf-only manifest; Hugging Face returns 401 for the repo).
The same codebase implements rigorous external verification and deploys it exactly where it costs the operator nothing, while withholding it exactly where it would bind the operator to its own bytes. Selectivity is a design decision. This is the distinction between "they could alter weights" (capability, proven by the poison test in Part 3) and "the architecture prevents it" (false, proven by the same test).

5. Self-referential verification accepts attacker-chosen bytes.
Poison test: a local mock standing in for the PirateFace API (identical position, identical trust) served a repo marked hf:false with a self-chosen sha256 and matching bytes. The client downloaded the poisoned file, "verified" it against the attacker-chosen hash, and reported success with no warning (sandbox run; output: DOWNLOADED OK: BACKDOORED-WEIGHTS-NOT-THE-REAL-MODEL, verified sha256 de45871d…).
Control: the same poison against a mirrored repo was rejected; real Hugging Face bytes arrived.
Conclusion: the verification chain is only as independent as its hash source. Where that source is the distributor, peer-verification protects availability, not the user.

6. Remote control without releases.
The swarm list (api/trackers) and the minimum accepted client version (api/cli, {"minVersion":"0.2.0"}) are fetched at runtime. The operator can redirect torrent traffic and lock client behavior server-side. Three releases shipped in 48 hours (0.2.1-0.2.3); 0.2.2 added bulk .torrent upload to api/torrents/restore (Bearer-key POST, directory recursion); 0.2.3 added a Hugging Face cache harvester (seed/cache.py) that enumerates every model in the user's local cache and bulk-submits complete ones — 200 per hour, an agent flag (-y), and a hardcoded terms version (2026-09-18.2) acknowledged programmatically. Mitigation noted honestly: cache submissions are hash-verified against Hugging Face before submission, and partial, gated, or unlicensed repos are skipped.

7. Agent-performed legal acts.
pirateface.co/skill.md instructs AI agents to create the seeding configuration, start seeding, and run a heartbeat that auto-picks at-risk models. The license API flags acceptFirst:true for restrictive licenses (Gemma) — the pipeline accepts terms before rescuing. License acceptance and redistribution are legal acts performed by software on the user's behalf.

PART 3 — THE LIVE PRODUCTION TEST (reported straight)

Target: pirateface/anonymizer-cpu-v0.1 (their own listing, hf:false, 7 seeders, 132 MB). Path: production client, production API, production swarm, inside the sandbox.
Result: all five files downloaded; all five sha256 hashes match their recorded values.
LICENSE 1,241 B — match. README.md 3,169 B — match. model.onnx 128,450,651 B — match. scrub.py 2,774 B — match. tokenizer.json 3,583,228 B — match.
scrub.py, read statically, never executed: a clean PII scrubber (ONNX NER, local inference, no network, no eval/exec/subprocess, declared dependencies only).
Sandbox security: zero dangerous syscalls (setns/unshare/ptrace/mount/init_module/bpf/kexec = 0 across the full trace); no namespace escapes; no host file drift. Only LAN-visible behavior: libtorrent SSDP local-peer-discovery multicast. One port flagged mid-run resolved to the test machine's own pre-existing service stack, unrelated to the subject.

So the record states plainly: in the tested sample, production serving is self-consistent and the shipped code is benign. This report does not claim poisoned bytes were observed. It claims — and demonstrates — that nothing in the architecture would stop them, that no external party could detect it if it happened, and that the operator demonstrably implements external verification everywhere it is not the accountable party.

PART 4 — DISPROOF OF "THIS COUNTS FOR ALL TORRENTS"

A torrent network, inherently: moves bytes between peers, verifies pieces against a torrent file, decays when trackers and seeds die, exposes seeders to liability for what they share. All of that is conceded as generic, with one precision: the generic exposure is "seeding copyrighted files carries risk anywhere" — not "your software accepts license contracts for you," which is an add-on.

Control group: LibreAI (github.com/Bardia323/LibreAI) — same transport, same purpose, same legal environment. Serverless index, no accounts, no leaderboard, no license automation, no code execution, no telemetry. If the flagged properties were torrent-inherent, LibreAI would exhibit them. It exhibits none.

Differential table — what remains after subtracting everything torrent-inherent:
- Resident interpreter hook: exists on no torrent network. Requires written code whose function is persistence.
- Download-function replacement inside huggingface_hub: requires written code. Its function is interception.
- Per-download activity reporting to the distributor: requires written code and a receiver.
- Impersonation of a third party's API: requires written code whose function is indistinguishability from Hugging Face.
- Self-referential verification for the operator's own catalog: requires deciding not to use the anchor the same codebase already implements.
- Runtime-swappable swarm lists and client-version floors: configuration chosen over releases.
- Agent-driven license acceptance and unsupervised seeding: policy written into shipped files.
Each property is absent from the protocol, present in the operator's stack, beneficial to the operator, and expensive to build. Properties that must be engineered in cannot be inherited from the protocol.

PART 5 — INTENT, STATED AS THE EVIDENCE SUPPORTS IT

Three signatures, all from artifacts:
1. Selectivity: external verification implemented and operated for mirrored repos; withheld for the operator's own catalog.
2. Placement: anonymity concentrated at the accountability points (PyPI author field null, domain registrant hidden, commits as help@pirateface.co, tracker/web-seed on an anonymous Hostinger box) while the marketing surface is maximally public.
3. Competence asymmetry: real engineering everywhere — hybrid v1+v2 torrents, portability checks, origin-checked writes, a self-correcting integrity ledger, a receipts culture (verify-claims, retracted baselines) — except in the accountability layer. Incompetence is indiscriminate; this is selective.
Observed behavior consistent with the design: tweet-triggered rescue of "uncensored" derivative models (poller sample: AtomicChat/DeepSeek-V4.1-Flash-1017-Uncensored-GSQ-RCO-GGUF, source:"x", 258 of 414 GB at snapshot); a browsable catalog of 1,173 entries against an advertised 669,000+ eligibility (0.18 percent); a public firehose of member download activity; leaderboard labor with a BT6/OBLITERATUS insider at rank 2 (3,538 approved submissions, 36,000 seeding points); payment rail on GoDaddy Payments (pay.pirateface.co, certificate 2026-09-01) — a merchant identity behind the anonymous front.

PART 6 — RESIDUAL UNKNOWNS

- Whether the provenance hash chain (51,971 entries, active, +838/day) is mathematically sound: unverifiable externally; the serialization is unpublished and the API caps retrieval at the latest 500 entries, so the recorded fork at seq 631 cannot be inspected.
- Whether scrub.py and model.onnx behave differently from their static appearance: dynamic analysis was out of scope for the sandbox pass and was not performed.
- Whether the web seed and torrent paths always agree byte-for-byte: tested once (consistent for the fetched set); not a longitudinal claim.
- Attribution of the Hostinger data plane and the GoDaddy merchant identity: not established.

PART 7 — CONCLUSIONS

1. PirateFace is not a plain torrent network. It is a torrent network with a resident process, a metadata authority, a telemetry channel, and an automation layer — each engineered, each benefiting the operator.
2. Its verification is real for content it does not control and self-referential for content it does. That asymmetry is implemented in code, not accidental.
3. The "protection" claimed for torrenting — peer-verification — guarantees consistency with the torrent, never correctness of the torrent. When the distributor authors the torrent, publishes the hash, and fabricates the reference metadata, peer-verification enforces the distributor's claims.
4. Therefore the dangerous properties are neither torrent-inherent nor accidental. They are design choices, demonstrable by subtraction against the protocol and against a clean-room control, and reproducible from the artifacts.
5. For users: if you use the package on models that exist on Hugging Face, the bytes are checked against Hugging Face's own hashes — that case is sound. For anything else — their own listings, rescued models, gated or removed repos, or direct torrent downloads — you are trusting one anonymous party's database and its torrents completely, with a process that runs before your Python starts and a legal surface accepted by your agents.

Retraction rule stands: any command in this report failing on your machine, post the output and the corresponding claim is withdrawn.

Receipts: evidence/LEDGER.md, evidence/pirateface-pentest-2026-11-13.md (the poison test reproduced end-to-end, with commands and outputs), evidence/api_licenses.txt, evidence/api_rescue.txt, evidence/catalog_all.json, evidence/INDEX.json.
