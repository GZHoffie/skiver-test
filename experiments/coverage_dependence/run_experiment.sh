output_dir="./output/coverage_dependence"

mkdir -p $output_dir
mkdir -p ${output_dir}/log

kvmer_dir="skiver"
simulated_data_prefix="./data/simulated_data/Ecoli_K12_MG1655_random_depth_128"
subsample_script="./experiments/coverage_dependence/subsample_reads.sh"
reference_genome="./data/reference/Ecoli_K12_MG1655.fasta"
read_identity=(90 92 94 96 98 100)
#read_identity=(96)
# 64x, 32x, 16x, 8x, 4x, 2x, 1x
original_coverage=128
subsample_coverage=(100 90 80 70 60 50 40 30 20 10)  #(64 32 16 8 4 2 1)
#subsample_coverage=(128)
#num_experiments=20
num_experiments=1

chmod +x $subsample_script

for id in ${read_identity[@]}; do
  input_file="${simulated_data_prefix}_id_${id}_homogeneous.fastq"
  for cov in ${subsample_coverage[@]}; do
    subsample_rate=$(echo "scale=6; ${cov}/${original_coverage}" | bc)
    for exp_num in $(seq 1 $num_experiments); do
      output_prefix="Ecoli_K12_MG1655_depth_${cov}_id_${id}_exp_${exp_num}"
      $subsample_script ${input_file} ${subsample_rate} ./temp.fastq
      ${kvmer_dir} analyze ./temp.fastq --hazard-ratio ${output_dir}/${output_prefix}_hazard_ratio.csv -o ${output_dir}/${output_prefix}_verbose_output.csv > ${output_dir}/${output_prefix}.csv
      ${kvmer_dir} analyze ./temp.fastq -r ${reference_genome} -l 1 --use-all --hazard-ratio ${output_dir}/${output_prefix}_ref_hazard_ratio.csv -o ${output_dir}/${output_prefix}_ref_verbose_output.csv > ${output_dir}/${output_prefix}_ref.csv
      rm ./temp.fastq
    done
  done
done


# Map reads with minimap2 and run best to get alignment-based statistics
output_dir="./output/coverage_dependence_map"

mkdir -p $output_dir

for id in ${read_identity[@]}; do
  ./tools/run_best_minimap.sh ${simulated_data_prefix}_id_${id}_homogeneous.fastq ${reference_genome} ${output_dir} Ecoli_K12_MG1655_depth_128_id_${id}
done

# Find the number of k-mer hits
for file in ${output_dir}/*.summary_identity_stats.csv; do
    echo "Processing $file ..."
    # get the basename without everything behind ".summary_identity_stats.csv"
    filename=$(basename -- "$file")
    filename="${filename%.summary_identity_stats.csv}"

    python ./experiments/counting_error_free_kmers/count_mapped_kmers.py -k 1 -K 100 -b ${output_dir}/$filename
done




