#!/bin/bash

read_file=$1
output_prefix=$3
output_dir=$2

genomescope_path="./tools/genomescope2.0/genomescope.R"

mkdir -p ${output_dir}

#num_threads=16
#memory=16000000000 # 16GB

# count k-mers with jellyfish
# Using 16GB of memory, k-mer size 21, 10 threads

# if read_file ends with .gz, add zcat before jellyfish
#if [[ ${read_file} == *.gz ]]; then
#    echo "Input file ${read_file} is gzipped, using zcat"
#    jellyfish count -C -m 21 -s ${memory} -t ${num_threads} -o ${output_dir}/${output_prefix}.jf <(zcat ${read_file})
#else
#    jellyfish count -C -m 21 -s ${memory} -t ${num_threads} ${read_file} -o ${output_dir}/${output_prefix}.jf
#fi

#jellyfish histo -t 10 ${output_dir}/${output_prefix}.jf > ${output_dir}/${output_prefix}.histo


# Run with kmc instead
kmc_path="./tools/kmc/bin"
mkdir -p ${output_dir}/${output_prefix}
${kmc_path}/kmc -k21 -t1 -m32 -ci1 -cs10000 ${read_file} ${output_dir}/${output_prefix} ${output_dir}/${output_prefix}
${kmc_path}/kmc_tools transform ${output_dir}/${output_prefix} histogram ${output_dir}/${output_prefix}.histo -cx10000
# remove kmc database
rm ${output_dir}/${output_prefix}.kmc_*


# Run genomescope
${genomescope_path} -i ${output_dir}/${output_prefix}.histo -o ${output_dir}/${output_prefix} -k 21 --verbose