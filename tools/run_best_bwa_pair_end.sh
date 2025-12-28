#!/bin/bash

read_file_1=$1
read_file_2=$2
reference_file=$3
output_prefix=$5
output_dir=$4

mkdir -p ${output_dir}

best_path="../best/target/release/best"
# Build index with bwa

bwa index ${reference_file}
bwa mem ${reference_file} ${read_file_1} ${read_file_2} | samtools sort -o ${output_dir}/${output_prefix}.bam --write-index -

# Run best
${best_path} ${output_dir}/${output_prefix}.bam ${reference_file} ${output_dir}/${output_prefix}