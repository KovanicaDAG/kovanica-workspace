#!/usr/bin/env bash
# Testnet participant/explorer environment
# Source: source /root/kovanica-workspace/testnet/env.sh
# Runs: kovanica-node explorer 127.0.0.1:8080
# Web: npm run dev (from /root/kovanica-workspace/testnet/web) on port 3010

export KOVANICA_LISTEN=127.0.0.1:9000
export KOVANICA_PEERS=seed.kovanica.online:9000
export KOVANICA_FAUCET=0
export KOVANICA_ALLOW_RESET=0
export KOVANICA_OPERATOR=0
export KOVANICA_DATA=/root/kovanica-workspace/testnet/data/kovanica-data
export KOVANICA_CONSENSUS=poa
export KOVANICA_AUTHORITIES=$(cat /root/kovanica/protocol/TESTNET_AUTHORITY_KEYS.md | grep -E '^[0-9a-f]{64}$' | paste -sd,)
export KOVANICA_AUTHORITY_THRESHOLD=2
export KOVANICA_SLOT_DURATION=3000
# [TARGET] PoW vars removed: KOVANICA_POW, KOVANICA_MINE, KOVANICA_MINE_SECS, KOVANICA_HYBRID