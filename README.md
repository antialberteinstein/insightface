
# InsightFace Finetune Pipeline (MXNet)

This repository is a lightweight finetune pipeline built on top of the original
InsightFace project. The upstream project is here:
https://github.com/deepinsight/insightface

## What This Adds

- A repeatable MXNet finetune workflow for ArcFace r100.
- One-command scripts for data prep, finetune, evaluation, export to ONNX, and
  merging with a buffalo_l-style model pack.
- A self-contained folder layout so you can run everything inside this repo.

## Folder Layout (Inside This Repo)

- dataset/faces: training images, grouped by identity
- dataset/lfw-deepfunneled: LFW images plus pairs.txt and lfw.bin
- models/pretrained/resnet100: MXNet pretrained model (model-symbol.json + model-0000.params)
- models/pretrained/buffalo_l_without_recog: detection/alignment/age ONNX files
- models/finetuned/uriel_mxnet: MXNet checkpoints after finetune
- models/finetuned/uriel: merged ONNX model pack output

## Requirements

GPU (CUDA 11.8):

```bash
pip install -r requirements.txt
```

CPU only:

```bash
pip install -r requirements-cpu.txt
```

## Run The Pipeline

Run scripts in order from the repo root:

```bash
chmod +x scripts/*.sh
scripts/01_build_recordio.sh
scripts/02_set_num_classes.sh
scripts/03_build_lfw_pairs.sh
scripts/04_build_lfw_bin.sh
scripts/05_finetune_mxnet.sh
scripts/06_eval_lfw.sh
scripts/07_export_onnx.sh
scripts/08_merge_buffalo_l.sh
```

Notes:
- 03/04 build pairs.txt and lfw.bin for evaluation. If you want official LFW
  scores, replace pairs.txt with the official one before running 04.
- Update epochs in scripts 06 and 07 when you want to evaluate/export a
  specific checkpoint.

## License And Attribution

This pipeline is built on InsightFace. Please check the upstream project for
license details and model usage terms:
https://github.com/deepinsight/insightface
