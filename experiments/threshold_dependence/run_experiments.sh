output_dir="./output/threshold_dependence"
mkdir -p ${output_dir}
kvmer_sketch_dir="./output/zymo"

threshold=(0 10 20 30 40 50 60 70 80 90 100)

b_subtilis_ref="./data/zymo/ZymoBIOMICS.STD.refseq.v2/Genomes/Bacillus_subtilis_complete_genome.fasta"
b_subtilis_assembly="./data/zymo/mCaller_analysis_scripts/assemblies/bsubtilis_pb.fasta"


# Analyze without reference
for lower_bound in ${threshold[@]};
do
    skiver analyze ${kvmer_sketch_dir}/skiver/ERR3152366.kvmer -l ${lower_bound} -o ${output_dir}/ERR3152366_l${lower_bound}
    skiver analyze ${kvmer_sketch_dir}/skiver/ERR2935851.kvmer -l ${lower_bound} -o ${output_dir}/ERR2935851_l${lower_bound}
    skiver analyze ${kvmer_sketch_dir}/skiver/SRR7498042.kvmer -l ${lower_bound} -o ${output_dir}/SRR7498042_l${lower_bound}
    skiver analyze ${kvmer_sketch_dir}/skiver/SRR13128014.kvmer -l ${lower_bound} -o ${output_dir}/SRR13128014_l${lower_bound}

    # with reference
    skiver analyze ${kvmer_sketch_dir}/skiver/ERR3152366.kvmer -l ${lower_bound} --use-all -r ./data/zymo/ZymoBIOMICS.STD.refseq.v2/zymo_community_reference.fasta -o ${output_dir}/ERR3152366_ref_l${lower_bound}
    skiver analyze ${kvmer_sketch_dir}/skiver/ERR2935851.kvmer -l ${lower_bound} --use-all -r ${b_subtilis_assembly} -o ${output_dir}/ERR2935851_ref_l${lower_bound}
    skiver analyze ${kvmer_sketch_dir}/skiver/SRR7498042.kvmer -l ${lower_bound} --use-all -r ${b_subtilis_assembly} -o ${output_dir}/SRR7498042_ref_l${lower_bound}
    skiver analyze ${kvmer_sketch_dir}/skiver/SRR13128014.kvmer -l ${lower_bound} --use-all -r ./data/zymo/D6331.refseq/zymo_gut_microbiome_reference.fasta -o ${output_dir}/SRR13128014_ref_l${lower_bound}
done
