#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LFW_DIR="$ROOT/dataset/lfw-deepfunneled"
MODELS_ROOT="$ROOT/models/finetuned/uriel_mxnet"
MODEL_PREFIX="$MODELS_ROOT/model"
EPOCH="0"

python "$ROOT/recognition/arcface_mxnet/verification.py" \
  --data-dir "$LFW_DIR" \
  --model "$MODEL_PREFIX,$EPOCH" \
  --target lfw --gpu 0

