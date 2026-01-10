# Preprocess data
chmod +x ./experiments/mutation_spectrum/remove_unrelated_characters.sh

data_path="./data/Mutational_spectra_data-v1/chrisruis-Mutational_spectra_data-58d4c19"

for file in ${data_path}/data/clade_spectra/*.fasta; do
    echo "Processing file: $file"
    # remove ".fasta" from filename
    #filename="${filename%.*}"
    #output_file=${filename}_orig.fasta
    #./experiments/mutation_spectrum/remove_unrelated_characters.sh $file $output_file
done

# Run experiment
kvmer_path="../kv-mer/target/release/kvmer"

for file in ${data_path}/data/clade_spectra/*_orig.fasta; do
    filename="${file%.*}"
    output_dir=${filename}.kvmer.csv
    output_hazard_rate_dir=${filename}.hazard_rate.csv
    $kvmer_path analyze $file --hazard-rate ${output_hazard_rate_dir}  > ${output_dir}
done