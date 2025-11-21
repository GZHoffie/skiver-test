kmin=1
kmax=100

best_stats=(./output/zymo/ERR3152366
            ./output/zymo/ERR2935851_ref
            ./output/zymo/ERR2935851_assembly
            ./output/zymo/SRR7415629_ref
            ./output/zymo/SRR7415629_assembly)

# Run new version of best
~/best/target/release/best ./output/zymo/ERR3152366.bam ./data/zymo/ZymoBIOMICS.STD.refseq.v2/zymo_community_reference.fasta ./output/zymo/ERR3152366
~/best/target/release/best ./output/zymo/ERR2935851_ref.bam ./data/zymo/ZymoBIOMICS.STD.refseq.v2/Genomes/Bacillus_subtilis_complete_genome.fasta ./output/zymo/ERR2935851_ref
~/best/target/release/best ./output/zymo/ERR2935851_assembly.bam ./data/zymo/mCaller_analysis_scripts/assemblies/bsubtilis_pb.fasta ./output/zymo/ERR2935851_assembly
~/best/target/release/best ./output/zymo/SRR7415629_ref.bam ./data/zymo/ZymoBIOMICS.STD.refseq.v2/Genomes/Bacillus_subtilis_complete_genome.fasta ./output/zymo/SRR7415629_ref
~/best/target/release/best ./output/zymo/SRR7415629_assembly.bam ./data/zymo/mCaller_analysis_scripts/assemblies/bsubtilis_pb.fasta ./output/zymo/SRR7415629_assembly


for stat_path in ${best_stats[@]}; do
    python experiments/counting_error_free_kmers/count_mapped_kmers.py -k $kmin -K $kmax -b ${stat_path} 
done