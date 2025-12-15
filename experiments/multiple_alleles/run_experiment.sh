kvmer_path="/home/ubuntu/kv-mer/target/release/kvmer"
output_dir="output/multiple_alleles"

mkdir -p $output_dir

$kvmer_path analyze ./data/simulated_data/Ecoli_K12_MG1655_random_depth_64_id_96.fastq ./data/simulated_data/Ecoli_O157_H7_random_depth_64_id_96.fastq -o ${output_dir}/two_strain_output.csv &> ${output_dir}/two_strain_output.log
$kvmer_path analyze ./data/simulated_data/Ecoli_K12_MG1655_random_depth_64_id_96.fastq -o ${output_dir}/K12_MG1655_output.csv &> ${output_dir}/K12_MG1655_output.log
$kvmer_path analyze ./data/simulated_data/Ecoli_O157_H7_random_depth_64_id_96.fastq -o ${output_dir}/O157_H7_output.csv &> ${output_dir}/O157_H7_output.log