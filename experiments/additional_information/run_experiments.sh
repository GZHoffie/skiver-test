# This scripts contains several commands to generate plots that are useful but not directly supporting 
# arguments in the paper

mkdir -p ./output/additional_information


# Download mummer
#wget https://github.com/mummer4/mummer/releases/download/v4.0.1/mummer-4.0.1.tar.gz
#tar -xzf ./mummer-4.0.1.tar.gz
#rm ./mummer-4.0.1.tar.gz
#cd ./mummer-4.0.1
#./configure
#make -j"$(nproc)"
#sudo make install
#sudo ldconfig

# Also install gnuplot for plotting mummer plots
#conda install -c conda-forge gnuplot

# Plot mummer plot between E. coli K-12 MG1655 and E. coli O157:H7 Sakai
mkdir -p ./output/additional_information/mummer_plot_pairwise
chmod +x ./experiments/additional_information/run_mummer_plot_pairwise.sh
./experiments/additional_information/run_mummer_plot_pairwise.sh \
  ./output/additional_information/mummer_plot_pairwise/Ecoli \
  ./data/reference/Ecoli_K12_MG1655.fasta \
  ./data/reference/Ecoli_O157_H7.fasta

# Print out the disk usage of the kvmer sketches
du -h ./output/zymo/skiver/*.kvmer
du -h ./output/human/skiver/*.kvmer

# Run skiver on Zymo Log, Nanopore GridION with individual genomes as reference
mkdir -p ./output/additional_information/skiver_zymo_individual
for ref in ./data/zymo/ZymoBIOMICS.STD.refseq.v2/Genomes/*.fasta 
do 
  ref_name=$(basename $ref .fasta)
  skiver analyze ./output/zymo/skiver/ERR3152366.kvmer \
    -r $ref \
    -o ./output/additional_information/skiver_zymo_individual/${ref_name} \
    --use-all
done

# Run GenomeScope on simulated data
output_dir=output/additional_information/genomescope_simulated_data
mkdir -p ./output/additional_information/genomescope_simulated_data
simulated_data_prefix="./data/simulated_data/Ecoli_K12_MG1655_random_depth_128"
subsample_script="./experiments/coverage_dependence/subsample_reads.sh"
read_identity=(90 92 94 96 98 100)
original_coverage=128
subsample_coverage=(100) 
num_experiments=20

for id in ${read_identity[@]}; do
  input_file="${simulated_data_prefix}_id_${id}.fastq"
  for cov in ${subsample_coverage[@]}; do
    subsample_rate=$(echo "scale=6; ${cov}/${original_coverage}" | bc)
    for exp_num in $(seq 1 $num_experiments); do
      output_prefix="Ecoli_K12_MG1655_depth_${cov}_id_${id}_exp_${exp_num}"
      $subsample_script ${input_file} ${subsample_rate} ./temp.fastq

      ./tools/run_genomescope.sh ./temp.fastq ${output_dir} ${output_prefix}
      rm ./temp.fastq
    done
  done
done


# Try running skiver using different values of k and v and record memory/index size
output_dir=output/additional_information/skiver_k_v_experiments
mkdir -p ${output_dir}/log
k=(17 23 29)
v=(11 17 23)
read_file=./data/zymo/ERR3152366.fastq.gz

for k_val in ${k[@]}; do
  for v_val in ${v[@]}; do
    output_prefix="ERR3152366_k_${k_val}_v_${v_val}"
    /usr/bin/time -o ${output_dir}/log/${output_prefix}.time -v \
     skiver sketch ${read_file} -o ${output_dir}/${output_prefix} -k ${k_val} -v ${v_val}
  done
done


# Try running skiver using different values of c and analyze accuracy
output_dir=output/additional_information/skiver_c_experiments
mkdir -p ${output_dir}/log
c=(3000 6000 12000 24000 48000)
read_file=./data/zymo/ERR3152366.fastq.gz

for c_val in ${c[@]}; do
  output_prefix="ERR3152366_c_${c_val}"
  /usr/bin/time -o ${output_dir}/log/${output_prefix}.time -v \
   skiver analyze ${read_file} -o ${output_dir}/${output_prefix} -c ${c_val}
done


# Try running skiver on Illumina dataset with some bases on the ends trimmed
output_dir=output/additional_information/skiver_trimmed_illumina
mkdir -p ${output_dir}/log
trim_base=(0 5 10)

for trim in ${trim_base[@]}; do
  output_prefix="ERR2935851_trim_${trim}"
  skiver sketch ./data/zymo/ERR2935851_1.fastq.gz ./data/zymo/ERR2935851_2.fastq.gz -b ${trim} -f ${trim} -o ${output_dir}/${output_prefix}.kvmer
  skiver analyze ${output_dir}/${output_prefix}.kvmer -o ${output_dir}/${output_prefix}
done
