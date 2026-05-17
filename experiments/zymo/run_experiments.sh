output_dir="./output/zymo"

mkdir -p $output_dir
mkdir -p ${output_dir}/log

# make sure that the scripts have the right permissions
chmod +x ./tools/run_best_minimap.sh
chmod +x ./tools/run_best_minimap_pair_end.sh
chmod +x ./tools/run_best_minimap_with_option.sh




## Default Minimap2 + BEST
# Map and query the Zymo mock community reads, Nanopore Zymo Log dataset
./tools/run_best_minimap.sh ./data/zymo/ERR3152366.fastq.gz ./data/zymo/ZymoBIOMICS.STD.refseq.v2/zymo_community_reference.fasta ${output_dir} ERR3152366 &> ${output_dir}/log/ERR3152366.log
#/usr/bin/time -o ${output_dir}/log/R10HC.time -v ./tools/run_best_minimap.sh ./data/zymo/Zymo-GridION-EVEN-BB-SN-PCR-R10HC-flipflop.fq.gz ./data/zymo/ZymoBIOMICS.STD.refseq.v2/zymo_community_reference.fasta ${output_dir} R10HC &> ${output_dir}/log/R10HC.log
./tools/run_best_minimap.sh ./data/zymo/SRR13128014.fastq ./data/zymo/D6331.refseq/zymo_gut_microbiome_reference.fasta ${output_dir} SRR13128014 &> ${output_dir}/log/SRR13128014.log

#/usr/bin/time -o ${output_dir}/log/ERR3152366_b_subtilis.time -v ./tools/run_best_minimap.sh ~/tp-test/data/ERR3152366.fastq.gz ./data/zymo/ZymoBIOMICS.STD.refseq.v2/Genomes/Bacillus_subtilis_complete_genome.fasta ${output_dir} ERR3152366_b_subtilis &> ${output_dir}/log/ERR3152366_b_subtilis.log

# Illumina pair-end reads on Bacillus subtilis isolates
b_subtilis_ref="./data/zymo/ZymoBIOMICS.STD.refseq.v2/Genomes/Bacillus_subtilis_complete_genome.fasta"
b_subtilis_assembly="./data/zymo/mCaller_analysis_scripts/assemblies/bsubtilis_pb.fasta"

## Minimap2
./tools/run_best_minimap_pair_end.sh ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz ${b_subtilis_ref} ${output_dir} ERR2935851_ref &> ${output_dir}/log/ERR2935851_ref.log
./tools/run_best_minimap_pair_end.sh ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz ${b_subtilis_assembly}  ${output_dir} ERR2935851_assembly &> ${output_dir}/log/ERR2935851_assembly.log


# PacBio RSII reads on Bacillus subtilis isolates
./tools/run_best_minimap.sh ./data/zymo/SRR7498042.fastq ${b_subtilis_ref} ${output_dir} SRR7498042_ref &> ${output_dir}/log/SRR7498042_ref.log
./tools/run_best_minimap.sh ./data/zymo/SRR7498042.fastq ${b_subtilis_assembly} ${output_dir} SRR7498042_assembly &> ${output_dir}/log/SRR7498042_assembly.log






## Minimap2 with options
./tools/run_best_minimap_with_option.sh ./data/zymo/ERR3152366.fastq.gz ./data/zymo/ZymoBIOMICS.STD.refseq.v2/zymo_community_reference.fasta ${output_dir} ERR3152366_opt map-ont &> ${output_dir}/log/ERR3152366_opt.log
#/usr/bin/time -o ${output_dir}/log/R10HC.time -v ./tools/run_best_minimap.sh ./data/zymo/Zymo-GridION-EVEN-BB-SN-PCR-R10HC-flipflop.fq.gz ./data/zymo/ZymoBIOMICS.STD.refseq.v2/zymo_community_reference.fasta ${output_dir} R10HC &> ${output_dir}/log/R10HC.log
./tools/run_best_minimap_with_option.sh ./data/zymo/SRR13128014.fastq ./data/zymo/D6331.refseq/zymo_gut_microbiome_reference.fasta ${output_dir} SRR13128014_opt map-hifi &> ${output_dir}/log/SRR13128014_opt.log

