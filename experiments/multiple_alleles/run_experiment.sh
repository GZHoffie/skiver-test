kvmer_path="skiver"
output_dir="output/multiple_alleles"

mkdir -p $output_dir

#$kvmer_path analyze ./data/simulated_data/Ecoli_K12_MG1655_random_depth_64_id_96.fastq ./data/simulated_data/Ecoli_O157_H7_random_depth_64_id_96.fastq -o ${output_dir}/two_strain_output.csv &> ${output_dir}/two_strain_output.log
#$kvmer_path analyze ./data/simulated_data/Ecoli_K12_MG1655_random_depth_64_id_96.fastq -o ${output_dir}/K12_MG1655_output.csv &> ${output_dir}/K12_MG1655_output.log
#$kvmer_path analyze ./data/simulated_data/Ecoli_O157_H7_random_depth_64_id_96.fastq -o ${output_dir}/O157_H7_output.csv &> ${output_dir}/O157_H7_output.log


kvmer_dir="skiver"
simulated_data1_prefix="./data/simulated_data/Ecoli_K12_MG1655_random_depth_128"
simulated_data2_prefix="./data/simulated_data/Ecoli_O157_H7_random_depth_128"
subsample_script="./experiments/coverage_dependence/subsample_reads.sh"
# 64x, 32x, 16x, 8x, 4x, 2x, 1x

read_identity=(90 92 94 96 98 100)
#read_identity=(100)
mix_ratios=(0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0)
e_list=(0 1e-12)
num_experiments=20
option="-c 1000"

original_coverage=128
experiment_coverage=100

chmod +x $subsample_script

for id in ${read_identity[@]}; do
  input_file1="${simulated_data1_prefix}_id_${id}_homogeneous.fastq"
  input_file2="${simulated_data2_prefix}_id_${id}_homogeneous.fastq"

  
  for exp_num in $(seq 1 $num_experiments); do
    for ratio in ${mix_ratios[@]}; do
      ratio1=$(echo "scale=6; ${ratio}*${experiment_coverage}/${original_coverage}" | bc)
      ratio2=$(echo "scale=6; (1.0 - ${ratio})*${experiment_coverage}/${original_coverage}" | bc)
      output_prefix="Ecoli_K12_MG1655_ratio_${ratio}_id_${id}_exp_${exp_num}"
      $subsample_script ${input_file1} ${ratio1} ./temp1_ratio_${ratio}_exp${exp_num}.fastq &
      $subsample_script ${input_file2} ${ratio2} ./temp2_ratio_${ratio}_exp${exp_num}.fastq &
    done
    wait

    for ratio in ${mix_ratios[@]}; do
      for e in ${e_list[@]}; do
        output_prefix="Ecoli_K12_MG1655_ratio_${ratio}_id_${id}_exp_${exp_num}"
        ${kvmer_dir} analyze ${option} ./temp1_ratio_${ratio}_exp${exp_num}.fastq ./temp2_ratio_${ratio}_exp${exp_num}.fastq -e $e -o ${output_dir}/${output_prefix}_e${e} &
      done
    done
    wait

    rm ./temp1*.fastq ./temp2*.fastq
    rm ${output_dir}/*.kvmer.csv
    rm ${output_dir}/*.summary_error_spectrum*.csv
    rm ${output_dir}/*.summary_read_position.csv
    rm ${output_dir}/*.summary_phred.csv
    rm ${output_dir}/*.summary_gc_content.csv
    rm ${output_dir}/*.hazard_rate.csv
  done
done



