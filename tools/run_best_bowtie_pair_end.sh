#!/bin/bash

read_file_1=$1
read_file_2=$2
reference_file=$3
output_prefix=$5
output_dir=$4

mkdir -p ${output_dir}

best_path="./tools/best"
# Build index with bowtie2
bowtie2-build ${reference_file} ${output_dir}/${output_prefix}
bowtie2 -x ${output_dir}/${output_prefix} -1 ${read_file_1} -2 ${read_file_2} | samtools view -bS - > ${output_dir}/${output_prefix}.bam 

# Run best
${best_path} ${output_dir}/${output_prefix}.bam ${reference_file} ${output_dir}/${output_prefix}