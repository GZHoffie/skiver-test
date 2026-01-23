output_dir="./output/zymo"
kvmer_dir="skiver"

mkdir -p ${output_dir}

## Zymo datasets

# Constant hazard rate model
${kvmer_dir} analyze ${output_dir}/ERR3152366_bi.kvmer --hazard-ratio ${output_dir}/ERR3152366_bi_kvmer_const_hazard_ratio.csv --hazard-model "constant" > ${output_dir}/ERR3152366_bi_kvmer_const.csv
${kvmer_dir} analyze ${output_dir}/ERR2935851_bi.kvmer --hazard-ratio ${output_dir}/ERR2935851_bi_kvmer_const_hazard_ratio.csv --hazard-model "constant" > ${output_dir}/ERR2935851_bi_kvmer_const.csv
${kvmer_dir} analyze ${output_dir}/SRR7498042_bi.kvmer --hazard-ratio ${output_dir}/SRR7498042_bi_kvmer_const_hazard_ratio.csv --hazard-model "constant" > ${output_dir}/SRR7498042_bi_kvmer_const.csv
${kvmer_dir} analyze ${output_dir}/ERR2935851_trim_bi.kvmer --hazard-ratio ${output_dir}/ERR2935851_trim_bi_kvmer_const_hazard_ratio.csv --hazard-model "constant" > ${output_dir}/ERR2935851_trim_bi_kvmer_const.csv
${kvmer_dir} analyze ${output_dir}/SRR13128014_bi.kvmer --hazard-ratio ${output_dir}/SRR13128014_bi_kvmer_const_hazard_ratio.csv --hazard-model "constant" > ${output_dir}/SRR13128014_bi_kvmer_const.csv

# No filtering
${kvmer_dir} analyze ${output_dir}/ERR3152366_bi.kvmer --hazard-ratio ${output_dir}/ERR3152366_bi_kvmer_no_filt_hazard_ratio.csv --use-all > ${output_dir}/ERR3152366_bi_kvmer_no_filt.csv
${kvmer_dir} analyze ${output_dir}/ERR2935851_bi.kvmer --hazard-ratio ${output_dir}/ERR2935851_bi_kvmer_no_filt_hazard_ratio.csv --use-all > ${output_dir}/ERR2935851_bi_kvmer_no_filt.csv
${kvmer_dir} analyze ${output_dir}/SRR7498042_bi.kvmer --hazard-ratio ${output_dir}/SRR7498042_bi_kvmer_no_filt_hazard_ratio.csv --use-all > ${output_dir}/SRR7498042_bi_kvmer_no_filt.csv
${kvmer_dir} analyze ${output_dir}/ERR2935851_trim_bi.kvmer --hazard-ratio ${output_dir}/ERR2935851_trim_bi_kvmer_no_filt_hazard_ratio.csv --use-all > ${output_dir}/ERR2935851_trim_bi_kvmer_no_filt.csv
${kvmer_dir} analyze ${output_dir}/SRR13128014_bi.kvmer --hazard-ratio ${output_dir}/SRR13128014_bi_kvmer_no_filt_hazard_ratio.csv --use-all > ${output_dir}/SRR13128014_bi_kvmer_no_filt.csv

## Human reads
output_dir="./output/human"

# Constant hazard rate model
${kvmer_dir} analyze -k 31 ${output_dir}/HG002_bi.kvmer -o ${output_dir}/HG002_bi_kvmer_verbose.csv --hazard-ratio ${output_dir}/HG002_bi_kvmer_const_hazard_ratio.csv --hazard-model "constant" > ${output_dir}/HG002_bi_kvmer_const.csv
${kvmer_dir} analyze -k 31 ${output_dir}/HG002_R941_bi.kvmer -o ${output_dir}/HG002_R941_bi_kvmer_verbose.csv --hazard-ratio ${output_dir}/HG002_R941_bi_kvmer_const_hazard_ratio.csv --hazard-model "constant" > ${output_dir}/HG002_R941_bi_kvmer_const.csv
${kvmer_dir} analyze -k 31 ${output_dir}/HG002_hifi_bi.kvmer -o ${output_dir}/HG002_hifi_bi_kvmer_verbose.csv --hazard-ratio ${output_dir}/HG002_hifi_bi_kvmer_const_hazard_ratio.csv --hazard-model "constant" > ${output_dir}/HG002_hifi_bi_kvmer_const.csv

# No filtering
${kvmer_dir} analyze -k 31 ${output_dir}/HG002_bi.kvmer --use-all -o ${output_dir}/HG002_bi_kvmer_no_filt_verbose.csv --hazard-ratio ${output_dir}/HG002_bi_kvmer_no_filt_hazard_ratio.csv > ${output_dir}/HG002_bi_kvmer_no_filt.csv
${kvmer_dir} analyze -k 31 ${output_dir}/HG002_R941_bi.kvmer --use-all -o ${output_dir}/HG002_R941_bi_kvmer_no_filt_verbose.csv --hazard-ratio ${output_dir}/HG002_R941_bi_kvmer_no_filt_hazard_ratio.csv > ${output_dir}/HG002_R941_bi_kvmer_no_filt.csv
${kvmer_dir} analyze -k 31 ${output_dir}/HG002_hifi_bi.kvmer --use-all -o ${output_dir}/HG002_hifi_bi_kvmer_no_filt_verbose.csv --hazard-ratio ${output_dir}/HG002_hifi_bi_kvmer_no_filt_hazard_ratio.csv > ${output_dir}/HG002_hifi_bi_kvmer_no_filt.csv


