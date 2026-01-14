#!/bin/bash

output_dir=./output/virus_mutation_spectra
mkdir -p $output_dir

kvmer_path="../kv-mer/target/release/kvmer"
data="./data/virus/sarscov.fasta"
prefix="sarscov"
subsample_factors=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16)

for c in "${subsample_factors[@]}"; do
    
    kvmer_output="${output_dir}/${prefix}_c_${c}.kvmer.csv"
    hazard_rate_output="${output_dir}/${prefix}_c_${c}.hazard_rate.csv"
    $kvmer_path analyze $data --hazard-ratio ${hazard_rate_output} -c ${c} -r ./data/virus/wuhan-hu.fasta > ${kvmer_output}
done