#/usr/bin/time -o ${output_dir}/log/ERR3152366_b_subtilis.time -v ./tools/run_best_minimap.sh ~/tp-test/data/ERR3152366.fastq.gz ./data/zymo/ZymoBIOMICS.STD.refseq.v2/Genomes/Bacillus_subtilis_complete_genome.fasta ${output_dir} ERR3152366_b_subtilis &> ${output_dir}/log/ERR3152366_b_subtilis.log

# Illumina pair-end reads on Bacillus subtilis isolates
b_subtilis_ref="./data/zymo/ZymoBIOMICS.STD.refseq.v2/Genomes/Bacillus_subtilis_complete_genome.fasta"
b_subtilis_assembly="./data/zymo/mCaller_analysis_scripts/assemblies/bsubtilis_pb.fasta"

## Minimap2
#./tools/run_best_minimap_pair_end.sh ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz ${b_subtilis_ref} ${output_dir} ERR2935851_ref &> ${output_dir}/log/ERR2935851_ref.log
#./tools/run_best_minimap_pair_end.sh ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz ${b_subtilis_assembly}  ${output_dir} ERR2935851_assembly_z2000 &> ${output_dir}/log/ERR2935851_assembly.log


# PacBio RSII reads on Bacillus subtilis isolates
./tools/run_best_minimap_with_option.sh ./data/zymo/SRR7498042.fastq ${b_subtilis_ref} ${output_dir} SRR7498042_ref_opt map-pb &> ${output_dir}/log/SRR7498042_ref_opt.log
./tools/run_best_minimap_with_option.sh ./data/zymo/SRR7498042.fastq ${b_subtilis_assembly} ${output_dir} SRR7498042_assembly_opt map-pb &> ${output_dir}/log/SRR7498042_assembly_opt.log




