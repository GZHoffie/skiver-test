output_dir="./output/alignment_with_isolates"

mkdir -p $output_dir
mkdir -p ${output_dir}/log

kvmer_exec="skiver"
#data_to_analyze="/home/zhenhao/kv-mer-test/data/zymo/ERR2935851_1.fastq.gz /home/zhenhao/kv-mer-test/data/zymo/ERR2935851_2.fastq.gz"
data_to_analyze="/home/ubuntu/kv-mer-test/data/zymo/ERR3152366.fastq.gz"
#data_to_analyze="/home/zhenhao/kv-mer-test/data/zymo/SRR7415629.fastq"

#references="/home/zhenhao/kv-mer-test/data/zymo/ZymoBIOMICS.STD.refseq.v2/Genomes/*.fasta"

for ref in ./data/zymo/ZymoBIOMICS.STD.refseq.v2/Genomes/*.fasta; do
  reference_name=$(basename ${ref} .fasta)
  echo "Processing reference: ${reference_name}"
  output_file_name=ERR3152366_vs_${reference_name}

  /usr/bin/time -o ${output_dir}/log/${output_file_name}.time -v \
   ./tools/run_best_minimap.sh ${data_to_analyze} ${ref} ${output_dir} ${output_file_name}
done

