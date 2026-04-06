#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LFW_DIR="$ROOT/dataset/lfw-deepfunneled"
PAIRS_OUT="$LFW_DIR/pairs.txt"

python "$ROOT/scripts/build_lfw_pairs.py" \
  --lfw-dir "$LFW_DIR" \
  --out "$PAIRS_OUT"

