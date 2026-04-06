#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ARCFACE_DIR="$ROOT/recognition/arcface_mxnet"
PRETRAINED_PREFIX="$ROOT/models/pretrained/resnet100/model"
MODELS_ROOT="$ROOT/models/finetuned/uriel_mxnet"
LR="0.01"

mkdir -p "$MODELS_ROOT"

cd "$ARCFACE_DIR"
CUDA_VISIBLE_DEVICES=0 python -u train.py \
  --network r100 --loss arcface --dataset custom \
  --pretrained "$PRETRAINED_PREFIX" --pretrained-epoch 0 \
  --models-root "$MODELS_ROOT" --lr "$LR"

