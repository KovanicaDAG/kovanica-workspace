#!/usr/bin/env bash
# Seed2: seed2.kovanica.online (secondary seed, mining)
# VPS: srv1991525 (Hostinger KVM2) - 76.13.250.65
# P2P: seed2.kovanica.online:9000 (grey-cloud DNS)
# Authority keys: see /root/kovanica/protocol/TESTNET_AUTHORITY_KEYS.md

export KOVANICA_LISTEN=0.0.0.0:9000
export KOVANICA_PEERS=seed.kovanica.online:9000
export KOVANICA_FAUCET=0
export KOVANICA_ALLOW_RESET=0
export KOVANICA_OPERATOR=1
export KOVANICA_DATA=/var/lib/kovanica-seed2
export KOVANICA_CONSENSUS=poa
export KOVANICA_AUTHORITIES=$(cat /root/kovanica/protocol/TESTNET_AUTHORITY_KEYS.md | grep -E '^[0-9a-f]{64}$' | paste -sd,)
export KOVANICA_AUTHORITY_THRESHOLD=2
export KOVANICA_SLOT_DURATION=3000
# [TARGET] PoW vars removed: KOVANICA_POW, KOVANICA_MINE, KOVANICA_MINE_SECS, KOVANICA_HYBRID