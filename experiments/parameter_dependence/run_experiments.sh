output_dir="./output/parameter_dependence"
mkdir -p ${output_dir}
mkdir -p ${output_dir}/log

# dependence on k and v
k_values=(21 23 25 27 29 31)
v_values=(25 31) # (7 13 19 25 31)

data_path="./data/zymo/ERR3152366.fastq.gz"
identifier="ERR3152366"

for k in "${k_values[@]}"; do
    for v in "${v_values[@]}"; do
        /usr/bin/time -o ${output_dir}/log/${identifier}_k${k}_v${v}.time -v skiver analyze ${data_path} -k $k -v $v --hazard-rate ${output_dir}/${identifier}_hazard_rate_k${k}_v${v}.csv  > ${output_dir}/${identifier}_k${k}_v${v}.csv
    done
done

data_path="./data/HG002/12_1_22_R1041_ULCIR_HG002_1_dorado0.4.0_sup4.1.0_5mCG_5hmCG_removed_tabs.fastq.gz"
identifier="HG002"

for k in "${k_values[@]}"; do
    for v in "${v_values[@]}"; do
        # Run in background
        /usr/bin/time -o ${output_dir}/log/${identifier}_k${k}_v${v}.time -v skiver analyze ${data_path} -k $k -v $v -c 10000 --hazard-rate ${output_dir}/${identifier}_hazard_rate_k${k}_v${v}.csv > ${output_dir}/${identifier}_k${k}_v${v}.csv &
    done
done