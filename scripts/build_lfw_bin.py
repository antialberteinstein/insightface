import argparse
import os
import pickle

import cv2


def img_path(lfw_dir, name, idx):
    return os.path.join(lfw_dir, name, f"{name}_{idx:04d}.jpg")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--lfw-dir", required=True, help="Path to lfw-deepfunneled")
    parser.add_argument("--pairs", required=True, help="Path to pairs.txt")
    parser.add_argument("--out", required=True, help="Output lfw.bin")
    args = parser.parse_args()

    bins = []
    issame_list = []

    with open(args.pairs, "r", encoding="utf-8") as f:
        lines = f.read().strip().splitlines()

    for line in lines[1:]:
        parts = line.strip().split()
        if len(parts) == 3:
            name, id1, id2 = parts
            path1 = img_path(args.lfw_dir, name, int(id1))
            path2 = img_path(args.lfw_dir, name, int(id2))
            issame = True
        else:
            name1, id1, name2, id2 = parts
            path1 = img_path(args.lfw_dir, name1, int(id1))
            path2 = img_path(args.lfw_dir, name2, int(id2))
            issame = False

        for p in (path1, path2):
            img = cv2.imread(p)
            if img is None:
                raise RuntimeError(f"Missing image: {p}")
            _, enc = cv2.imencode(".jpg", img)
            bins.append(enc)

        issame_list.append(issame)

    with open(args.out, "wb") as f:
        pickle.dump((bins, issame_list), f, protocol=pickle.HIGHEST_PROTOCOL)

    print(f"Wrote {args.out}")


if __name__ == "__main__":
    main()
