output_dir="./output/zymo_different_mapping_tools"

mkdir -p $output_dir
mkdir -p ${output_dir}/log

chmod +x ./tools/run_best_minimap.sh
chmod +x ./tools/run_best_minimap_pair_end.sh
chmod +x ./tools/run_best_bwa_pair_end.sh
chmod +x ./tools/run_best_bowtie_pair_end.sh
chmod +x ./tools/run_best_graphmap.sh
chmod +x ./tools/run_best_winnowmap.sh

# Illumina pair-end reads on Bacillus subtilis isolates
b_subtilis_ref="./data/zymo/ZymoBIOMICS.STD.refseq.v2/Genomes/Bacillus_subtilis_complete_genome.fasta"
b_subtilis_assembly="./data/zymo/mCaller_analysis_scripts/assemblies/bsubtilis_pb.fasta"

## Minimap2
/usr/bin/time -o ${output_dir}/log/ERR2935851_ref.time -v ./tools/run_best_minimap_pair_end.sh ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz ${b_subtilis_ref} ${output_dir} ERR2935851_ref &> ${output_dir}/log/ERR2935851_ref.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_assembly.time -v ./tools/run_best_minimap_pair_end.sh ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz ${b_subtilis_assembly}  ${output_dir} ERR2935851_assembly &> ${output_dir}/log/ERR2935851_assembly.log

## bowtie2
/usr/bin/time -o ${output_dir}/log/ERR2935851_ref_bowtie.time -v ./tools/run_best_bowtie_pair_end.sh ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz ${b_subtilis_ref} ${output_dir} ERR2935851_ref_bowtie &> ${output_dir}/log/ERR2935851_ref_bowtie.log

## bwa
/usr/bin/time -o ${output_dir}/log/ERR2935851_ref_bwa.time -v ./tools/run_best_bwa_pair_end.sh ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz ${b_subtilis_ref} ${output_dir} ERR2935851_ref_bwa &> ${output_dir}/log/ERR2935851_ref_bwa.log

## Graphmap
/usr/bin/time -o ${output_dir}/log/ERR3152366_graphmap.time -v ./tools/run_best_graphmap.sh ./data/zymo/ERR3152366.fastq.gz ./data/zymo/ZymoBIOMICS.STD.refseq.v2/zymo_community_reference.fasta ${output_dir} ERR3152366_graphmap &> ${output_dir}/log/ERR3152366_graphmap.log
/usr/bin/time -o ${output_dir}/log/SRR7415629_ref_graphmap.time -v ./tools/run_best_graphmap.sh ./data/zymo/SRR7415629.fastq ${b_subtilis_ref} ${output_dir} SRR7415629_ref_graphmap &> ${output_dir}/log/SRR7415629_ref_graphmap.log

## WInnowmap
/usr/bin/time -o ${output_dir}/log/ERR3152366_winnowmap.time -v ./tools/run_best_winnowmap.sh ./data/zymo/ERR3152366.fastq.gz ./data/zymo/ZymoBIOMICS.STD.refseq.v2/zymo_community_reference.fasta ${output_dir} ERR3152366_winnowmap &> ${output_dir}/log/ERR3152366_winnowmap.log
/usr/bin/time -o ${output_dir}/log/SRR7415629_ref_winnowmap.time -v ./tools/run_best_winnowmap.sh ./data/zymo/SRR7415629.fastq ${b_subtilis_ref} ${output_dir} SRR7415629_ref_winnowmap &> ${output_dir}/log/SRR7415629_ref_winnowmap.log