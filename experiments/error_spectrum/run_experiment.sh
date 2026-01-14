
kvmer_dir="../kv-mer/target/release/kvmer"

output_dir="./output/error_spectrum"
mkdir -p $output_dir

read_dataset="./data/simulated_data/Ecoli_K12_MG1655_random_depth_128_id_96_homogeneous.fastq"

${kvmer_dir} analyze ${read_dataset} > ${output_dir}/kvmer_output.csv

./tools/run_best_minimap.sh ${read_dataset} ./data/reference/Ecoli_K12_MG1655.fasta ${output_dir} Ecoli_K12_MG1655_depth_128_id_96