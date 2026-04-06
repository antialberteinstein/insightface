#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MODELS_ROOT="$ROOT/models/finetuned/uriel_mxnet"
MODEL_PREFIX="$MODELS_ROOT/model"
EPOCH="0"
OUT_DIR="$ROOT/models/finetuned/uriel"
OUT_NAME="w600k_r100.onnx"

mkdir -p "$OUT_DIR"

python "$ROOT/recognition/arcface_mxnet/export_onnx.py" \
  --model-prefix "$MODEL_PREFIX" \
  --epoch "$EPOCH" \
  --output "$OUT_DIR/$OUT_NAME"

