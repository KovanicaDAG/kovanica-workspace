#!/usr/bin/env bash
# Mainnet environment - DORMANT (not yet live)
# Genesis ceremony required before use

export KOVANICA_CONSENSUS=poa
export KOVANICA_AUTHORITIES=<CEREMONY_GENERATED_KEYS>
export KOVANICA_AUTHORITY_THRESHOLD=<T_OF_N>
export KOVANICA_SLOT_DURATION=3000
export KOVANICA_LISTEN=0.0.0.0:9000
export KOVANICA_PEERS=<AUTHORITY_IPS>
export KOVANICA_FAUCET=0
export KOVANICA_ALLOW_RESET=0
export KOVANICA_OPERATOR=1
export KOVANICA_DATA=/var/lib/kovanica-mainnet