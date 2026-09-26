#!/usr/bin/env bash
# Seed1: explorer.kovanica.online (primary seed, faucet, explorer)
# VPS: srv1745734 (Hostinger)
# P2P: seed.kovanica.online:9000 (grey-cloud DNS)
# Explorer: https://explorer.kovanica.online (orange-cloud)
# Authority keys: see /root/kovanica/protocol/TESTNET_AUTHORITY_KEYS.md

# SSH connection (local machine - localhost)
export SEED1_SSH_HOST="127.0.0.1"
export SEED1_SSH_USER="root"
export SEED1_SSH_KEY="${HOME}/.ssh/id_rsa"

export KOVANICA_LISTEN=0.0.0.0:9000
export KOVANICA_PEERS=seed2.kovanica.online:9000
export KOVANICA_FAUCET=1
export KOVANICA_ALLOW_RESET=0
export KOVANICA_OPERATOR=1
export KOVANICA_DATA=/root/kovanica-data
export KOVANICA_CONSENSUS=poa
export KOVANICA_AUTHORITIES=$(cat /root/kovanica/protocol/TESTNET_AUTHORITY_KEYS.md | grep -E '^[0-9a-f]{64}$' | paste -sd,)
export KOVANICA_AUTHORITY_THRESHOLD=2
export KOVANICA_SLOT_DURATION=3000
# [TARGET] PoW vars removed: KOVANICA_POW, KOVANICA_MINE, KOVANICA_MINE_SECS, KOVANICA_HYBRID