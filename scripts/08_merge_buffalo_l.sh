#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_DIR="$ROOT/models/pretrained/buffalo_l_without_recog"
OUT_DIR="$ROOT/models/finetuned/uriel"
RECOG_ONNX="$OUT_DIR/w600k_r100.onnx"
RECOG_NAME="w600k_r100.onnx"

mkdir -p "$OUT_DIR"

cp "$SRC_DIR"/*.onnx "$OUT_DIR/"
cp "$RECOG_ONNX" "$OUT_DIR/$RECOG_NAME"

echo "Merged buffalo_l_without_recog + recognition ONNX into $OUT_DIR"
