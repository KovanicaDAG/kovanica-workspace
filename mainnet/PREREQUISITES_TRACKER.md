# Mainnet Genesis Prerequisites Tracker

> **Status**: TRACKING — Update as items complete
> Target: Governance sign-off before ceremony scheduling.

---

## Prerequisites Checklist (from GENESIS_PLAYBOOK.md §1)

| # | Prerequisite | Owner | Target Date | Status | Evidence/Notes |
|---|--------------|-------|-------------|--------|----------------|
| 1 | RFC-006 tokenomics stable on testnet ≥30d | Core | 2026-10-26 | ⬜ | Activated 2026-09-26; need 30 days |
| 2 | PoA consensus validated ≥2 authority rotations | Core | 2026-11-26 | ⬜ | First rotation at T+180d? |
| 3 | KVP-101 Multisig audited & battle-tested | Security | 2026-10-15 | ⬜ | Used in testnet treasury |
| 4 | KVP-102 Multi-asset audited | Security | 2026-10-15 | ⬜ | Live on mainnet web |
| 5 | KVP-103 Stealth + Script v2 audited | Security | 2026-10-20 | ⬜ | |
| 6 | KVP-104 HTLC audited | Security | 2026-10-20 | ⬜ | |
| 7 | KVP-105 Vault/CSV audited | Security | 2026-10-20 | ⬜ | Testnet treasury uses these |
| 8 | Security audit (crypto, P2P, consensus, supply) | External | 2026-11-01 | ⬜ | RFP to audit firms |
| 9 | Community governance approval | Governance | 2026-11-15 | ⬜ | Proposal + vote |
| 10 | Legal/compliance review | Legal | 2026-11-15 | ⬜ | Jurisdiction analysis |
| 11 | Monitoring/alerting deployed (Grafana, Loki) | Infra | 2026-10-31 | ⬜ | Extend testnet stack |
| 12 | Incident response runbook rehearsed | Ops | 2026-11-15 | ⬜ | Tabletop exercise |

---

## Ceremony Preparation (GENESIS_PLAYBOOK.md §4 Phase 0)

| # | Task | Owner | Target Date | Status | Notes |
|---|------|-------|-------------|--------|-------|
| 13 | Elect 7 genesis signers | Governance | T-30d | ⬜ | See AUTHORITY_KEY_CEREMONY.md |
| 14 | Elect 7 initial validators | Governance | T-30d | ⬜ | Testnet operators preferred |
| 15 | Select 3 witness auditors | Governance | T-30d | ⬜ | Security firms |
| 16 | Freeze code: tag `mainnet-genesis-rc1` | Core | T-7d | ⬜ | All repos: protocol, node, cli, web |
| 17 | Reproducible builds (node, cli) | Core | T-7d | ⬜ | Docker/guix? |
| 18 | Publish binary hashes (SHA256) | Core | T-7d | ⬜ | Transparency log |
| 19 | Distribute binaries + verify instructions | Coordinators | T-1d | ⬜ | Secure channel |

---

## Infrastructure Setup

| # | Component | Owner | Target Date | Status | Notes |
|---|-----------|-------|-------------|--------|-------|
| 20 | DNS: seed1.mainnet.kovanica.online | Infra | T-7d | ⬜ | Grey-cloud only |
| 21 | DNS: seed2.mainnet.kovanica.online | Infra | T-7d | ⬜ | Grey-cloud only |
| 22 | DNS: seed3.mainnet.kovanica.online | Infra | T-7d | ⬜ | Grey-cloud only |
| 23 | DNS: api.mainnet.kovanica.online | Infra | T-7d | ⬜ | Orange-cloud OK (HTTP) |
| 24 | DNS: explorer.mainnet.kovanica.online | Infra | T-7d | ⬜ | Orange-cloud OK |
| 25 | Seed VPS provisioning (3x) | Infra | T-7d | ⬜ | 4CPU/8GB/200GB min |
| 26 | Validator VPS provisioning (7x) | Validators | T-1d | ⬜ | Operator responsibility |
| 27 | Monitoring stack (mainnet) | Infra | T-1d | ⬜ | Separate from testnet |
| 28 | Alerting rules (block lag, peer loss, sync) | Ops | T-1d | ⬜ | PagerDuty integration |

---

## Ceremony Execution Dependencies

| # | Dependency | Blocks | Notes |
|---|------------|--------|-------|
| A | All 7 genesis signer pubkeys collected | Phase 1, 2 | Offline generation |
| B | All 7 validator authority pubkeys collected | Phase 3 | On production servers |
| C | Multisig script hash computed & verified | Phase 2 | 5-of-7 |
| D | Genesis transaction assembled & signed | Phase 2 | 5+ signatures |
| E | 3 seed nodes deployed with genesis | Phase 3 | Pre-loaded |
| F | 7 validators configured & connected | Phase 3 | KOVANICA_CONSENSUS=poa |

---

## Go/No-Go Criteria (Ceremony Day T-0)

| Criterion | Check Method | Pass Threshold |
|-----------|--------------|----------------|
| All 7 signer pubkeys verified | Each signer confirms | 7/7 |
| All 7 validator pubkeys verified | Each validator confirms | 7/7 |
| Multisig hash matches all | Independent computation | 7/7 signers agree |
| Genesis block dry-run on testnet | Deploy to testnet fork | Identical genesis hash |
| Seed nodes sync to each other | P2P connectivity test | 3/3 connected |
| Validators produce blocks | 2 slots observed | 2/2 slots |

---

## Post-Genesis Verification (First 24h)

| Check | Command | Expected | Owner |
|-------|---------|----------|-------|
| Genesis hash identical | `curl /api/head \| jq .genesis` | All 10 nodes match | Coordinators |
| Supply = 90.2M cap | `curl /api/head \| jq .supply` | 9020000000000000 | Coordinators |
| Fee burn = 75% | `curl /api/head \| jq .fee_burn_ratio` | 0.75 | Coordinators |
| Coinbase maturity = 100 | `kovanica-cli check-maturity` | 100 blocks | Coordinators |
| 10 treasury vaults | `kovanica-cli vault list` | 10 vaults, 1M each | Coordinators |
| Founder timelock = 525600 | `kovanica-cli output inspect` | CSV=525600 | Coordinators |
| Block production rate | Monitor 1h | ~30 blocks/h (120s) | Ops |
| No orphan blocks | Monitor 1h | 0 orphans | Ops |

---

## Risk Register

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Signer key leak pre-ceremony | Medium | Critical | Air-gapped gen, immediate replacement |
| Validator offline at T+0 | Medium | High | Standby validators recruited |
| Genesis hash mismatch | Low | Critical | Dry-run on testnet fork |
| P2P partition (Cloudflare) | Medium | High | Grey-cloud DNS only for :9000 |
| Legal injunction | Low | Critical | Pre-launch compliance review |
| Audit findings (critical) | Medium | High | 30-day remediation window |

---

## Sign-Off

| Role | Name | Signature | Date |
|------|------|-----------|------|
| Lead Coordinator | | | |
| Security Lead | | | |
| Legal Counsel | | | |
| Governance Chair | | | |

---

*Last updated: 2026-09-26*  
*Next review: Weekly until T-30d, then daily*