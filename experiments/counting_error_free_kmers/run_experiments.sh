k=(18 19 20 21 22 23 24 25 26 27 28 29 30 31)

kvmer_bin_path="/home/zhenhao/kv-mer/target/release/kvmer"
output_dir="./output/counting_error_free_kmers"

mkdir -p $output_dir

echo "" > $output_dir/ERR3152366_mapping.txt
echo "" > $output_dir/SRR7415629_mapping.txt
echo "" > $output_dir/ERR2935851_mapping.txt
echo "" > $output_dir/Ecoli_K12_MG1655_id_96_mapping.txt


# Count the per read k-mer matching statistics
for ki in "${k[@]}"; do
    #echo "Counting k-mers with k=$ki" >> $output_dir/ERR3152366.txt
    $kvmer_bin_path mapping ~/tp-test/data/ERR3152366.fastq.gz -r ~/tp-test/data/ZymoBIOMICS.STD.refseq.v2/all_genomes.fasta \
         -k $ki -v 1 -c 20 -s 100 >> $output_dir/ERR3152366_mapping.txt
    
    #echo "Counting k-mers with k=$ki" >> $output_dir/SRR7415629.txt
    $kvmer_bin_path mapping ./data/zymo/SRR7415629.fastq -r ~/tp-test/data/ZymoBIOMICS.STD.refseq.v2/Genomes/Bacillus_subtilis_complete_genome.fasta \
         -k $ki -v 1 -c 20 -s 100 >> $output_dir/SRR7415629_mapping.txt

    #echo "Counting k-mers with k=$ki" >> $output_dir/ERR2935851.txt
    $kvmer_bin_path mapping ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz -r ~/tp-test/data/ZymoBIOMICS.STD.refseq.v2/Genomes/Bacillus_subtilis_complete_genome.fasta \
         -k $ki -v 1 -c 20 -s 100 >> $output_dir/ERR2935851_mapping.txt

    #echo "Counting k-mers with k=$ki" >> $output_dir/Ecoli_K12_MG1655_id_96.txt
    $kvmer_bin_path mapping ./data/simulated_data/Ecoli_K12_MG1655_random_depth_64_id_96.fastq -r ./data/reference/Ecoli_K12_MG1655.fasta \
         -k $ki -v 1 -c 20 -s 100 >> $output_dir/Ecoli_K12_MG1655_id_96_mapping.txt
done