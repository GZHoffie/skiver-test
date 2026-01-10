output_dir="./output/human"

mkdir -p $output_dir
mkdir -p ${output_dir}/log

# make sure that the scripts have the right permissions
chmod +x ./tools/run_best_minimap.sh
chmod +x ./tools/run_best_minimap_pair_end.sh

# Map and query the Zymo mock community reads, Nanopore Zymo Log dataset
/usr/bin/time -o ${output_dir}/log/HG002.time -v ./tools/run_best_minimap.sh ./data/HG002/12_1_22_R1041_ULCIR_HG002_1_dorado0.4.0_sup4.1.0_5mCG_5hmCG.fastq.gz ./data/HG002/hg002v1.1.fasta.gz ${output_dir} HG002 &> ${output_dir}/log/HG002.log
/usr/bin/time -o ${output_dir}/log/HG002_R941.time -v ./tools/run_best_minimap.sh ./data/HG002/03_08_22_R941_HG002_2_Guppy_6.0.6_prom_sup.fastq.gz ./data/HG002/hg002v1.1.fasta.gz ${output_dir} HG002_R941 &> ${output_dir}/log/HG002_R941.log
/usr/bin/time -o ${output_dir}/log/HG002_hifi.time -v ./tools/run_best_minimap.sh ./data/HG002/m84031_231217_034919_s2.hifi_reads.fastq.gz ./data/HG002/hg002v1.1.fasta.gz ${output_dir} HG002_hifi &> ${output_dir}/log/HG002_hifi.log

#/usr/bin/time -o ./output/human/log/best.time -v /home/ubuntu/best/target/release/best ./output/human/HG002.bam.tmp.0001.bam ./data/HG002/hg002v1.1.fasta.gz ./output/human/HG002.bam.tmp.0001

#/usr/bin/time -o ./output/human/log/best.time -v /home/ubuntu/best/target/release/best ./output/human/HG002_R941.bam.tmp.0000.bam ./data/HG002/hg002v1.1.fasta.gz ./output/human/HG002_R941.bam.tmp.0000

/usr/bin/time -o ./output/human/log/best.time -v /home/ubuntu/best/target/release/best ./output/human/HG002_hifi.bam.tmp.0000.bam ./data/HG002/hg002v1.1.fasta.gz ./output/human/HG002_hifi.bam.tmp.0000

