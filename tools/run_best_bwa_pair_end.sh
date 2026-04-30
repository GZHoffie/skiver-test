#!/bin/bash

read_file_1=$1
read_file_2=$2
reference_file=$3
output_prefix=$5
output_dir=$4

bwa_path="bwa"
best_path="./tools/best/target/release/best"

mkdir -p ${output_dir}

# create bwa index if not exists
if [ ! -f "${reference_file}.bwt" ]; then
    ${bwa_path} index ${reference_file}
fi

# Run bwa
${bwa_path} mem ${reference_file} ${read_file_1} ${read_file_2} | samtools sort  -o ${output_dir}/${output_prefix}.bam  - 

# Run best
${best_path} ${output_dir}/${output_prefix}.bam ${reference_file} ${output_dir}/${output_prefix}
