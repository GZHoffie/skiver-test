seqtk_dir="./tools/seqtk/seqtk"
output_dir="./output/qc_by_quality_score"

mkdir -p ${output_dir}
mkdir -p ${output_dir}/log

# Zymo datasets
/usr/bin/time -o ${output_dir}/log/ERR3152366_seqtk.time -v ${seqtk_dir} fqchk -q0 ./data/zymo/ERR3152366.fastq.gz > ${output_dir}/zymo_ERR3152366_seqtk.fqchk.txt
/usr/bin/time -o ${output_dir}/log/ERR2935851_combined_seqtk.time -v ${seqtk_dir} fqchk -q0 ./data/zymo/ERR2935851_combined.fastq.gz > ${output_dir}/zymo_ERR2935851_combined_seqtk.fqchk.txt
/usr/bin/time -o ${output_dir}/log/SRR7415629_seqtk.time -v ${seqtk_dir} fqchk -q0 ./data/zymo/SRR7415629.fastq > ${output_dir}/zymo_SRR7415629_seqtk.fqchk.txt
/usr/bin/time -o ${output_dir}/log/SRR7498042_seqtk.time -v ${seqtk_dir} fqchk -q0 ./data/zymo/SRR7498042.fastq > ${output_dir}/zymo_SRR7498042_seqtk.fqchk.txt
/usr/bin/time -o ${output_dir}/log/SRR13128014_seqtk.time -v ${seqtk_dir} fqchk -q0 ./data/zymo/SRR13128014.fastq > ${output_dir}/zymo_SRR13128014_seqtk.fqchk.txt

# Human reads
/usr/bin/time -o ${output_dir}/log/HG002_seqtk.time -v ${seqtk_dir} fqchk -q0 ./data/HG002/12_1_22_R1041_ULCIR_HG002_1_dorado0.4.0_sup4.1.0_5mCG_5hmCG.fastq.gz > ${output_dir}/HG002_seqtk.fqchk.txt
/usr/bin/time -o ${output_dir}/log/HG002_R941_seqtk.time -v ${seqtk_dir} fqchk -q0 ./data/HG002/03_08_22_R941_HG002_2_Guppy_6.0.6_prom_sup.fastq.gz > ${output_dir}/HG002_R941_seqtk.fqchk.txt
/usr/bin/time -o ${output_dir}/log/HG002_hifi_seqtk.time -v ${seqtk_dir} fqchk -q0 ./data/HG002/m84031_231217_034919_s2.hifi_reads.fastq.gz > ${output_dir}/HG002_hifi_seqtk.fqchk.txt