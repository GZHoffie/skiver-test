#!/bin/bash

read_file_1=$1
read_file_2=$2
reference_file=$3
output_prefix=$5
output_dir=$4

minimap2_path="./tools/minimap2/minimap2"
best_path="./tools/best/target/release/best"

mkdir -p ${output_dir}

# Run minimap2
${minimap2_path} -ax sr ${reference_file} ${read_file_1} ${read_file_2} | samtools sort -o ${output_dir}/${output_prefix}.bam --write-index - 

# Run best
${best_path} ${output_dir}/${output_prefix}.bam ${reference_file} ${output_dir}/${output_prefix}
