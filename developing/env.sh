#!/usr/bin/env bash
# Developing environment - local dev node
# Use: source /root/kovanica-workspace/developing/env.sh

export KOVANICA_POW=1                    # [CURRENT] pre-PoA
export KOVANICA_MINE=0
export KOVANICA_FAUCET=0
export KOVANICA_ALLOW_RESET=1            # Dev-only: allow genesis reset
export KOVANICA_OPERATOR=0
export KOVANICA_LISTEN=127.0.0.1:9000
export KOVANICA_PEERS=seed.kovanica.online:9000
export KOVANICA_DATA=/root/kovanica-workspace/developing/data
export KOVANICA_CONSENSUS=poa            # [TARGET] PoA default