for file in ${output_dir}/*.summary_identity_stats.csv; do
    echo "Processing $file ..."
    # get the basename without everything behind ".summary_identity_stats.csv"
    filename=$(basename -- "$file")
    filename="${filename%.summary_identity_stats.csv}"

    python ./experiments/counting_error_free_kmers/count_mapped_kmers.py -k 1 -K 100 -b ${output_dir}/$filename
done


## Skiver
kvmer_dir="skiver"
option=""
kvmer_suffix=""
b_subtilis_ref="./data/zymo/ZymoBIOMICS.STD.refseq.v2/Genomes/Bacillus_subtilis_complete_genome.fasta"
b_subtilis_assembly="./data/zymo/mCaller_analysis_scripts/assemblies/bsubtilis_pb.fasta"

# Create sketches
echo "Creating sketches for Zymo mock community datasets ..."
/usr/bin/time -o ${output_dir}/log/skiver/ERR3152366_sketch.time -v ${kvmer_dir} sketch ./data/zymo/ERR3152366.fastq.gz $option -o ${output_dir}/skiver/ERR3152366${kvmer_suffix}.kvmer 2> ${output_dir}/log/skiver/ERR3152366_sketch.log
/usr/bin/time -o ${output_dir}/log/skiver/ERR2935851_sketch.time -v ${kvmer_dir} sketch ./data/zymo/ERR2935851_1.fastq.gz $option ./data/zymo/ERR2935851_2.fastq.gz -o ${output_dir}/skiver/ERR2935851${kvmer_suffix}.kvmer 2> ${output_dir}/log/skiver/ERR2935851_sketch.log
/usr/bin/time -o ${output_dir}/log/skiver/SRR7498042_sketch.time -v ${kvmer_dir} sketch ./data/zymo/SRR7498042.fastq $option -o ${output_dir}/skiver/SRR7498042${kvmer_suffix}.kvmer 2> ${output_dir}/log/skiver/SRR7498042_sketch.log
/usr/bin/time -o ${output_dir}/log/skiver/SRR13128014_sketch.time -v ${kvmer_dir} sketch ./data/zymo/SRR13128014.fastq $option -o ${output_dir}/skiver/SRR13128014${kvmer_suffix}.kvmer 2> ${output_dir}/log/skiver/SRR13128014_sketch.log

# Analyze without reference
echo "Analyzing sketches for Zymo mock community datasets without reference ..."
/usr/bin/time -o ${output_dir}/log/skiver/ERR3152366_analyze.time -v ${kvmer_dir} analyze ${output_dir}/skiver/ERR3152366${kvmer_suffix}.kvmer $option -o ${output_dir}/skiver/ERR3152366${kvmer_suffix}
/usr/bin/time -o ${output_dir}/log/skiver/ERR2935851_analyze.time -v ${kvmer_dir} analyze ${output_dir}/skiver/ERR2935851${kvmer_suffix}.kvmer $option -o ${output_dir}/skiver/ERR2935851${kvmer_suffix}
/usr/bin/time -o ${output_dir}/log/skiver/SRR7498042_analyze.time -v ${kvmer_dir} analyze ${output_dir}/skiver/SRR7498042${kvmer_suffix}.kvmer $option -o ${output_dir}/skiver/SRR7498042${kvmer_suffix}
/usr/bin/time -o ${output_dir}/log/skiver/SRR13128014_analyze.time -v ${kvmer_dir} analyze ${output_dir}/skiver/SRR13128014${kvmer_suffix}.kvmer $option -o ${output_dir}/skiver/SRR13128014${kvmer_suffix}


# Analyze with reference
echo "Analyzing sketches for Zymo mock community datasets with reference ..."
/usr/bin/time -o ${output_dir}/log/skiver/ERR3152366_analyze_ref.time -v ${kvmer_dir} analyze ${output_dir}/skiver/ERR3152366${kvmer_suffix}.kvmer $option --use-all -r ./data/zymo/ZymoBIOMICS.STD.refseq.v2/zymo_community_reference.fasta -o ${output_dir}/skiver/ERR3152366_ref${kvmer_suffix}
/usr/bin/time -o ${output_dir}/log/skiver/ERR2935851_analyze_ref.time -v ${kvmer_dir} analyze ${output_dir}/skiver/ERR2935851${kvmer_suffix}.kvmer $option --use-all -r ${b_subtilis_assembly} -o ${output_dir}/skiver/ERR2935851_ref${kvmer_suffix}
/usr/bin/time -o ${output_dir}/log/skiver/SRR7498042_analyze_ref.time -v ${kvmer_dir} analyze ${output_dir}/skiver/SRR7498042${kvmer_suffix}.kvmer $option --use-all -r ${b_subtilis_assembly} -o ${output_dir}/skiver/SRR7498042_ref${kvmer_suffix}
/usr/bin/time -o ${output_dir}/log/skiver/SRR13128014_analyze_ref.time -v ${kvmer_dir} analyze ${output_dir}/skiver/SRR13128014${kvmer_suffix}.kvmer $option --use-all -r ./data/zymo/D6331.refseq/zymo_gut_microbiome_reference.fasta -o ${output_dir}/skiver/SRR13128014_ref${kvmer_suffix}


# Plot the results
# Assume skiver is downloaded in the home directory
mkdir -p ./figures/skiver

for accession in ERR3152366 ERR2935851 SRR7498042 SRR13128014; do
    python ~/skiver/scripts/plot_all.py ${output_dir}/skiver/${accession} -o ./figures/skiver/${accession}
    python ~/skiver/scripts/plot_all.py ${output_dir}/skiver/${accession}_ref -o ./figures/skiver/${accession}_ref
done