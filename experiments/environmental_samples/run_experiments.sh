mkdir -p ./output/environmental_samples

data_path="./data/environmental_samples"
output_path="./output/environmental_samples"
mkdir -p ${output_path}/log


skiver sketch ${data_path}/SRR11742949_*.fastq -o ${output_path}/SRR11742949.kvmer
skiver sketch ${data_path}/SRR14560391_*.fastq -o ${output_path}/SRR14560391.kvmer
skiver sketch ./data/SPMP/ERR7625321.fastq -o ${output_path}/ERR7625321.kvmer

skiver analyze ${output_path}/SRR11742949.kvmer -o ${output_path}/SRR11742949
skiver analyze ${output_path}/SRR14560391.kvmer -o ${output_path}/SRR14560391
skiver analyze ${output_path}/ERR7625321.kvmer -o ${output_path}/ERR7625321

skiver analyze ${output_path}/SRR11742949.kvmer --use-all -o ${output_path}/SRR11742949_no_filt
skiver analyze ${output_path}/SRR14560391.kvmer --use-all -o ${output_path}/SRR14560391_no_filt
skiver analyze ${output_path}/ERR7625321.kvmer --use-all -o ${output_path}/ERR7625321_no_filt

# Plot the results
# Assume skiver is downloaded in the home directory
mkdir -p ./figures/skiver

python ~/skiver/scripts/plot_all.py ${output_path}/SRR11742949 -o ./figures/skiver/SRR11742949
python ~/skiver/scripts/plot_all.py ${output_path}/SRR14560391 -o ./figures/skiver/SRR14560391
python ~/skiver/scripts/plot_all.py ${output_path}/ERR7625321 -o ./figures/skiver/ERR7625321

python ~/skiver/scripts/plot_all.py ${output_path}/SRR11742949_no_filt -o ./figures/skiver/SRR11742949_no_filt
python ~/skiver/scripts/plot_all.py ${output_path}/SRR14560391_no_filt -o ./figures/skiver/SRR14560391_no_filt
python ~/skiver/scripts/plot_all.py ${output_path}/ERR7625321_no_filt -o ./figures/skiver/ERR7625321_no_filt