#!/usr/bin/env bash

# Example usage:
#   ./run_mummer_plot_pairwise.sh \
#     output/prefix \
#     reference_genome.fasta \
#     query_genome.fasta


set -euo pipefail

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 [output_prefix] [reference.fasta] [query.fasta]" >&2
  exit 2
fi

output_prefix=$1
reference_genome=$2
query_genome=$3


nucmer --prefix="${output_prefix}" "${reference_genome}" "${query_genome}"
dnadiff -d "${output_prefix}.delta" -p "${output_prefix}"
delta-filter -1 "${output_prefix}.delta" > "${output_prefix}.1delta"
show-coords -rcl "${output_prefix}.1delta" > "${output_prefix}.coords.tsv"
mummerplot --terminal png --layout --filter --prefix="${output_prefix}" "${output_prefix}.1delta"
