kmin=1
kmax=100

## For simulated dataset
prefix=(Ecoli_K12_MG1655_random_depth_64_id_90_homogeneous
        Ecoli_K12_MG1655_random_depth_64_id_92_homogeneous
        Ecoli_K12_MG1655_random_depth_64_id_94_homogeneous
        Ecoli_K12_MG1655_random_depth_64_id_96_homogeneous
        Ecoli_K12_MG1655_random_depth_64_id_98_homogeneous)

# Run alignment with minimap2
for pref in ${prefix[@]}; do
    ./tools/run_best_minimap.sh ./data/simulated_data/${pref}.fastq ./data/reference/Ecoli_K12_MG1655.fasta ./output/simulated_data ${pref}
done

for pref in ${prefix[@]}; do
    python experiments/counting_error_free_kmers/count_mapped_kmers.py -k $kmin -K $kmax -b ./output/simulated_data/${pref} 
done


~/best/target/release/best ./output/simulated_data/Ecoli_K12_MG1655_id_98.bam ./data/reference/Ecoli_K12_MG1655.fasta ./output/simulated_data/Ecoli_K12_MG1655_id_98

for stat_path in ${best_stats[@]}; do
    python experiments/counting_error_free_kmers/count_mapped_kmers.py -k $kmin -K $kmax -b ${stat_path} 
done

## For zymo dataset
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