#!/bin/bash

read_file=$1
reference_file=$2
output_prefix=$4
output_dir=$3

winnowmap_path="./tools/Winnowmap/bin"
best_path="../best/target/release/best"

mkdir -p ${output_dir}

# Run minimap2
${winnowmap_path}/meryl count k=15 output merylDB ${reference_file}
${winnowmap_path}/meryl print greater-than distinct=0.9998 merylDB > ${output_dir}/${output_prefix}_k15.txt
winnowmap -W ${output_dir}/${output_prefix}_k15.txt -ax map-ont ${reference_file} ${read_file} > ${output_dir}/${output_prefix}.sam
samtools view -bS ${output_dir}/${output_prefix}.sam > ${output_dir}/${output_prefix}.bam
rm ${output_dir}/${output_prefix}.sam

# Run best
${best_path} ${output_dir}/${output_prefix}.bam ${reference_file} ${output_dir}/${output_prefix}
