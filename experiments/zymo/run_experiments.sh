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
/usr/bin/time -o ${output_dir}/log/ERR2935851_assembly.time -v ./tools/run_best_minimap_pair_end.sh ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz ${b_subtilis_assembly}  ${output_dir} ERR2935851_assembly &> ${output_dir}/log/ERR2935851_assembly.log

## bowtie2
/usr/bin/time -o ${output_dir}/log/ERR2935851_ref_bowtie.time -v ./tools/run_best_bowtie_pair_end.sh ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz ${b_subtilis_ref} ${output_dir} ERR2935851_ref_bowtie &> ${output_dir}/log/ERR2935851_ref_bowtie.log

# PacBio Sequel reads on Bacillus subtilis isolates
/usr/bin/time -o ${output_dir}/log/SRR7415629_ref.time -v ./tools/run_best_minimap.sh ./data/zymo/SRR7415629.fastq ${b_subtilis_ref} ${output_dir} SRR7415629_ref &> ${output_dir}/log/SRR7415629_ref.log
/usr/bin/time -o ${output_dir}/log/SRR7415629_assembly.time -v ./tools/run_best_minimap.sh ./data/zymo/SRR7415629.fastq ${b_subtilis_assembly} ${output_dir} SRR7415629_assembly &> ${output_dir}/log/SRR7415629_assembly.log