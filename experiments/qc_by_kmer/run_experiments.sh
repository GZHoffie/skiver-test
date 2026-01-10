#!/bin/bash
output_dir="./output/qc_by_kmer"

mkdir -p ${output_dir}
mkdir -p ${output_dir}/log

chmod +x ./tools/run_genomescope.sh


/usr/bin/time -o ${output_dir}/log/ERR3152366_genomescope.time -v ./tools/run_genomescope.sh ./data/zymo/ERR3152366.fastq.gz ${output_dir} ERR3152366_genomescope &> ${output_dir}/log/ERR3152366_genomescope.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_1_genomescope.time -v ./tools/run_genomescope.sh ./data/zymo/ERR2935851_1.fastq.gz ${output_dir} ERR2935851_1_genomescope &> ${output_dir}/log/ERR2935851_1_genomescope.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_2_genomescope.time -v ./tools/run_genomescope.sh ./data/zymo/ERR2935851_2.fastq.gz ${output_dir} ERR2935851_2_genomescope &> ${output_dir}/log/ERR2935851_2_genomescope.log
/usr/bin/time -o ${output_dir}/log/SRR7415629_genomescope.time -v ./tools/run_genomescope.sh ./data/zymo/SRR7415629.fastq ${output_dir} SRR7415629_genomescope &> ${output_dir}/log/SRR7415629_genomescope.log
/usr/bin/time -o ${output_dir}/log/SRR7498042_genomescope.time -v ./tools/run_genomescope.sh ./data/zymo/SRR7498042.fastq ${output_dir} SRR7498042_genomescope &> ${output_dir}/log/SRR7498042_genomescope.log

/usr/bin/time -o ${output_dir}/log/HG002_genomescope.time -v ./tools/run_genomescope.sh ./data/HG002/12_1_22_R1041_ULCIR_HG002_1_dorado0.4.0_sup4.1.0_5mCG_5hmCG.fastq.gz ${output_dir} HG002_genomescope &> ${output_dir}/log/HG002_genomescope.log
/usr/bin/time -o ${output_dir}/log/HG002_R941_genomescope.time -v ./tools/run_genomescope.sh ./data/HG002/03_08_22_R941_HG002_2_Guppy_6.0.6_prom_sup.fastq.gz ${output_dir} HG002_R941_genomescope &> ${output_dir}/log/HG002_R941_genomescope.log
/usr/bin/time -o ${output_dir}/log/HG002_hifi_genomescope.time -v ./tools/run_genomescope.sh ./data/HG002/m84031_231217_034919_s2.hifi_reads.fastq.gz ${output_dir} HG002_hifi_genomescope &> ${output_dir}/log/HG002_hifi_genomescope.log

/usr/bin/time -o ${output_dir}/log/HG002_genomescope.time -v ./tools/run_genomescope.sh ./data/HG002/12_1_22_R1041_ULCIR_HG002_1_dorado0.4.0_sup4.1.0_5mCG_5hmCG_removed_tabs.fastq.gz ${output_dir} HG002_genomescope &> ${output_dir}/log/HG002_genomescope.log
/usr/bin/time -o ${output_dir}/log/HG002_hifi_genomescope.time -v ./tools/run_genomescope.sh ./data/HG002/m84031_231217_034919_s2.hifi_reads_removed_tabs.fastq.gz ${output_dir} HG002_hifi_genomescope &> ${output_dir}/log/HG002_hifi_genomescope.log
