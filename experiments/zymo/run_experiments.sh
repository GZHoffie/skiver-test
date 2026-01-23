output_dir="./output/zymo"

mkdir -p $output_dir
mkdir -p ${output_dir}/log

# make sure that the scripts have the right permissions
chmod +x ./tools/run_best_minimap.sh
chmod +x ./tools/run_best_minimap_pair_end.sh

# Map and query the Zymo mock community reads, Nanopore Zymo Log dataset
/usr/bin/time -o ${output_dir}/log/ERR3152366.time -v ./tools/run_best_minimap.sh ./data/zymo/ERR3152366.fastq.gz ./data/zymo/ZymoBIOMICS.STD.refseq.v2/zymo_community_reference.fasta ${output_dir} ERR3152366 &> ${output_dir}/log/ERR3152366.log
#/usr/bin/time -o ${output_dir}/log/R10HC.time -v ./tools/run_best_minimap.sh ./data/zymo/Zymo-GridION-EVEN-BB-SN-PCR-R10HC-flipflop.fq.gz ./data/zymo/ZymoBIOMICS.STD.refseq.v2/zymo_community_reference.fasta ${output_dir} R10HC &> ${output_dir}/log/R10HC.log
/usr/bin/time -o ${output_dir}/log/SRR13128014.time -v ./tools/run_best_minimap.sh ./data/zymo/SRR13128014.fastq ./data/zymo/D6331.refseq/zymo_gut_microbiome_reference.fasta ${output_dir} SRR13128014 &> ${output_dir}/log/SRR13128014.log

#/usr/bin/time -o ${output_dir}/log/ERR3152366_b_subtilis.time -v ./tools/run_best_minimap.sh ~/tp-test/data/ERR3152366.fastq.gz ./data/zymo/ZymoBIOMICS.STD.refseq.v2/Genomes/Bacillus_subtilis_complete_genome.fasta ${output_dir} ERR3152366_b_subtilis &> ${output_dir}/log/ERR3152366_b_subtilis.log

# Illumina pair-end reads on Bacillus subtilis isolates
b_subtilis_ref="./data/zymo/ZymoBIOMICS.STD.refseq.v2/Genomes/Bacillus_subtilis_complete_genome.fasta"
b_subtilis_assembly="./data/zymo/mCaller_analysis_scripts/assemblies/bsubtilis_pb.fasta"

## Minimap2
/usr/bin/time -o ${output_dir}/log/ERR2935851_ref.time -v ./tools/run_best_minimap_pair_end.sh ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz ${b_subtilis_ref} ${output_dir} ERR2935851_ref &> ${output_dir}/log/ERR2935851_ref.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_trim_ref.time -v ./tools/run_best_minimap_pair_end.sh ./data/zymo/ERR2935851_1.trim.fastq.gz ./data/zymo/ERR2935851_2.trim.fastq.gz ${b_subtilis_ref} ${output_dir} ERR2935851_trim_ref &> ${output_dir}/log/ERR2935851_trim_ref.log

/usr/bin/time -o ${output_dir}/log/ERR2935851_assembly.time -v ./tools/run_best_minimap_pair_end.sh ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz ${b_subtilis_assembly}  ${output_dir} ERR2935851_assembly &> ${output_dir}/log/ERR2935851_assembly.log


# PacBio RSII reads on Bacillus subtilis isolates
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
kvmer_dir="skiver"

# Sketching, forward only
/usr/bin/time -o ${output_dir}/log/ERR3152366_kvmer_sketch.time -v ${kvmer_dir} sketch ./data/zymo/ERR3152366.fastq.gz --forward-only -o ${output_dir}/ERR3152366.kvmer  2> ${output_dir}/log/ERR3152366_kvmer_sketch.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_kvmer_sketch.time -v ${kvmer_dir} sketch ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz --forward-only -o ${output_dir}/ERR2935851.kvmer  2> ${output_dir}/log/ERR2935851_kvmer_sketch.log
/usr/bin/time -o ${output_dir}/log/SRR7498042_kvmer_sketch.time -v ${kvmer_dir} sketch ./data/zymo/SRR7498042.fastq --forward-only -o ${output_dir}/SRR7498042.kvmer  2> ${output_dir}/log/SRR7498042_kvmer_sketch.log 
/usr/bin/time -o ${output_dir}/log/SRR13128014_kvmer_sketch.time -v ${kvmer_dir} sketch ./data/zymo/SRR13128014.fastq --forward-only -o ${output_dir}/SRR13128014.kvmer  2> ${output_dir}/log/SRR13128014_kvmer_sketch.log

