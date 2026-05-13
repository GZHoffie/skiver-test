output_dir="./output/zymo/skiver"
kvmer_dir="skiver"

mkdir -p ${output_dir}

## Zymo datasets

# Constant hazard rate model
${kvmer_dir} analyze ${output_dir}/ERR3152366.kvmer --hazard-model "constant" -o ${output_dir}/ERR3152366_const
${kvmer_dir} analyze ${output_dir}/ERR2935851.kvmer --hazard-model "constant" -o ${output_dir}/ERR2935851_const
${kvmer_dir} analyze ${output_dir}/SRR7498042.kvmer --hazard-model "constant" -o ${output_dir}/SRR7498042_const
${kvmer_dir} analyze ${output_dir}/SRR13128014.kvmer --hazard-model "constant" -o ${output_dir}/SRR13128014_const

# No filtering
${kvmer_dir} analyze ${output_dir}/ERR3152366.kvmer --use-all -o ${output_dir}/ERR3152366_no_filt
${kvmer_dir} analyze ${output_dir}/ERR2935851.kvmer --use-all -o ${output_dir}/ERR2935851_no_filt
${kvmer_dir} analyze ${output_dir}/SRR7498042.kvmer --use-all -o ${output_dir}/SRR7498042_no_filt
${kvmer_dir} analyze ${output_dir}/SRR13128014.kvmer --use-all -o ${output_dir}/SRR13128014_no_filt

## Human reads
output_dir="./output/human/skiver"

# Constant hazard rate model
${kvmer_dir} analyze ${output_dir}/HG002.kvmer --hazard-model "constant" -o ${output_dir}/HG002_const
${kvmer_dir} analyze ${output_dir}/HG002_R941.kvmer --hazard-model "constant" -o ${output_dir}/HG002_R941_const
${kvmer_dir} analyze ${output_dir}/HG002_hifi.kvmer --hazard-model "constant" -o ${output_dir}/HG002_hifi_const

# No filtering
${kvmer_dir} analyze ${output_dir}/HG002.kvmer --use-all -o ${output_dir}/HG002_no_filt
${kvmer_dir} analyze ${output_dir}/HG002_R941.kvmer --use-all -o ${output_dir}/HG002_R941_no_filt
${kvmer_dir} analyze ${output_dir}/HG002_hifi.kvmer --use-all -o ${output_dir}/HG002_hifi_no_filt


