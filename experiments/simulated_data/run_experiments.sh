#!/bin/bash

for file in ./data/simulated_data/*.fastq
do
    filename=$(basename "$file" .fastq)
    echo "Running experiment for $filename"
    ./tools/run_best_minimap.sh "$file" ./data/reference/Ecoli_K12_MG1655.fasta ./output/simulated_data "$filename"
done

