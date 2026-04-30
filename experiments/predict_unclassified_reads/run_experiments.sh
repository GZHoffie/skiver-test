output_path="./output/predict_unclassified_reads"
mkdir -p ${output_path}/log
data_path="./data/zymo"



sylph_db_path="/home/ubuntu/tp-test/databases/gtdb-r220-c200-dbv1.syldb"
# zymo mock comm
sylph profile -u $sylph_db_path ${data_path}/ERR3152366.fastq.gz > ${output_path}/ERR3152366_sylph_u.tsv
sylph profile -u $sylph_db_path ${data_path}/SRR13128014.fastq > ${output_path}/SRR13128014_sylph_u.tsv
# real sample
sylph profile -u $sylph_db_path ./data/SPMP/ERR7625321.fastq > ${output_path}/ERR7625321_sylph_u.tsv
sylph profile -u  $sylph_db_path -1 ./data/environmental_samples/SRR14560391_1.fastq -2 ./data/environmental_samples/SRR14560391_2.fastq > ${output_path}/SRR14560391_sylph_u.tsv

# Download the genome accessions
python ./data/download_genomes_from_sylph_output.py output/predict_unclassified_reads/ERR3152366_sylph_u.tsv ${output_path}/ERR3152366
python ./data/download_genomes_from_sylph_output.py output/predict_unclassified_reads/SRR13128014_sylph_u.tsv ${output_path}/SRR13128014
python ./data/download_genomes_from_sylph_output.py output/predict_unclassified_reads/ERR7625321_sylph_u.tsv ${output_path}/ERR7625321
python ./data/download_genomes_from_sylph_output.py output/predict_unclassified_reads/SRR14560391_sylph_u.tsv ${output_path}/SRR14560391


# Put all genomes into one file
cat ${output_path}/ERR3152366/*.fasta > ${output_path}/ERR3152366_genomes.fasta
cat ${output_path}/SRR13128014/*.fasta > ${output_path}/SRR13128014_genomes.fasta
cat ${output_path}/ERR7625321/*.fasta > ${output_path}/ERR7625321_genomes.fasta
cat ${output_path}/SRR14560391/*.fasta > ${output_path}/SRR14560391_genomes.fasta

rm -r ${output_path}/ERR3152366
rm -r ${output_path}/SRR13128014
rm -r ${output_path}/ERR7625321
rm -r ${output_path}/SRR14560391

# Run BEST + Minimap2 to get read-level predictions for the unclassified reads
./tools/run_best_minimap.sh ${data_path}/ERR3152366.fastq.gz ${output_path}/ERR3152366_genomes.fasta ${output_path} ERR3152366_sylph
./tools/run_best_minimap.sh ${data_path}/SRR13128014.fastq ${output_path}/SRR13128014_genomes.fasta ${output_path} SRR13128014_sylph
./tools/run_best_minimap.sh ./data/SPMP/ERR7625321.fastq ${output_path}/ERR7625321_genomes.fasta ${output_path} ERR7625321_sylph
./tools/run_best_minimap_pair_end.sh ./data/environmental_samples/SRR14560391_1.fastq ./data/environmental_samples/SRR14560391_2.fastq ${output_path}/SRR14560391_genomes.fasta ${output_path} SRR14560391_sylph
./tools/run_best_bwa_pair_end.sh ./data/environmental_samples/SRR14560391_1.fastq ./data/environmental_samples/SRR14560391_2.fastq ${output_path}/SRR14560391_genomes.fasta ${output_path} SRR14560391_sylph_bwa


rm ${output_path}/*.bam

# Run skiver to predict the survival rate
mkdir -p ${output_path}/skiver
option="-k 17 -v 17"
skiver sketch ${option} ${data_path}/ERR3152366.fastq.gz -o ${output_path}/skiver/ERR3152366.kvmer
skiver sketch ${option} ${data_path}/SRR13128014.fastq -o ${output_path}/skiver/SRR13128014.kvmer
skiver sketch ${option} ./data/SPMP/ERR7625321.fastq -o ${output_path}/skiver/ERR7625321.kvmer
skiver sketch ${option} ./data/environmental_samples/SRR14560391_1.fastq ./data/environmental_samples/SRR14560391_2.fastq -o ${output_path}/skiver/SRR14560391.kvmer

skiver analyze ${option} ${output_path}/skiver/ERR3152366.kvmer -o ${output_path}/skiver/ERR3152366_skiver
skiver analyze ${option} ${output_path}/skiver/SRR13128014.kvmer -o ${output_path}/skiver/SRR13128014_skiver
skiver analyze ${option} ${output_path}/skiver/ERR7625321.kvmer -o ${output_path}/skiver/ERR7625321_skiver
skiver analyze ${option} ${output_path}/skiver/SRR14560391.kvmer -o ${output_path}/skiver/SRR14560391_skiver


#read_id=np.exp(-lambda * (k ** beta)) ** (1/k), k=31
#lambda=0.090999, beta=0.841738
sylph profile -u $sylph_db_path ${data_path}/ERR3152366.fastq.gz --read-seq-id 94.8526  > ${output_path}/ERR3152366_sylph_u_read_id.tsv
#lambda=0.001069, beta=0.958861
sylph profile -u $sylph_db_path ${data_path}/SRR13128014.fastq --read-seq-id 99.9072 > ${output_path}/SRR13128014_sylph_u_read_id.tsv
#lambda=0.070638, beta=0.893494
sylph profile -u $sylph_db_path ./data/SPMP/ERR7625321.fastq --read-seq-id 95.2181 > ${output_path}/ERR7625321_sylph_u_read_id.tsv
#lambda=0.004392, beta=0.804060
sylph profile -u  $sylph_db_path -1 ./data/environmental_samples/SRR14560391_1.fastq -2 ./data/environmental_samples/SRR14560391_2.fastq --read-seq-id 99.7761 > ${output_path}/SRR14560391_sylph_u_read_id.tsv
