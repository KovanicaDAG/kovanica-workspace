#!/usr/bin/env bash
# Developing environment - local dev node (PoA)
# Use: source /root/kovanica-workspace/developing/env.sh
# Runs: kovanica-node explorer 127.0.0.1:8080

# Consensus: PoA (testnet default)
export KOVANICA_CONSENSUS=poa
export KOVANICA_AUTHORITIES=<AUTH_SET_FROM_TESTNET>
export KOVANICA_AUTHORITY_THRESHOLD=2
export KOVANICA_SLOT_DURATION=3000

# Node config
export KOVANICA_LISTEN=127.0.0.1:9000
export KOVANICA_PEERS=seed.kovanica.online:9000
export KOVANICA_FAUCET=0
export KOVANICA_OPERATOR=0
export KOVANICA_DATA=/root/kovanica-workspace/developing/data

# Dev-only: allow genesis reset (isolated host only)
# export KOVANICA_ALLOW_RESET=1
# export KOVANICA_ISOLATED_HOST=1

# Block production (optional, for local testing)
# export KOVANICA_PRODUCE=1
# export KOVANICA_PRODUCE_SECS=3
# Authority key loaded from separate file if producing:
# source /root/kovanica-workspace/testnet/authority-keys/authority-1.env