# Sketching, bidirectional
/usr/bin/time -o ${output_dir}/log/ERR3152366_kvmer_sketch_bi.time -v ${kvmer_dir} sketch ./data/zymo/ERR3152366.fastq.gz -o ${output_dir}/ERR3152366_bi.kvmer  2> ${output_dir}/log/ERR3152366_kvmer_sketch_bi.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_kvmer_sketch_bi.time -v ${kvmer_dir} sketch ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz -o ${output_dir}/ERR2935851_bi.kvmer  2> ${output_dir}/log/ERR2935851_kvmer_sketch_bi.log
/usr/bin/time -o ${output_dir}/log/SRR7498042_kvmer_sketch_bi.time -v ${kvmer_dir} sketch ./data/zymo/SRR7498042.fastq -o ${output_dir}/SRR7498042_bi.kvmer  2> ${output_dir}/log/SRR7498042_kvmer_sketch_bi.log
/usr/bin/time -o ${output_dir}/log/SRR13128014_kvmer_sketch_bi.time -v ${kvmer_dir} sketch ./data/zymo/SRR13128014.fastq -o ${output_dir}/SRR13128014_bi.kvmer  2> ${output_dir}/log/SRR13128014_kvmer_sketch_bi.log


# Analyze without reference, forward only
/usr/bin/time -o ${output_dir}/log/ERR3152366_kvmer_analyze.time -v ${kvmer_dir} analyze ${output_dir}/ERR3152366.kvmer --forward-only --hazard-rate ${output_dir}/ERR3152366_kvmer_hazard_ratio.csv > ${output_dir}/ERR3152366_kvmer.csv 2> ${output_dir}/log/ERR3152366_kvmer_analyze.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_kvmer_analyze.time -v ${kvmer_dir} analyze ${output_dir}/ERR2935851.kvmer --forward-only --hazard-rate ${output_dir}/ERR2935851_kvmer_hazard_ratio.csv > ${output_dir}/ERR2935851_kvmer.csv 2> ${output_dir}/log/ERR2935851_kvmer_analyze.log
/usr/bin/time -o ${output_dir}/log/SRR7498042_kvmer_analyze.time -v ${kvmer_dir} analyze ${output_dir}/SRR7498042.kvmer --forward-only --hazard-rate ${output_dir}/SRR7498042_kvmer_hazard_ratio.csv > ${output_dir}/SRR7498042_kvmer.csv 2> ${output_dir}/log/SRR7498042_kvmer_analyze.log
/usr/bin/time -o ${output_dir}/log/SRR13128014_kvmer_analyze.time -v ${kvmer_dir} analyze ${output_dir}/SRR13128014.kvmer --forward-only --hazard-rate ${output_dir}/SRR13128014_kvmer_hazard_ratio.csv > ${output_dir}/SRR13128014_kvmer.csv 2> ${output_dir}/log/SRR13128014_kvmer_analyze.log
# Analyze without reference --bidirectional
/usr/bin/time -o ${output_dir}/log/ERR3152366_kvmer_bi_analyze.time -v ${kvmer_dir} analyze ${output_dir}/ERR3152366_bi.kvmer --hazard-rate ${output_dir}/ERR3152366_bi_kvmer_hazard_ratio.csv > ${output_dir}/ERR3152366_bi_kvmer.csv 2> ${output_dir}/log/ERR3152366_kvmer_bi_analyze.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_kvmer_bi_analyze.time -v ${kvmer_dir} analyze ${output_dir}/ERR2935851_bi.kvmer --hazard-rate ${output_dir}/ERR2935851_bi_kvmer_hazard_ratio.csv > ${output_dir}/ERR2935851_bi_kvmer.csv 2> ${output_dir}/log/ERR2935851_kvmer_bi_analyze.log
/usr/bin/time -o ${output_dir}/log/SRR7498042_kvmer_bi_analyze.time -v ${kvmer_dir} analyze ${output_dir}/SRR7498042_bi.kvmer --hazard-rate ${output_dir}/SRR7498042_bi_kvmer_hazard_ratio.csv > ${output_dir}/SRR7498042_bi_kvmer.csv 2> ${output_dir}/log/SRR7498042_kvmer_bi_analyze.log
/usr/bin/time -o ${output_dir}/log/SRR13128014_kvmer_bi_analyze.time -v ${kvmer_dir} analyze ${output_dir}/SRR13128014_bi.kvmer --hazard-rate ${output_dir}/SRR13128014_bi_kvmer_hazard_ratio.csv > ${output_dir}/SRR13128014_bi_kvmer.csv 2> ${output_dir}/log/SRR13128014_kvmer_bi_analyze.log


