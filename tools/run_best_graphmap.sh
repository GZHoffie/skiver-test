#!/bin/bash

read_file=$1
reference_file=$2
output_prefix=$4
output_dir=$3

graphmap_path="./tools/graphmap2/bin/Linux-x64/graphmap2"
best_path="../best/target/release/best"

mkdir -p ${output_dir}

# Run minimap2
${graphmap_path} align -r ${reference_file} -d ${read_file} -o ${output_dir}/${output_prefix}.sam 
samtools view -bS ${output_dir}/${output_prefix}.sam > ${output_dir}/${output_prefix}.bam
rm ${output_dir}/${output_prefix}.sam

# Run best
${best_path} ${output_dir}/${output_prefix}.bam ${reference_file} ${output_dir}/${output_prefix}
