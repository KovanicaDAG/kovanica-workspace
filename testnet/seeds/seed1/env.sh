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
export KOVANICA_AUTHORITIES=4a4172c14e6073998caf9ad256974cd2908a67b7751fdbc2f031c24736b8e8ec,8ebc8a73235b631845d32ed4ea2d1dc563acfa1215b18428b17364c6e1563cf3,d6903aa7a17abfe681988f1b49a8adcec0d475c5e24ab955c1349a1c463bedae
export KOVANICA_AUTHORITY_THRESHOLD=2
export KOVANICA_SLOT_DURATION=3000
# [TARGET] PoW vars removed: KOVANICA_POW, KOVANICA_MINE, KOVANICA_MINE_SECS, KOVANICA_HYBRID