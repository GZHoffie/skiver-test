output_dir="./output/coverage_dependence"

mkdir -p $output_dir
mkdir -p ${output_dir}/log

kvmer_dir="../kv-mer/target/release/kvmer"
simulated_data_prefix="./data/simulated_data/Ecoli_K12_MG1655_random_depth_64"
subsample_script="./experiments/coverage_dependence/subsample_reads.sh"
read_identity=(98) #(90 92 94 96 98)
# 64x, 32x, 16x, 8x, 4x, 2x, 1x
original_coverage=64
subsample_coverage=(8 4 2 1)
num_experiments=2 #20

chmod +x $subsample_script

for id in ${read_identity[@]}; do
  input_file="${simulated_data_prefix}_id_${id}_homogeneous.fastq"
  for cov in ${subsample_coverage[@]}; do
    subsample_rate=$(echo "scale=6; ${cov}/${original_coverage}" | bc)
    for exp_num in $(seq 1 $num_experiments); do
      output_prefix="Ecoli_K12_MG1655_depth_${cov}_id_${id}_exp_${exp_num}"
      $subsample_script ${input_file} ${subsample_rate} ./temp.fastq
      /usr/bin/time -o ${output_dir}/log/${output_prefix}.time -v ${kvmer_dir} analyze ./temp.fastq -l 2 > ${output_dir}/${output_prefix}.csv
      /usr/bin/time -o ${output_dir}/log/${output_prefix}_bidirectional.time -v ${kvmer_dir} analyze ./temp.fastq -l 2 --bidirectional > ${output_dir}/${output_prefix}_bidirectional.csv
      rm ./temp.fastq
    done
  done
done



