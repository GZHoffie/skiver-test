output_dir="./output/decontamination"

mkdir -p $output_dir
mkdir -p ${output_dir}/log

# If the index was not downloaded yet, download it
#deacon index fetch panhuman-1
#nohuman --download

# Nanopore R10 dataset
/usr/bin/time -o ${output_dir}/log/deacon_zymo_R10HC.time -v deacon filter -d panhuman-1.k31w15.idx ./data/zymo/Zymo-GridION-EVEN-BB-SN-PCR-R10HC-flipflop.fq.gz -o ./data/zymo/Zymo-GridION-EVEN-BB-SN-PCR-R10HC-flipflop.filt.fq.gz &> ${output_dir}/log/deacon_zymo_R10HC.log
/usr/bin/time -o ${output_dir}/log/nohuman_zymo_R10HC.time -v nohuman ./data/zymo/Zymo-GridION-EVEN-BB-SN-PCR-R10HC-flipflop.fq.gz &> ${output_dir}/log/nohuman_zymo_R10HC.log

# HG002 dataset
/usr/bin/time -o ${output_dir}/log/deacon_hg002.time -v deacon filter -d panhuman-1.k31w15.idx ./data/HG002/12_1_22_R1041_ULCIR_HG002_1_dorado0.4.0_sup4.1.0_5mCG_5hmCG.fastq.gz -o ./data/HG002/12_1_22_R1041_ULCIR_HG002_1_dorado0.4.0_sup4.1.0_5mCG_5hmCG.filt.fastq.gz &> ${output_dir}/log/deacon_hg002.log
/usr/bin/time -o ${output_dir}/log/nohuman_hg002.time -v nohuman ./data/HG002/12_1_22_R1041_ULCIR_HG002_1_dorado0.4.0_sup4.1.0_5mCG_5hmCG.fastq.gz &> ${output_dir}/log/nohuman_hg002.log