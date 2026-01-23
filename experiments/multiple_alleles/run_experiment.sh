kvmer_path="skiver"
output_dir="output/multiple_alleles"

mkdir -p $output_dir

#$kvmer_path analyze ./data/simulated_data/Ecoli_K12_MG1655_random_depth_64_id_96.fastq ./data/simulated_data/Ecoli_O157_H7_random_depth_64_id_96.fastq -o ${output_dir}/two_strain_output.csv &> ${output_dir}/two_strain_output.log
#$kvmer_path analyze ./data/simulated_data/Ecoli_K12_MG1655_random_depth_64_id_96.fastq -o ${output_dir}/K12_MG1655_output.csv &> ${output_dir}/K12_MG1655_output.log
#$kvmer_path analyze ./data/simulated_data/Ecoli_O157_H7_random_depth_64_id_96.fastq -o ${output_dir}/O157_H7_output.csv &> ${output_dir}/O157_H7_output.log


kvmer_dir="../kv-mer/target/release/kvmer"
simulated_data1_prefix="./data/simulated_data/Ecoli_K12_MG1655_random_depth_64"
simulated_data2_prefix="./data/simulated_data/Ecoli_O157_H7_random_depth_64"
subsample_script="./experiments/coverage_dependence/subsample_reads.sh"
# 64x, 32x, 16x, 8x, 4x, 2x, 1x

read_identity=(90 92 94 96 98 100)
#read_identity=(100)
mix_ratios=(0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0)
num_experiments=10

chmod +x $subsample_script

for id in ${read_identity[@]}; do
  input_file1="${simulated_data1_prefix}_id_${id}_homogeneous.fastq"
  input_file2="${simulated_data2_prefix}_id_${id}_homogeneous.fastq"

  for ratio in ${mix_ratios[@]}; do
    ratio1=${ratio}
    ratio2=$(echo "scale=6; 1.0 - ${ratio1}" | bc)
    for exp_num in $(seq 1 $num_experiments); do
      output_prefix="Ecoli_K12_MG1655_ratio_${ratio}_id_${id}_exp_${exp_num}"
      $subsample_script ${input_file1} ${ratio1} ./temp1.fastq
      $subsample_script ${input_file2} ${ratio2} ./temp2.fastq

      ${kvmer_dir} analyze ./temp1.fastq ./temp2.fastq --bidirectional --hazard-ratio ${output_dir}/${output_prefix}_bi_hazard_ratio.csv > ${output_dir}/${output_prefix}_bi.csv
      ${kvmer_dir} analyze ./temp1.fastq ./temp2.fastq --use-all --bidirectional --hazard-ratio ${output_dir}/${output_prefix}_bi_no_filter_hazard_ratio.csv > ${output_dir}/${output_prefix}_bi_no_filter.csv



      rm ./temp1.fastq ./temp2.fastq
    done
  done
done



