output_dir="./output/parameter_dependence_trim"
mkdir -p ${output_dir}
mkdir -p ${output_dir}/log

# dependence on k and v
k_values=(17 19 21 23 25 27 29 31)
v_values=(22 25 28 31) # (7 10 13 16 19) # 22 25 28 31)

data_path="./data/zymo/ERR3152366.fastq.gz"
identifier="ERR3152366"

for v in "${v_values[@]}"; do
    for k in "${k_values[@]}"; do
        /usr/bin/time -o ${output_dir}/log/${identifier}_k${k}_v${v}.time -v skiver analyze ${data_path} -k $k -v $v -o ${output_dir}/${identifier}_k${k}_v${v} &
    done
    wait
done

data_path="./data/zymo/SRR7498042.fastq"
identifier="SRR7498042"

for v in "${v_values[@]}"; do
    for k in "${k_values[@]}"; do
        /usr/bin/time -o ${output_dir}/log/${identifier}_k${k}_v${v}.time -v skiver analyze ${data_path} -k $k -v $v -o ${output_dir}/${identifier}_k${k}_v${v} &
    done
    wait
done

data_path="./data/HG002/12_1_22_R1041_ULCIR_HG002_1_dorado0.4.0_sup4.1.0_5mCG_5hmCG_removed_tabs.fastq.gz"
identifier="HG002"

for k in "${k_values[@]}"; do
    for v in "${v_values[@]}"; do      
        # Run in background
        /usr/bin/time -o ${output_dir}/log/${identifier}_k${k}_v${v}.time -v skiver analyze ${data_path} -k $k -v $v -o ${output_dir}/${identifier}_k${k}_v${v} &
    done
    wait
done