output_dir="./output/parameter_dependence"

mkdir -p $output_dir
mkdir -p ${output_dir}/log

kvmer_exec="/home/zhenhao/kv-mer/target/release/kvmer"
#data_to_analyze="/home/zhenhao/kv-mer-test/data/zymo/ERR2935851_1.fastq.gz /home/zhenhao/kv-mer-test/data/zymo/ERR2935851_2.fastq.gz"
#data_to_analyze="/home/zhenhao/tp-test/data/ERR3152366.fastq.gz"
data_to_analyze="/home/zhenhao/kv-mer-test/data/zymo/SRR7415629.fastq"


k_values=(18 19 20 21 22 23 24 25)
v_values=(14 13 12 11 10 9 8 7)



for i in ${!k_values[@]}; do
  k=${k_values[$i]}
  v=${v_values[$i]}
  echo "Running kv-mer with k=${k} and v=${v}"

  output_file_name=SRR7415629_k_${k}_v_${v}

  output_file=${output_dir}/${output_file_name}.txt

  /usr/bin/time -o ${output_dir}/log/${output_file_name}.time -v ${kvmer_exec} analyze ${data_to_analyze} \
    -k ${k} -v ${v} -c 1000 -t 5 \
    > ${output_file} 2> ${output_dir}/log/${output_file_name}.log
done