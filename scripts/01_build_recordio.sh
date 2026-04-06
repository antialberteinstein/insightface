#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DATASET_DIR="$ROOT/dataset/faces"

if [[ ! -d "$DATASET_DIR" ]]; then
  echo "Dataset dir not found: $DATASET_DIR" >&2
  exit 1
fi

cd "$DATASET_DIR"
python -m mxnet.tools.im2rec --list --recursive train .
python -m mxnet.tools.im2rec --num-thread 8 --quality 100 train .

echo "RecordIO built in $DATASET_DIR (train.rec/train.idx)"
