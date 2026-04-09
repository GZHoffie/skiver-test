output_dir="./output/qscore_calibration"
mkdir -p ${output_dir}
mkdir -p ${output_dir}/log


gatk_dir="./tools/gatk/build/install/gatk/bin/gatk"

# ERR3152366
data_path="data/zymo/ERR3152366.fastq.gz"
bam_path="output/zymo/ERR3152366.bam"
ref_path="data/zymo/ZymoBIOMICS.STD.refseq.v2/zymo_community_reference.fasta"
null_vcf_path="./experiments/qscore_calibration/null.vcf"

${gatk_dir} IndexFeatureFile -I ${null_vcf_path}

samtools faidx ${ref_path}
${gatk_dir} CreateSequenceDictionary -R ${ref_path} -O ${ref_path%.fasta}.dict
${gatk_dir} AddOrReplaceReadGroups -I ${bam_path} -O ${bam_path%.bam}_rg.bam -RGID 1 -RGLB lib1 -RGPL nanopore -RGPU unit1 -RGSM 3
/usr/bin/time -o ${output_dir}/log/ERR3152366_gatk.time -v ${gatk_dir} BaseRecalibrator -I ${bam_path%.bam}_rg.bam -R ${ref_path} --known-sites ./experiments/qscore_calibration/null.vcf -max-cycle 100000 -O ${output_dir}/ERR3152366_gatk_recal_data.table


# Run skiver
/usr/bin/time -o ${output_dir}/log/ERR3152366_skiver_qc.time -v skiver qc data/zymo/ERR3152366.fastq.gz output/zymo/skiver/ERR3152366 -o output/zymo/skiver/ERR3152366.qc.csv
/usr/bin/time -o ${output_dir}/log/ERR3152366_ref_skiver_qc.time -v skiver qc data/zymo/ERR3152366.fastq.gz output/zymo/skiver/ERR3152366_ref -o output/zymo/skiver/ERR3152366_ref.qc.csv

/usr/bin/time -o ${output_dir}/log/SRR13128014_skiver_qc.time -v skiver qc data/zymo/SRR13128014.fastq output/zymo/skiver/SRR13128014 -o output/zymo/skiver/SRR13128014.qc.csv
/usr/bin/time -o ${output_dir}/log/SRR13128014_ref_skiver_qc.time -v skiver qc data/zymo/SRR13128014.fastq.gz output/zymo/skiver/SRR13128014_ref -o output/zymo/skiver/SRR13128014_ref.qc.csv
