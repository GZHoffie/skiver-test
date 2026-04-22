#!/bin/bash

read_file=$1
reference_file=$2
output_dir=$3
output_prefix=$4

option=$5 # For example, "map-ont" for ONT reads, "map-hifi" for hifi reads



minimap2_path="./tools/minimap2/minimap2"
best_path="./tools/best/target/release/best"

mkdir -p ${output_dir}

# Run minimap2
${minimap2_path} -ax $option ${reference_file} ${read_file} | samtools sort -o ${output_dir}/${output_prefix}.bam --write-index - 

# Run best
${best_path} ${output_dir}/${output_prefix}.bam ${reference_file} ${output_dir}/${output_prefix}

# Remove intermediate bam file
#rm ${output_dir}/${output_prefix}.bam
