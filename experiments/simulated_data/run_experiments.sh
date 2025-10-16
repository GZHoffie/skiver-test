#!/bin/bash

~/kv-mer/target/release/kvmer analyze ./data/simulated_data/Ecoli_K12_MG1655_random_depth_32_id_96.fasta.gz -k 21 -v 6 -c 200 -t 5 > ./output/ecoli_test.tsv

./tools/run_best_minimap.sh ./data/simulated_data/Ecoli_K12_MG1655_random_depth_32_id_96.fasta.gz ./data/reference/Ecoli_K12_MG1655.fasta ./output/simulated_data Ecoli_test
./tools/run_best_minimap.sh ./data/simulated_data/Ecoli_K12_MG1655_depth_1_id_96.fasta.gz ./data/reference/Ecoli_O157_H7.fasta ./output/simulated_data Ecoli_test