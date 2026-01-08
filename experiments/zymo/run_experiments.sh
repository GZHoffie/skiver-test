output_dir="./output/zymo"

mkdir -p $output_dir
mkdir -p ${output_dir}/log

# make sure that the scripts have the right permissions
chmod +x ./tools/run_best_minimap.sh
chmod +x ./tools/run_best_minimap_pair_end.sh

# Map and query the Zymo mock community reads, Nanopore Zymo Log dataset
/usr/bin/time -o ${output_dir}/log/ERR3152366.time -v ./tools/run_best_minimap.sh ./data/zymo/ERR3152366.fastq.gz ./data/zymo/ZymoBIOMICS.STD.refseq.v2/zymo_community_reference.fasta ${output_dir} ERR3152366 &> ${output_dir}/log/ERR3152366.log
/usr/bin/time -o ${output_dir}/log/R10HC.time -v ./tools/run_best_minimap.sh ./data/zymo/Zymo-GridION-EVEN-BB-SN-PCR-R10HC-flipflop.fq.gz ./data/zymo/ZymoBIOMICS.STD.refseq.v2/zymo_community_reference.fasta ${output_dir} R10HC &> ${output_dir}/log/R10HC.log


#/usr/bin/time -o ${output_dir}/log/ERR3152366_b_subtilis.time -v ./tools/run_best_minimap.sh ~/tp-test/data/ERR3152366.fastq.gz ./data/zymo/ZymoBIOMICS.STD.refseq.v2/Genomes/Bacillus_subtilis_complete_genome.fasta ${output_dir} ERR3152366_b_subtilis &> ${output_dir}/log/ERR3152366_b_subtilis.log

# Illumina pair-end reads on Bacillus subtilis isolates
b_subtilis_ref="./data/zymo/ZymoBIOMICS.STD.refseq.v2/Genomes/Bacillus_subtilis_complete_genome.fasta"
b_subtilis_assembly="./data/zymo/mCaller_analysis_scripts/assemblies/bsubtilis_pb.fasta"

## Minimap2
/usr/bin/time -o ${output_dir}/log/ERR2935851_ref.time -v ./tools/run_best_minimap_pair_end.sh ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz ${b_subtilis_ref} ${output_dir} ERR2935851_ref &> ${output_dir}/log/ERR2935851_ref.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_trim_ref.time -v ./tools/run_best_minimap_pair_end.sh ./data/zymo/ERR2935851_1.trim.fastq.gz ./data/zymo/ERR2935851_2.trim.fastq.gz ${b_subtilis_ref} ${output_dir} ERR2935851_trim_ref &> ${output_dir}/log/ERR2935851_trim_ref.log

/usr/bin/time -o ${output_dir}/log/ERR2935851_assembly.time -v ./tools/run_best_minimap_pair_end.sh ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz ${b_subtilis_assembly}  ${output_dir} ERR2935851_assembly &> ${output_dir}/log/ERR2935851_assembly.log

## bowtie2
/usr/bin/time -o ${output_dir}/log/ERR2935851_ref_bowtie.time -v ./tools/run_best_bowtie_pair_end.sh ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz ${b_subtilis_ref} ${output_dir} ERR2935851_ref_bowtie &> ${output_dir}/log/ERR2935851_ref_bowtie.log

# PacBio Sequel reads on Bacillus subtilis isolates
/usr/bin/time -o ${output_dir}/log/SRR7415629_ref.time -v ./tools/run_best_minimap.sh ./data/zymo/SRR7415629.fastq ${b_subtilis_ref} ${output_dir} SRR7415629_ref &> ${output_dir}/log/SRR7415629_ref.log
/usr/bin/time -o ${output_dir}/log/SRR7415629_assembly.time -v ./tools/run_best_minimap.sh ./data/zymo/SRR7415629.fastq ${b_subtilis_assembly} ${output_dir} SRR7415629_assembly &> ${output_dir}/log/SRR7415629_assembly.log

/usr/bin/time -o ${output_dir}/log/SRR7498042_ref.time -v ./tools/run_best_minimap.sh ./data/zymo/SRR7498042.fastq ${b_subtilis_ref} ${output_dir} SRR7498042_ref &> ${output_dir}/log/SRR7498042_ref.log
/usr/bin/time -o ${output_dir}/log/SRR7498042_assembly.time -v ./tools/run_best_minimap.sh ./data/zymo/SRR7498042.fastq ${b_subtilis_assembly} ${output_dir} SRR7498042_assembly &> ${output_dir}/log/SRR7498042_assembly.log




