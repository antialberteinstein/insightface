#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DATASET_DIR="$ROOT/dataset/faces"
CONFIG_FILE="$ROOT/recognition/arcface_mxnet/config.py"

if [[ ! -d "$DATASET_DIR" ]]; then
  echo "Dataset dir not found: $DATASET_DIR" >&2
  exit 1
fi

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "Config file not found: $CONFIG_FILE" >&2
  exit 1
fi

ROOT_DIR="$ROOT" python - <<'PY'
import os
import re

root = os.environ["ROOT_DIR"]
dataset_dir = os.path.join(root, 'dataset', 'faces')
config_file = os.path.join(root, 'recognition', 'arcface_mxnet', 'config.py')

names = [d for d in os.listdir(dataset_dir) if os.path.isdir(os.path.join(dataset_dir, d))]
num_classes = len(names)

with open(config_file, 'r', encoding='utf-8') as f:
    content = f.read()

pattern = r"dataset\.custom\.num_classes\s*=\s*\d+"
new_line = f"dataset.custom.num_classes = {num_classes}"
if re.search(pattern, content):
    content = re.sub(pattern, new_line, content)
else:
    content += "\n" + new_line + "\n"

with open(config_file, 'w', encoding='utf-8') as f:
    f.write(content)

print(f"Updated num_classes to {num_classes} in {config_file}")
PY
