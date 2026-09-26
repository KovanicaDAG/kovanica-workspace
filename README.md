# Kovanica Protocol — Workspace Layout

This directory provides a clean separation between **developing workspace**, **active testnet**, and **dormant mainnet** environments.

## Directory Structure

```
kovanica-workspace/
├── developing/          # Active development environment
│   ├── protocol/        # → symlink to /root/kovanica/protocol (source of truth)
│   ├── node/            # → symlink to /root/kovanica/node (thin binary wrapper)
│   ├── web/             # → symlink to /root/kovanica/web/site (frontend source)
│   ├── wallet/          # → symlink to /root/kovanica/wallet (mobile wallet)
│   ├── cli/             # → symlink to /root/kovanica/cli (CLI/TUI)
│   ├── docs/            # → symlink to /root/kovanica/docs
│   ├── scripts/         # → symlink to /root/kovanica/scripts
│   ├── data/            # Local dev node data (ephemeral, reset-friendly)
│   ├── keys/            # Dev authority keys (testnet placeholders)
│   └── logs/            # Development logs
│
├── testnet/             # Active testnet (kovanica-testnet) — LIVE
│   ├── protocol/        # → symlink to /root/kovanica/protocol (same source)
│   ├── node/            # Built binary: /root/kovanica/node/target/release/kovanica-node
│   ├── web/             # Built output: /root/kovanica-web/.output (PM2: kovanica-web)
│   ├── wallet/          # Built APK/IPA artifacts
│   ├── data/            # → symlink to /root/kovanica-data (persistent node state)
│   ├── keys/            # Active authority keys (rotated per ceremony)
│   ├── seeds/           # Seed node configs (seed1, seed2)
│   ├── logs/            # PM2/journalctl logs
│   └── monitoring/      # Prometheus/Grafana configs
│
└── mainnet/             # Dormant mainnet — NOT LIVE (preparation only)
    ├── protocol/        # → symlink to /root/kovanica/protocol (same source)
    ├── node/            # Release binary (version-tagged)
    ├── web/             # Production build output
    ├── wallet/          # Signed release artifacts (App Store / Play Store)
    ├── data/            # Empty — created at genesis
    ├── keys/            # Mainnet authority keys (HSM/ceremony generated)
    ├── genesis/         # Genesis specification (RFC-006 params + authority set)
    ├── docs/            # Mainnet launch checklist, runbooks
    └── logs/            # Empty until launch
```

## Source of Truth (Canonical Repos)

| Component | Canonical Location | Purpose |
|-----------|-------------------|---------|
| **Protocol** (Rust workspace) | `/root/kovanica/protocol` | Core consensus (kovanica-dag), ledger (kovanica-state), node library, CLI, FFI |
| **Node Binary** | `/root/kovanica/node` | Thin `kovanica-node-bin` crate wrapping protocol crates |
| **Web Frontend** | `/root/kovanica/web/site` | TanStack Start + Vite + Nitro (explorer, wallet, map) |
| **Mobile Wallet** | `/root/kovanica/wallet` | UniFFI + Kotlin/Swift (Android/iOS/Extension) |
| **CLI/TUI** | `/root/kovanica/cli` | Clap-based `kovanica-cli` |
| **Android Light Node** | `/root/kovanica/android-light-node` | Jetpack Compose light client |

## Symlink Strategy

All `developing/`, `testnet/`, `mainnet/` subdirectories point to the **same canonical source** via symlinks. Only `data/`, `keys/`, `logs/`, `seeds/`, `monitoring/` are environment-specific.

```bash
# Example: developing/protocol → /root/kovanica/protocol
ln -sfn /root/kovanica/protocol /root/kovanica-workspace/developing/protocol
```

## Environment Variables by Tier

### Developing (Local Dev)
```bash
KOVANICA_POW=1                    # [CURRENT] pre-PoA
KOVANICA_MINE=0
KOVANICA_FAUCET=0
KOVANICA_ALLOW_RESET=1            # Dev-only: allow genesis reset
KOVANICA_OPERATOR=0
KOVANICA_LISTEN=127.0.0.1:9000
KOVANICA_PEERS=seed.kovanica.online:9000
KOVANICA_DATA=/root/kovanica-workspace/developing/data
KOVANICA_CONSENSUS=poa            # [TARGET] PoA default
```

### Testnet (Active — kovanica-testnet)
```bash
# Seed1 (explorer.kovanica.online)
KOVANICA_LISTEN=0.0.0.0:9000
KOVANICA_PEERS=seed2.kovanica.online:9000
KOVANICA_FAUCET=1
KOVANICA_ALLOW_RESET=0
KOVANICA_OPERATOR=1
KOVANICA_DATA=/root/kovanica-data
KOVANICA_CONSENSUS=poa            # [TARGET] — PoA migration pending reset
KOVANICA_AUTHORITIES=<3-key hex list>
KOVANICA_AUTHORITY_THRESHOLD=2
KOVANICA_SLOT_DURATION=3000

# Seed2 (seed2.kovanica.online:76.13.250.65)
KOVANICA_LISTEN=0.0.0.0:9000
KOVANICA_PEERS=seed.kovanica.online:9000
KOVANICA_FAUCET=0
KOVANICA_ALLOW_RESET=0
KOVANICA_OPERATOR=1
KOVANICA_DATA=/var/lib/kovanica-seed2
```