for file in ${output_dir}/*.summary_identity_stats.csv; do
    echo "Processing $file ..."
    # get the basename without everything behind ".summary_identity_stats.csv"
    filename=$(basename -- "$file")
    filename="${filename%.summary_identity_stats.csv}"

    python ./experiments/counting_error_free_kmers/count_mapped_kmers.py -k 1 -K 100 -b ${output_dir}/$filename
done

# Use kvmer
kvmer_dir="../kv-mer/target/release/kvmer"
# Sketching
/usr/bin/time -o ${output_dir}/log/HG002_kvmer_sketch.time -v ${kvmer_dir} sketch -c 10000 -k 31 -v 13 ./data/HG002/12_1_22_R1041_ULCIR_HG002_1_dorado0.4.0_sup4.1.0_5mCG_5hmCG.fastq.gz -o ${output_dir}/HG002.kvmer 2> ${output_dir}/log/HG002_kvmer_sketch.log
/usr/bin/time -o ${output_dir}/log/HG002_R941_kvmer_sketch.time -v ${kvmer_dir} sketch -c 10000 -k 31 -v 13 ./data/HG002/03_08_22_R941_HG002_2_Guppy_6.0.6_prom_sup.fastq.gz -o ${output_dir}/HG002_R941.kvmer 2> ${output_dir}/log/HG002_R941_kvmer_sketch.log
/usr/bin/time -o ${output_dir}/log/HG002_hifi_kvmer_sketch.time -v ${kvmer_dir} sketch -c 10000 -k 31 -v 13 ./data/HG002/m84031_231217_034919_s2.hifi_reads.fastq.gz -o ${output_dir}/HG002_hifi.kvmer 2> ${output_dir}/log/HG002_hifi_kvmer_sketch.log
# Sketching --bidirectional
/usr/bin/time -o ${output_dir}/log/HG002_bi_kvmer_sketch.time -v ${kvmer_dir} sketch --bidirectional -c 10000 -k 31 -v 13 ./data/HG002/12_1_22_R1041_ULCIR_HG002_1_dorado0.4.0_sup4.1.0_5mCG_5hmCG.fastq.gz -o ${output_dir}/HG002_bi.kvmer 2> ${output_dir}/log/HG002_bi_kvmer_sketch.log
/usr/bin/time -o ${output_dir}/log/HG002_R941_bi_kvmer_sketch.time -v ${kvmer_dir} sketch --bidirectional -c 10000 -k 31 -v 13 ./data/HG002/03_08_22_R941_HG002_2_Guppy_6.0.6_prom_sup.fastq.gz -o ${output_dir}/HG002_R941_bi.kvmer 2> ${output_dir}/log/HG002_R941_bi_kvmer_sketch.log
/usr/bin/time -o ${output_dir}/log/HG002_hifi_bi_kvmer_sketch.time -v ${kvmer_dir} sketch --bidirectional -c 10000 -k 31 -v 13 ./data/HG002/m84031_231217_034919_s2.hifi_reads.fastq.gz -o ${output_dir}/HG002_hifi_bi.kvmer 2> ${output_dir}/log/HG002_hifi_bi_kvmer_sketch.log




# Analyze without reference
/usr/bin/time -o ${output_dir}/log/HG002_kvmer_analyze.time -v ${kvmer_dir} analyze -k 31 -v 13 ${output_dir}/HG002.kvmer -o ${output_dir}/HG002_kvmer_verbose.csv --hazard-ratio ${output_dir}/HG002_kvmer_hazard_ratio.csv 2> ${output_dir}/log/HG002_kvmer_analyze.log > ${output_dir}/HG002_kvmer.csv
/usr/bin/time -o ${output_dir}/log/HG002_R941_kvmer.time -v ${kvmer_dir} analyze -k 31 -v 13 ${output_dir}/HG002_R941.kvmer -o ${output_dir}/HG002_R941_kvmer_verbose.csv --hazard-ratio ${output_dir}/HG002_R941_kvmer_hazard_ratio.csv 2> ${output_dir}/log/HG002_R941_kvmer_analyze.log > ${output_dir}/HG002_R941_kvmer.csv
/usr/bin/time -o ${output_dir}/log/HG002_hifi_kvmer.time -v ${kvmer_dir} analyze -k 31 -v 13 ${output_dir}/HG002_hifi.kvmer -o ${output_dir}/HG002_hifi_kvmer_verbose.csv --hazard-ratio ${output_dir}/HG002_hifi_kvmer_hazard_ratio.csv 2> ${output_dir}/log/HG002_hifi_kvmer_analyze.log > ${output_dir}/HG002_hifi_kvmer.csv

# Analyze without reference --bidirectional
/usr/bin/time -o ${output_dir}/log/HG002_bi_kvmer_analyze.time -v ${kvmer_dir} analyze --bidirectional -k 31 -v 13 ${output_dir}/HG002_bi.kvmer -o ${output_dir}/HG002_bi_kvmer_verbose.csv --hazard-ratio ${output_dir}/HG002_bi_kvmer_hazard_ratio.csv 2> ${output_dir}/log/HG002_bi_kvmer_analyze.log > ${output_dir}/HG002_bi_kvmer.csv
/usr/bin/time -o ${output_dir}/log/HG002_R941_bi_kvmer_analyze.time -v ${kvmer_dir} analyze --bidirectional -k 31 -v 13 ${output_dir}/HG002_R941_bi.kvmer -o ${output_dir}/HG002_R941_bi_kvmer_verbose.csv --hazard-ratio ${output_dir}/HG002_R941_bi_kvmer_hazard_ratio.csv 2> ${output_dir}/log/HG002_R941_bi_kvmer_analyze.log > ${output_dir}/HG002_R941_bi_kvmer.csv
/usr/bin/time -o ${output_dir}/log/HG002_hifi_bi_kvmer_analyze.time -v ${kvmer_dir} analyze --bidirectional -k 31 -v 13 ${output_dir}/HG002_hifi_bi.kvmer -o ${output_dir}/HG002_hifi_bi_kvmer_verbose.csv --hazard-ratio ${output_dir}/HG002_hifi_bi_kvmer_hazard_ratio.csv 2> ${output_dir}/log/HG002_hifi_bi_kvmer_analyze.log > ${output_dir}/HG002_hifi_bi_kvmer.csv


# Analyze with reference
/usr/bin/time -o ${output_dir}/log/HG002_kvmer_ref_analyze.time -v ${kvmer_dir} analyze -k 31 -v 13 -l 1 -c 10000 --use-all ${output_dir}/HG002.kvmer -r ./data/HG002/hg002v1.1.fasta.gz -o ${output_dir}/HG002_kvmer_ref_verbose.csv --hazard-ratio ${output_dir}/HG002_kvmer_ref_hazard_ratio.csv 2> ${output_dir}/log/HG002_kvmer_ref_analyze.log > ${output_dir}/HG002_kvmer_ref.csv
/usr/bin/time -o ${output_dir}/log/HG002_R941_kvmer_ref_analyze.time -v ${kvmer_dir} analyze -k 31 -v 13 -l 1 -c 10000 --use-all ${output_dir}/HG002_R941.kvmer -r ./data/HG002/hg002v1.1.fasta.gz -o ${output_dir}/HG002_R941_kvmer_ref_verbose.csv --hazard-ratio ${output_dir}/HG002_R941_kvmer_ref_hazard_ratio.csv 2> ${output_dir}/log/HG002_R941_kvmer_ref_analyze.log > ${output_dir}/HG002_R941_kvmer_ref.csv
/usr/bin/time -o ${output_dir}/log/HG002_hifi_kvmer_ref_analyze.time -v ${kvmer_dir} analyze -k 31 -v 13 -l 1 -c 10000 --use-all ${output_dir}/HG002_hifi.kvmer -r ./data/HG002/hg002v1.1.fasta.gz -o ${output_dir}/HG002_hifi_kvmer_ref_verbose.csv --hazard-ratio ${output_dir}/HG002_hifi_kvmer_ref_hazard_ratio.csv 2> ${output_dir}/log/HG002_hifi_kvmer_ref_analyze.log > ${output_dir}/HG002_hifi_kvmer_ref.csv

# Analyze with reference --bidirectional
/usr/bin/time -o ${output_dir}/log/HG002_bi_kvmer_ref_analyze.time -v ${kvmer_dir} analyze --bidirectional -k 31 -v 13 -l 1 -c 10000 --use-all ${output_dir}/HG002_bi.kvmer -r ./data/HG002/hg002v1.1.fasta.gz -o ${output_dir}/HG002_bi_kvmer_ref_verbose.csv --hazard-ratio ${output_dir}/HG002_bi_kvmer_ref_hazard_ratio.csv 2> ${output_dir}/log/HG002_bi_kvmer_ref_analyze.log > ${output_dir}/HG002_bi_kvmer_ref.csv
/usr/bin/time -o ${output_dir}/log/HG002_R941_bi_kvmer_ref_analyze.time -v ${kvmer_dir} analyze --bidirectional -k 31 -v 13 -l 1 -c 10000 --use-all ${output_dir}/HG002_R941_bi.kvmer -r ./data/HG002/hg002v1.1.fasta.gz -o ${output_dir}/HG002_R941_bi_kvmer_ref_verbose.csv --hazard-ratio ${output_dir}/HG002_R941_bi_kvmer_ref_hazard_ratio.csv 2> ${output_dir}/log/HG002_R941_bi_kvmer_ref_analyze.log > ${output_dir}/HG002_R941_bi_kvmer_ref.csv
/usr/bin/time -o ${output_dir}/log/HG002_hifi_bi_kvmer_ref_analyze.time -v ${kvmer_dir} analyze --bidirectional -k 31 -v 13 -l 1 -c 10000 --use-all ${output_dir}/HG002_hifi_bi.kvmer -r ./data/HG002/hg002v1.1.fasta.gz -o ${output_dir}/HG002_hifi_bi_kvmer_ref_verbose.csv --hazard-ratio ${output_dir}/HG002_hifi_bi_kvmer_ref_hazard_ratio.csv 2> ${output_dir}/log/HG002_hifi_bi_kvmer_ref_analyze.log > ${output_dir}/HG002_hifi_bi_kvmer_ref.csv