#!/usr/bin/env python3
"""Download genomes from a sylph output TSV file."""

import argparse
import os
import re
import subprocess
import sys


def parse_accessions(tsv_path):
    accessions = []
    with open(tsv_path) as f:
        header = f.readline().strip().split("\t")
        genome_col = header.index("Genome_file")
        for line in f:
            if not line.strip():
                continue
            fields = line.strip().split("\t")
            genome_file = fields[genome_col]
            # e.g. gtdb_genomes_reps_r220/database/GCF/000/307/025/GCF_000307025.1_genomic.fna.gz
            basename = os.path.basename(genome_file)
            match = re.match(r"(GC[FA]_\d+\.\d+)_genomic\.fna\.gz", basename)
            if match:
                accessions.append(match.group(1))
            else:
                print(f"Warning: could not parse accession from {genome_file}", file=sys.stderr)
    return accessions


def download_genome(accession, output_dir):
    os.makedirs(output_dir, exist_ok=True)
    output_prefix = accession
    zip_path = os.path.join(output_dir, f"{output_prefix}.zip")
    fasta_path = os.path.join(output_dir, f"{output_prefix}.fasta")

    if os.path.exists(fasta_path):
        print(f"Skipping {accession}: {fasta_path} already exists")
        return

    print(f"Downloading {accession}...")
    subprocess.run(
        ["datasets", "download", "genome", "accession", accession, "--filename", f"{output_prefix}.zip"],
        check=True,
        cwd=output_dir,
    )

    if not os.path.exists(zip_path):
        print(f"Warning: zip not found for {accession}, skipping", file=sys.stderr)
        return

    subprocess.run(["unzip", f"{output_prefix}.zip"], check=True, cwd=output_dir)

    with open(fasta_path, "wb") as out:
        for root, _, files in os.walk(os.path.join(output_dir, "ncbi_dataset", "data")):
            for fname in sorted(files):
                if fname.endswith(".fna"):
                    with open(os.path.join(root, fname), "rb") as fna:
                        out.write(fna.read())

    # Cleanup
    for name in [f"{output_prefix}.zip", "README.md", "md5sum.txt"]:
        path = os.path.join(output_dir, name)
        if os.path.exists(path):
            os.remove(path)
    ncbi_dir = os.path.join(output_dir, "ncbi_dataset")
    if os.path.exists(ncbi_dir):
        subprocess.run(["rm", "-r", ncbi_dir], check=True)


def main():
    parser = argparse.ArgumentParser(description="Download genomes from sylph output TSV")
    parser.add_argument("tsv", help="Sylph output TSV file")
    parser.add_argument("output_dir", help="Directory to download genomes into")
    args = parser.parse_args()

    accessions = parse_accessions(args.tsv)
    print(f"Found {len(accessions)} accessions")

    for accession in accessions:
        download_genome(accession, args.output_dir)


if __name__ == "__main__":
    main()
