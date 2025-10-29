output_dir="./output/parameter_dependence"

mkdir -p $output_dir
mkdir -p ${output_dir}/log

kvmer_exec="/home/zhenhao/kv-mer/target/release/kvmer"
data_to_analyze="/home/zhenhao/tp-test/data/ERR3152366.fastq.gz"


k_values=(18 19 20 21 22 23 24 25)
v_values=(14 13 12 11 10 9 8 7)



for i in ${!k_values[@]}; do
  k=${k_values[$i]}
  v=${v_values[$i]}
  echo "Running kv-mer with k=${k} and v=${v}"
  
  output_file=${output_dir}/kvmer_k_${k}_v_${v}.txt

  /usr/bin/time -o ${output_dir}/log/kvmer_k_${k}_v_${v}.time -v ${kvmer_exec} analyze ${data_to_analyze} \
    -k ${k} -v ${v} -c 200 -t 5 \
    > ${output_file}
done