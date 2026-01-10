#!/usr/bin/env python3
import argparse
import re
from typing import Iterator, Tuple, TextIO

def read_fasta(handle):
    """Yield (header, sequence) from a FASTA stream."""
    header = None
    seq_parts = []
    for line in handle:
        line = line.strip()
        if not line:
            continue
        if line.startswith(">"):
            if header is not None:
                yield header, "".join(seq_parts)
            header = line[1:].strip()
            seq_parts = []
        else:
            seq_parts.append(line)
    if header is not None:
        yield header, "".join(seq_parts)

def wrap_seq(seq, width=60):
    return "\n".join(seq[i:i+width] for i in range(0, len(seq), width))

def split_on_N_and_remove_gaps(seq):
    """
    Remove '-' then split on one or more N/n (discarding those runs).
    Returns only non-empty chunks.
    """
    seq = seq.replace("-", "")
    # split on one or more N or n
    parts = re.split(r"[Nn]+", seq)
    return [p for p in parts if p]


if __name__ == "__main__":
    ap = argparse.ArgumentParser(
        description="Split FASTA sequences on runs of N/n (remove them), and delete '-' characters."
    )
    ap.add_argument("input_fasta", help="Input FASTA file")
    ap.add_argument("output_fasta", help="Output FASTA file")
    ap.add_argument("--wrap", type=int, default=60, help="FASTA line width (default: 60)")
    args = ap.parse_args()

    out_idx = 1
    with open(args.input_fasta, "r", encoding="utf-8") as fin, open(args.output_fasta, "w", encoding="utf-8") as fout:
        for _hdr, seq in read_fasta(fin):
            for chunk in split_on_N_and_remove_gaps(seq):
                fout.write(f">seq{out_idx}\n")
                fout.write(chunk + "\n")
                out_idx += 1