seqtk_dir="./tools/seqtk/seqtk"
output_dir="./output/qc_by_quality_score"

mkdir -p ${output_dir}
mkdir -p ${output_dir}/log

# 
/usr/bin/time -o ${output_dir}/log/ERR3152366_seqtk.time -v ${seqtk_dir} fqchk -q0 ./data/zymo/ERR3152366.fastq.gz > ${output_dir}/zymo_ERR3152366_seqtk.fqchk.txt
/usr/bin/time -o ${output_dir}/log/ERR2935851_1_seqtk.time -v ${seqtk_dir} fqchk -q0 ./data/zymo/ERR2935851_1.fastq.gz > ${output_dir}/zymo_ERR2935851_1_seqtk.fqchk.txt
/usr/bin/time -o ${output_dir}/log/ERR2935851_2_seqtk.time -v ${seqtk_dir} fqchk -q0 ./data/zymo/ERR2935851_2.fastq.gz > ${output_dir}/zymo_ERR2935851_2_seqtk.fqchk.txt
/usr/bin/time -o ${output_dir}/log/SRR7415629_seqtk.time -v ${seqtk_dir} fqchk -q0 ./data/zymo/SRR7415629.fastq > ${output_dir}/zymo_SRR7415629_seqtk.fqchk.txt
/usr/bin/time -o ${output_dir}/log/SRR7498042_seqtk.time -v ${seqtk_dir} fqchk -q0 ./data/zymo/SRR7498042.fastq > ${output_dir}/zymo_SRR7498042_seqtk.fqchk.txt