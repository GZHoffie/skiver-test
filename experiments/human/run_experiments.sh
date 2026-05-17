output_dir="./output/human"

mkdir -p $output_dir
mkdir -p ${output_dir}/log

# make sure that the scripts have the right permissions
chmod +x ./tools/run_best_minimap.sh
chmod +x ./tools/run_best_minimap_pair_end.sh

# Map and query the Zymo mock community reads, Nanopore Zymo Log dataset
./tools/run_best_minimap.sh ./data/HG002/12_1_22_R1041_ULCIR_HG002_1_dorado0.4.0_sup4.1.0_5mCG_5hmCG.fastq.gz ./data/HG002/hg002v1.1.fasta.gz ${output_dir} HG002 &> ${output_dir}/log/HG002.log
./tools/run_best_minimap.sh ./data/HG002/03_08_22_R941_HG002_2_Guppy_6.0.6_prom_sup.fastq.gz ./data/HG002/hg002v1.1.fasta.gz ${output_dir} HG002_R941 &> ${output_dir}/log/HG002_R941.log
./tools/run_best_minimap.sh ./data/HG002/m84031_231217_034919_s2.hifi_reads.fastq.gz ./data/HG002/hg002v1.1.fasta.gz ${output_dir} HG002_hifi &> ${output_dir}/log/HG002_hifi.log

#/usr/bin/time -o ./output/human/log/best.time -v /home/ubuntu/best/target/release/best ./output/human/HG002.bam.tmp.0000.bam ./data/HG002/hg002v1.1.fasta.gz ./output/human/HG002.bam.tmp.0000
#/usr/bin/time -o ./output/human/log/best.time -v /home/ubuntu/best/target/release/best ./output/human/HG002_R941.bam.tmp.0000.bam ./data/HG002/hg002v1.1.fasta.gz ./output/human/HG002_R941.bam.tmp.0000
#/usr/bin/time -o ./output/human/log/best.time -v /home/ubuntu/best/target/release/best ./output/human/HG002_hifi.bam.tmp.0000.bam ./data/HG002/hg002v1.1.fasta.gz ./output/human/HG002_hifi.bam.tmp.0000

# Find the ground truth survival rates
for file in ${output_dir}/*.summary_identity_stats.csv; do
    echo "Processing $file ..."
    # get the basename without everything behind ".summary_identity_stats.csv"
    filename=$(basename -- "$file")
    filename="${filename%.summary_identity_stats.csv}"

    python ./experiments/counting_error_free_kmers/count_mapped_kmers.py -k 1 -K 100 -b ${output_dir}/$filename
done

# Use kvmer
kvmer_dir="skiver"

## Sketching
# Sketching forward strand only
echo "Creating sketches for HG002 datasets ..."
/usr/bin/time -o ${output_dir}/log/skiver/HG002_sketch.time -v ${kvmer_dir} sketch ./data/HG002/12_1_22_R1041_ULCIR_HG002_1_dorado0.4.0_sup4.1.0_5mCG_5hmCG_removed_tabs.fastq.gz $option -o ${output_dir}/skiver/HG002.kvmer 2> ${output_dir}/log/skiver/HG002_sketch.log
/usr/bin/time -o ${output_dir}/log/skiver/HG002_R941_sketch.time -v ${kvmer_dir} sketch ./data/HG002/03_08_22_R941_HG002_2_Guppy_6.0.6_prom_sup.fastq.gz $option -o ${output_dir}/skiver/HG002_R941.kvmer 2> ${output_dir}/log/skiver/HG002_R941_ketch.log
/usr/bin/time -o ${output_dir}/log/skiver/HG002_hifi_sketch.time -v ${kvmer_dir} sketch ./data/HG002/m84031_231217_034919_s2.hifi_reads_removed_tabs.fastq.gz $option  -o ${output_dir}/skiver/HG002_hifi.kvmer 2> ${output_dir}/log/skiver/HG002_hifi_sketch.log

# Analyze without reference
echo "Analyzing sketches for HG002 datasets without reference ..."
/usr/bin/time -o ${output_dir}/log/skiver/HG002_analyze.time -v ${kvmer_dir} analyze ${output_dir}/skiver/HG002.kvmer $option -o ${output_dir}/skiver/HG002 2> ${output_dir}/log/skiver/HG002_analyze.log 
/usr/bin/time -o ${output_dir}/log/skiver/HG002_R941_analyze.time -v ${kvmer_dir} analyze ${output_dir}/skiver/HG002_R941.kvmer $option -o ${output_dir}/skiver/HG002_R941  2> ${output_dir}/log/skiver/HG002_R941_analyze.log 
/usr/bin/time -o ${output_dir}/log/skiver/HG002_hifi_analyze.time -v ${kvmer_dir} analyze ${output_dir}/skiver/HG002_hifi.kvmer $option -o ${output_dir}/skiver/HG002_hifi 2> ${output_dir}/log/skiver/HG002_hifi_analyze.log 

# Analyze with reference
echo "Analyzing sketches for HG002 datasets with reference ..."
/usr/bin/time -o ${output_dir}/log/skiver/HG002_ref_analyze.time -v ${kvmer_dir} analyze --use-all ${output_dir}/skiver/HG002.kvmer $option -r ./data/HG002/hg002v1.1.fasta.gz -o ${output_dir}/skiver/HG002_ref 2> ${output_dir}/log/HG002_kvmer_ref_analyze.log
/usr/bin/time -o ${output_dir}/log/skiver/HG002_R941_ref_analyze.time -v ${kvmer_dir} analyze --use-all ${output_dir}/skiver/HG002_R941.kvmer $option -r ./data/HG002/hg002v1.1.fasta.gz -o ${output_dir}/skiver/HG002_R941_ref 2> ${output_dir}/log/HG002_R941_kvmer_ref_analyze.log
/usr/bin/time -o ${output_dir}/log/skiver/HG002_hifi_ref_analyze.time -v ${kvmer_dir} analyze --use-all ${output_dir}/skiver/HG002_hifi.kvmer $option -r ./data/HG002/hg002v1.1.fasta.gz -o ${output_dir}/skiver/HG002_hifi_ref 2> ${output_dir}/log/HG002_hifi_kvmer_ref_analyze.log

# Plot the results
mkdir -p ./figures/skiver
python ~/skiver/scripts/plot_all.py ${output_dir}/skiver/HG002 -o ./figures/skiver/HG002
python ~/skiver/scripts/plot_all.py ${output_dir}/skiver/HG002_R941 -o ./figures/skiver/HG002_R941
python ~/skiver/scripts/plot_all.py ${output_dir}/skiver/HG002_hifi -o ./figures/skiver/HG002_hifi

python ~/skiver/scripts/plot_all.py ${output_dir}/skiver/HG002_ref -o ./figures/skiver/HG002_ref
python ~/skiver/scripts/plot_all.py ${output_dir}/skiver/HG002_R941_ref -o ./figures/skiver/HG002_R941_ref
python ~/skiver/scripts/plot_all.py ${output_dir}/skiver/HG002_hifi_ref -o ./figures/skiver/HG002_hifi_ref