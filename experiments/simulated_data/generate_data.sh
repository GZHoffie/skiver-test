identity=(100 98 96 94 92 90)
coverage=(32)
output_path="./data/simulated_data"
genome_path="./data/reference/Ecoli_K12_MG1655.fasta"
identifier="Ecoli_K12_MG1655_random_uniform"


mkdir -p $output_path

for depth in ${coverage[@]}; do
  for id in ${identity[@]}; do
    output_file=${output_path}/${identifier}_depth_${depth}_id_${id}.fasta.gz
    badread simulate --reference ${genome_path} --quantity ${depth}x --error_model "random" \
        --qscore_model ideal --glitches 0,0,0 --junk_reads 0 --random_reads 0 --chimeras 0 \
        --identity ${id},100,0 --length 2000,1000 --start_adapter_seq "" --end_adapter_seq "" \
        | gzip > ${output_file}
  done
done

