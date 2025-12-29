#!/bin/bash
output_dir="./output/qc_by_kmer"

mkdir -p ${output_dir}
mkdir -p ${output_dir}/log

chmod +x ./tools/run_genomescope.sh


/usr/bin/time -o ${output_dir}/log/ERR3152366_genomescope.time -v ./tools/run_genomescope.sh ./data/zymo/ERR3152366.fastq.gz ${output_dir} ERR3152366_genomescope &> ${output_dir}/log/ERR3152366_genomescope.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_1_genomescope.time -v ./tools/run_genomescope.sh ./data/zymo/ERR2935851_1.fastq.gz ${output_dir} ERR2935851_1_genomescope &> ${output_dir}/log/ERR2935851_1_genomescope.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_2_genomescope.time -v ./tools/run_genomescope.sh ./data/zymo/ERR2935851_2.fastq.gz ${output_dir} ERR2935851_2_genomescope &> ${output_dir}/log/ERR2935851_2_genomescope.log
/usr/bin/time -o ${output_dir}/log/SRR7415629_genomescope.time -v ./tools/run_genomescope.sh ./data/zymo/SRR7415629.fastq ${output_dir} SRR7415629_genomescope &> ${output_dir}/log/SRR7415629_genomescope.log
