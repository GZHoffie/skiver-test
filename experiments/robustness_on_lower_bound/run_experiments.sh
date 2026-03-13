output_dir="./output/robustness_on_lower_bound"
mkdir -p ${output_dir}
mkdir -p ${output_dir}/log

# dependence on k and v
l_values=(0 5 10 15 20 25 30 35 40 45 50)

data_path="./data/zymo/ERR3152366.fastq.gz"
identifier="ERR3152366"

skiver sketch ${data_path} -o ${output_dir}/${identifier}.kvmer
for l in "${l_values[@]}"; do
    skiver analyze ${output_dir}/${identifier}.kvmer --hazard-rate ${output_dir}/${identifier}_hazard_rate_l${l}.csv -l $l > ${output_dir}/${identifier}_l${l}.csv
done

data_path="./data/HG002/12_1_22_R1041_ULCIR_HG002_1_dorado0.4.0_sup4.1.0_5mCG_5hmCG_removed_tabs.fastq.gz"
identifier="HG002"

skiver sketch ${data_path} -c 10000 -o ${output_dir}/${identifier}.kvmer
for l in "${l_values[@]}"; do
    skiver analyze ${output_dir}/${identifier}.kvmer -c 10000 --hazard-rate ${output_dir}/${identifier}_hazard_rate_l${l}.csv -l $l > ${output_dir}/${identifier}_l${l}.csv
done