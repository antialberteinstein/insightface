#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LFW_DIR="$ROOT/dataset/lfw-deepfunneled"
PAIRS_IN="$LFW_DIR/pairs.txt"
BIN_OUT="$LFW_DIR/lfw.bin"

python "$ROOT/scripts/build_lfw_bin.py" \
  --lfw-dir "$LFW_DIR" \
  --pairs "$PAIRS_IN" \
  --out "$BIN_OUT"