# Analyze with reference
/usr/bin/time -o ${output_dir}/log/ERR3152366_kvmer_ref_analyze.time -v ${kvmer_dir} analyze --forward-only -l 1 --use-all -r ./data/zymo/ZymoBIOMICS.STD.refseq.v2/zymo_community_reference.fasta ${output_dir}/ERR3152366.kvmer --hazard-rate ${output_dir}/ERR3152366_kvmer_ref_hazard_ratio.csv > ${output_dir}/ERR3152366_kvmer_ref.csv 2> ${output_dir}/log/ERR3152366_kvmer_ref_analyze.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_kvmer_ref_analyze.time -v ${kvmer_dir} analyze --forward-only -l 1 --use-all -r ${b_subtilis_ref} ${output_dir}/ERR2935851.kvmer --hazard-rate ${output_dir}/ERR2935851_kvmer_ref_hazard_ratio.csv > ${output_dir}/ERR2935851_kvmer_ref.csv 2> ${output_dir}/log/ERR2935851_kvmer_ref_analyze.log
/usr/bin/time -o ${output_dir}/log/SRR7498042_kvmer_ref_analyze.time -v ${kvmer_dir} analyze --forward-only -l 1 --use-all -r ${b_subtilis_ref} ${output_dir}/SRR7498042.kvmer --hazard-rate ${output_dir}/SRR7498042_kvmer_ref_hazard_ratio.csv > ${output_dir}/SRR7498042_kvmer_ref.csv 2> ${output_dir}/log/SRR7498042_kvmer_ref_analyze.log
/usr/bin/time -o ${output_dir}/log/SRR13128014_kvmer_ref_analyze.time -v ${kvmer_dir} analyze --forward-only -l 1 --use-all -r ./data/zymo/D6331.refseq/zymo_gut_microbiome_reference.fasta ${output_dir}/SRR13128014.kvmer --hazard-rate ${output_dir}/SRR13128014_kvmer_ref_hazard_ratio.csv > ${output_dir}/SRR13128014_kvmer_ref.csv 2> ${output_dir}/log/SRR13128014_kvmer_ref_analyze.log

# Analyze with reference --bidirectional
/usr/bin/time -o ${output_dir}/log/ERR3152366_kvmer_bi_ref_analyze.time -v ${kvmer_dir} analyze -l 1 --use-all -r ./data/zymo/ZymoBIOMICS.STD.refseq.v2/zymo_community_reference.fasta ${output_dir}/ERR3152366_bi.kvmer --hazard-rate ${output_dir}/ERR3152366_bi_kvmer_ref_hazard_ratio.csv > ${output_dir}/ERR3152366_bi_kvmer_ref.csv 2> ${output_dir}/log/ERR3152366_kvmer_bi_ref_analyze.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_kvmer_bi_ref_analyze.time -v ${kvmer_dir} analyze -l 1 --use-all -r ${b_subtilis_ref} ${output_dir}/ERR2935851_bi.kvmer --hazard-rate ${output_dir}/ERR2935851_bi_kvmer_ref_hazard_ratio.csv > ${output_dir}/ERR2935851_bi_kvmer_ref.csv 2> ${output_dir}/log/ERR2935851_kvmer_bi_ref_analyze.log
/usr/bin/time -o ${output_dir}/log/SRR7498042_kvmer_bi_ref_analyze.time -v ${kvmer_dir} analyze -l 1 --use-all -r ${b_subtilis_ref} ${output_dir}/SRR7498042_bi.kvmer --hazard-rate ${output_dir}/SRR7498042_bi_kvmer_ref_hazard_ratio.csv > ${output_dir}/SRR7498042_bi_kvmer_ref.csv 2> ${output_dir}/log/SRR7498042_kvmer_bi_ref_analyze.log
/usr/bin/time -o ${output_dir}/log/SRR13128014_kvmer_bi_ref_analyze.time -v ${kvmer_dir} analyze -l 1 --use-all -r ./data/zymo/D6331.refseq/zymo_gut_microbiome_reference.fasta ${output_dir}/SRR13128014_bi.kvmer --hazard-rate ${output_dir}/SRR13128014_bi_kvmer_ref_hazard_ratio.csv > ${output_dir}/SRR13128014_bi_kvmer_ref.csv 2> ${output_dir}/log/SRR13128014_kvmer_bi_ref_analyze.log