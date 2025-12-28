#!/bin/bash

## For 96% identity and 64x coverage data
output_dir="./output/simulated_data"

for file in ./data/simulated_data/Ecoli_K12_MG1655_random_depth_64_id_96*.fastq
do
    filename=$(basename "$file" .fastq)
    echo "Running experiment for $filename"
    ./tools/run_best_minimap.sh "$file" ./data/reference/Ecoli_K12_MG1655.fasta ${output_dir} "$filename"
done

# Against the wrong reference
output_dir="./output/simulated_data_wrong_reference"
mkdir -p $output_dir

for file in ./data/simulated_data/Ecoli_K12_MG1655_random_depth_64_id_96*.fastq
do
    filename=$(basename "$file" .fastq)
    echo "Running experiment for $filename"
    ./tools/run_best_minimap.sh "$file" ./data/reference/Ecoli_O157_H7.fasta ${output_dir} "$filename"
done

