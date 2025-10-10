#!/bin/bash

# Usage: ./data/download_from_accession.sh <accession> <output_prefix> <output_dir>
# Example: ./data/download_from_accession.sh GCF_000005845.2 Ecoli_K12_MG1655 ./data/reference

accession=$1
output_prefix=$2
output_dir=$3

mkdir -p ${output_dir}
cd ${output_dir}

datasets download genome accession ${accession} --filename ${output_prefix}.zip

# if the zip file exists, unzip it
if [ -f "${output_prefix}.zip" ]; then
  unzip ${output_prefix}.zip
  for f in ncbi_dataset/data/*/*.fna; do
    cat "$f" >> "${output_prefix}.fasta"
  done
  rm -r ncbi_dataset ${output_prefix}.zip README.md md5sum.txt
fi