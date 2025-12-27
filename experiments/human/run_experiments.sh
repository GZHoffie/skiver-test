output_dir="./output/human"

mkdir -p $output_dir
mkdir -p ${output_dir}/log

# make sure that the scripts have the right permissions
chmod +x ./tools/run_best_minimap.sh
chmod +x ./tools/run_best_minimap_pair_end.sh

# Map and query the Zymo mock community reads, Nanopore Zymo Log dataset
/usr/bin/time -o ${output_dir}/log/HG002.time -v ./tools/run_best_minimap.sh ./data/HG002/12_1_22_R1041_ULCIR_HG002_1_dorado0.4.0_sup4.1.0_5mCG_5hmCG.fastq.gz ./data/HG002/hg002v1.1.fasta.gz ${output_dir} HG002 &> ${output_dir}/log/HG002.log