### Mainnet (Dormant — Not Yet Live)
```bash
# Genesis-time only (set at launch ceremony)
KOVANICA_CONSENSUS=poa
KOVANICA_AUTHORITIES=<ceremony-generated 5-16 keys>
KOVANICA_AUTHORITY_THRESHOLD=<t of n>
KOVANICA_SLOT_DURATION=3000
KOVANICA_LISTEN=0.0.0.0:9000
KOVANICA_PEERS=<authority IPs>
KOVANICA_FAUCET=0
KOVANICA_ALLOW_RESET=0
KOVANICA_OPERATOR=1
KOVANICA_DATA=/var/lib/kovanica-mainnet
```

## Network Constants (RFC-006 — Immutable)

| Constant | Value | Atoms |
|----------|-------|-------|
| MAX_SUPPLY | 90.2M KVNC | 9,020,000,000,000,000 |
| Genesis Subsidy (s₀) | 10 KVNC | 1,000,000,000 |
| Era Length | 2,000,000 blocks | — |
| Decay (α) | 3/4 per era | — |
| Coinbase Maturity | 100 blocks | — |
| Fee Split | 75% burned / 25% producer | — |
| Fee Floor | max(1, subsidy/500,000) atoms/byte | — |
| GHOSTDAG k | 3 | — |
| Premine (Founder) | 0.2M KVNC | 20,000,000,000,000 |
| Treasury | 10M KVNC (10×1M vaults) | 1,000,000,000,000,000 |

**These are consensus constants — identical across developing/testnet/mainnet.**

## Key Files

| File | Location | Purpose |
|------|----------|---------|
| `NETWORK.md` | `/root/kovanica/NETWORK.md` | Canonical domains, ports, seeds |
| `TESTNET-RFC006.md` | `/root/kovanica/protocol/TESTNET-RFC006.md` | Testnet economy + env |
| `OPERATIONS.md` | `/root/kovanica/protocol/OPERATIONS.md` | Seed ops runbook |
| `DEPLOY.md` | `/root/kovanica/web/site/DEPLOY.md` | VPS web deploy |
| `SEED1_POA_DEPLOYMENT.md` | `/root/kovanica/protocol/SEED1_POA_DEPLOYMENT.md` | PoA seed1 migration plan |
| `TESTNET_AUTHORITY_KEYS.md` | `/root/kovanica/protocol/TESTNET_AUTHORITY_KEYS.md` | Testnet authority key refs |

## Live Endpoints (Testnet)

| Service | URL |
|---------|-----|
| Explorer | https://explorer.kovanica.online |
| Wallet | https://wallet.kovanica.online |
| API | https://api.kovanica.online |
| Testnet Portal | https://testnet.kovanica.online |
| Mainnet Portal | https://mainnet.kovanica.online (dormant) |
| Docs | https://docs.kovanica.online |
| Bootstrap | https://explorer.kovanica.online/api/bootstrap |
| Head | https://explorer.kovanica.online/api/head |

## P2P Bootstrap Seeds

| Seed | Hostname | IP | Role |
|------|----------|-----|------|
| **Seed1** | `seed.kovanica.online` | (grey-cloud DNS) | Primary bootstrap, explorer, faucet |
| **Seed2** | `seed2.kovanica.online` | 76.13.250.65 | Secondary bootstrap, mining |

> **Never** dial `explorer.kovanica.online:9000` — it is Cloudflare orange-cloud (proxied HTTP only). Use grey-cloud DNS `seed.kovanica.online:9000` or origin IP for P2P.

## Build Commands

```bash
# Protocol (Rust workspace)
cd /root/kovanica/protocol
cargo build --workspace              # Debug
cargo build --release --workspace    # Release (deploy artifact)

# Node binary (thin wrapper)
cd /root/kovanica/node
cargo build --release --workspace    # → target/release/kovanica-node

# Web (TanStack Start + Nitro)
cd /root/kovanica/web/site
npm run build:vps                    # → .output/server/index.mjs (PM2)
# Deploy: rsync .output/ /root/kovanica-web/.output/ && pm2 restart kovanica-web

# Mobile Wallet (Android)
cd /root/kovanica/wallet/android
./gradlew assembleDebug              # Debug APK
./gradlew assembleRelease            # Release AAB (sign for Play Store)

# Android Light Node
cd /root/kovanica/android-light-node
./gradlew assembleDebug              # Debug APK
```

## Testnet Reset Procedure (PoA Migration)

When PoA migration is executed (RFC-POA §0.6):

1. **Stop all nodes**: `systemctl stop kovanica-*`
2. **Wipe data dirs**: `rm -rf /root/kovanica-data/* /var/lib/kovanica-seed*`
3. **Deploy identical binary** to all seeds via `deploy-seed-prebuilt.sh`
4. **Configure PoA env**: `KOVANICA_CONSENSUS=poa` + `KOVANICA_AUTHORITIES` + `KOVANICA_AUTHORITY_THRESHOLD`
5. **Start seeds in order**: seed1 → seed2 → verify cross-connectivity
6. **Verify genesis match** across all seeds
7. **Update DNS** if authority IPs changed

See: `/root/kovanica/protocol/TESTNET-RESET-PROCEDURE.md` and `SEED1_POA_DEPLOYMENT.md`

## Quick Start

```bash
# Developing: run local node
cd /root/kovanica-workspace/developing
source /root/kovanica/protocol/scripts/dev-env.sh  # (create this)
cargo run -p kovanica-node -- demo

# Testnet: check status
curl https://explorer.kovanica.online/api/head | jq
pm2 status

# Mainnet: not yet live — preparation only
ls /root/kovanica-workspace/mainnet/genesis/
```