for file in ${output_dir}/*.summary_identity_stats.csv; do
    echo "Processing $file ..."
    # get the basename without everything behind ".summary_identity_stats.csv"
    filename=$(basename -- "$file")
    filename="${filename%.summary_identity_stats.csv}"

    python ./experiments/counting_error_free_kmers/count_mapped_kmers.py -k 1 -K 100 -b ${output_dir}/$filename
done


# kvmer
kvmer_dir="../kv-mer/target/release/kvmer"
/usr/bin/time -o ${output_dir}/log/ERR3152366_kvmer.time -v ${kvmer_dir} analyze ./data/zymo/ERR3152366.fastq.gz -o ${output_dir}/ERR3152366_kvmer_verbose.csv --hazard-ratio ${output_dir}/ERR3152366_kvmer_hazard_ratio.csv 2> ${output_dir}/log/ERR3152366_kvmer.log > ${output_dir}/ERR3152366_kvmer.csv
/usr/bin/time -o ${output_dir}/log/ERR2935851_kvmer.time -v ${kvmer_dir} analyze ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz -o ${output_dir}/ERR2935851_kvmer_verbose.csv --hazard-ratio ${output_dir}/ERR2935851_kvmer_hazard_ratio.csv 2> ${output_dir}/log/ERR2935851_kvmer.log > ${output_dir}/ERR2935851_kvmer.csv
/usr/bin/time -o ${output_dir}/log/ERR2935851_trim_kvmer.time -v ${kvmer_dir} analyze ./data/zymo/ERR2935851_1.trim.fastq.gz ./data/zymo/ERR2935851_2.trim.fastq.gz -o ${output_dir}/ERR2935851_trim_kvmer_verbose.csv --hazard-ratio ${output_dir}/ERR2935851_trim_kvmer_hazard_ratio.csv 2> ${output_dir}/log/ERR2935851_trim_kvmer.log > ${output_dir}/ERR2935851_trim_kvmer.csv

/usr/bin/time -o ${output_dir}/log/SRR7498042_kvmer.time -v ${kvmer_dir} analyze ./data/zymo/SRR7498042.fastq -o ${output_dir}/SRR7498042_kvmer_verbose.csv --hazard-ratio ${output_dir}/SRR7498042_kvmer_hazard_ratio.csv 2> ${output_dir}/log/SRR7498042_kvmer.log > ${output_dir}/SRR7498042_kvmer.csv

/usr/bin/time -o ${output_dir}/log/ERR3152366_kvmer_sketch.time -v ${kvmer_dir} sketch ./data/zymo/ERR3152366.fastq.gz -o ${output_dir}/ERR3152366.kvmer  2> ${output_dir}/log/ERR3152366_kvmer_sketch.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_kvmer_sketch.time -v ${kvmer_dir} sketch ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz -o ${output_dir}/ERR2935851.kvmer  2> ${output_dir}/log/ERR2935851_kvmer_sketch.log
/usr/bin/time -o ${output_dir}/log/SRR7498042_kvmer_sketch.time -v ${kvmer_dir} sketch ./data/zymo/SRR7498042.fastq -o ${output_dir}/SRR7498042.kvmer  2> ${output_dir}/log/SRR7498042_kvmer_sketch.log 
/usr/bin/time -o ${output_dir}/log/ERR2935851_trim_kvmer_sketch.time -v ${kvmer_dir} sketch ./data/zymo/ERR2935851_1.trim.fastq.gz ./data/zymo/ERR2935851_2.trim.fastq.gz -o ${output_dir}/ERR2935851_trim.kvmer  2> ${output_dir}/log/ERR2935851_trim_kvmer_sketch.log

/usr/bin/time -o ${output_dir}/log/ERR3152366_kvmer_analyze.time -v ${kvmer_dir} analyze ${output_dir}/ERR3152366.kvmer --hazard-ratio ${output_dir}/ERR3152366_kvmer_hazard_ratio.csv > ${output_dir}/ERR3152366_kvmer.csv 2> ${output_dir}/log/ERR3152366_kvmer_analyze.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_kvmer_analyze.time -v ${kvmer_dir} analyze ${output_dir}/ERR2935851.kvmer --hazard-ratio ${output_dir}/ERR2935851_kvmer_hazard_ratio.csv > ${output_dir}/ERR2935851_kvmer.csv 2> ${output_dir}/log/ERR2935851_kvmer_analyze.log
/usr/bin/time -o ${output_dir}/log/SRR7498042_kvmer_analyze.time -v ${kvmer_dir} analyze ${output_dir}/SRR7498042.kvmer --hazard-ratio ${output_dir}/SRR7498042_kvmer_hazard_ratio.csv > ${output_dir}/SRR7498042_kvmer.csv 2> ${output_dir}/log/SRR7498042_kvmer_analyze.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_trim_kvmer_analyze.time -v ${kvmer_dir} analyze ${output_dir}/ERR2935851_trim.kvmer --hazard-ratio ${output_dir}/ERR2935851_trim_kvmer_hazard_ratio.csv > ${output_dir}/ERR2935851_trim_kvmer.csv 2> ${output_dir}/log/ERR2935851_trim_kvmer_analyze.log