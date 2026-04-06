import argparse
import os
import random
import re


def collect_identities(lfw_dir):
    name_to_indices = {}
    pattern = re.compile(r"_(\d+)\.jpg$", re.IGNORECASE)
    for name in os.listdir(lfw_dir):
        person_dir = os.path.join(lfw_dir, name)
        if not os.path.isdir(person_dir):
            continue
        indices = []
        for fname in os.listdir(person_dir):
            match = pattern.search(fname)
            if not match:
                continue
            idx = int(match.group(1))
            indices.append(idx)
        indices = sorted(set(indices))
        if len(indices) >= 2:
            name_to_indices[name] = indices
    return name_to_indices


def build_pairs(name_to_indices, same_count, diff_count, seed):
    random.seed(seed)
    names = list(name_to_indices.keys())
    if len(names) < 2:
        raise RuntimeError("Need at least 2 identities with >=2 images each")

    same_pairs = []
    for _ in range(same_count):
        name = random.choice(names)
        idx1, idx2 = random.sample(name_to_indices[name], 2)
        same_pairs.append((name, idx1, idx2))

    diff_pairs = []
    for _ in range(diff_count):
        name1, name2 = random.sample(names, 2)
        idx1 = random.choice(name_to_indices[name1])
        idx2 = random.choice(name_to_indices[name2])
        diff_pairs.append((name1, idx1, name2, idx2))

    return same_pairs, diff_pairs


def write_pairs(out_path, same_pairs, diff_pairs):
    with open(out_path, "w", encoding="utf-8") as f:
        f.write("10\n")
        for name, idx1, idx2 in same_pairs:
            f.write(f"{name} {idx1} {idx2}\n")
        for name1, idx1, name2, idx2 in diff_pairs:
            f.write(f"{name1} {idx1} {name2} {idx2}\n")


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--lfw-dir", required=True, help="Path to lfw-deepfunneled")
    parser.add_argument("--out", required=True, help="Output pairs.txt path")
    parser.add_argument("--same", type=int, default=3000, help="Number of same pairs")
    parser.add_argument("--diff", type=int, default=3000, help="Number of diff pairs")
    parser.add_argument("--seed", type=int, default=42, help="Random seed")
    args = parser.parse_args()

    name_to_indices = collect_identities(args.lfw_dir)
    same_pairs, diff_pairs = build_pairs(name_to_indices, args.same, args.diff, args.seed)
    write_pairs(args.out, same_pairs, diff_pairs)
    print(f"Wrote {args.out}")


if __name__ == "__main__":
    main()
