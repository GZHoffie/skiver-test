output_dir="./output/simulated_data_wrong_reference"
mkdir -p ${output_dir}

# Randomly subsample 100 files from ../tp-test/databases/Escherichia/Escherichia\ coli/ and copy them to ./data/reference/Ecoli/
#mkdir -p ./data/reference/Ecoli/
#find ../tp-test/databases/Escherichia/Escherichia\ coli/ -type f | shuf -n 100 | xargs -I {} cp {} ./data/reference/Ecoli/
# Randomly select 100 accessions from GTDB Escherichia coli genomes and save them to ./experiments/simulated_data_wrong_reference/accessions.txt
for accession in $(cat ./experiments/simulated_data_wrong_reference/accessions.txt); do
    ./data/download_from_accession.sh ${accession} ${accession} ./data/reference/Ecoli 
done

# Calculate ANI values between Ecoli_K12_MG1655 and all the genomes in ./data/reference/Ecoli/ using skani
skani dist ./data/reference/Ecoli_K12_MG1655.fasta ./data/reference/Ecoli/*.fasta > ${output_dir}/Ecoli_ANI_values.tsv

# For each of the 100 genomes, run minimap2 to map the simulated reads from Ecoli_K12_MG1655 to the genome and collect mapping statistics
test_read_file="./data/simulated_data/Ecoli_K12_MG1655_random_depth_64_id_96.fastq"

for genome in ./data/reference/Ecoli/*.fasta; do
    genome_name=$(basename ${genome} .fasta)
    ./tools/run_best_minimap.sh ${test_read_file} ${genome} ${output_dir} ${genome_name}
done