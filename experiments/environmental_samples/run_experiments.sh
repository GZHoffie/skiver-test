mkdir -p ./output/environmental_samples

data_path="./data/environmental_samples"
output_path="./output/environmental_samples"
mkdir -p ${output_path}/log


skiver sketch ${data_path}/SRR11742949_*.fastq -o ${output_path}/SRR11742949.kvmer
skiver sketch ${data_path}/SRR14560391_*.fastq -o ${output_path}/SRR14560391.kvmer
skiver sketch ./data/ERR7625321.fastq.gz -o ${output_path}/ERR7625321.kvmer

skiver analyze ${output_path}/SRR11742949.kvmer -o ${output_path}/SRR11742949
skiver analyze ${output_path}/SRR14560391.kvmer -o ${output_path}/SRR14560391
skiver analyze ${output_path}/ERR7625321.kvmer -o ${output_path}/ERR7625321

# Run sylph
sylph_db_path="/home/ubuntu/tp-test/databases/gtdb-r220-c200-dbv1.syldb"
/usr/bin/time -o ${output_path}/log/SRR11742949_sylph.time sylph profile $sylph_db_path -1 ${data_path}/SRR11742949_1.fastq -2 ${data_path}/SRR11742949_2.fastq > ${output_path}/SRR11742949_sylph.tsv
/usr/bin/time -o ${output_path}/log/SRR14560391_sylph.time sylph profile $sylph_db_path -1 ${data_path}/SRR14560391_1.fastq -2 ${data_path}/SRR14560391_2.fastq > ${output_path}/SRR14560391_sylph.tsv

/usr/bin/time -o ${output_path}/log/SRR11742949_sylph_u.time sylph profile -u $sylph_db_path -1 ${data_path}/SRR11742949_1.fastq -2 ${data_path}/SRR11742949_2.fastq > ${output_path}/SRR11742949_sylph_u.tsv
/usr/bin/time -o ${output_path}/log/SRR14560391_sylph_u.time sylph profile -u $sylph_db_path -1 ${data_path}/SRR14560391_1.fastq -2 ${data_path}/SRR14560391_2.fastq > ${output_path}/SRR14560391_sylph_u.tsv

sylph profile -u $sylph_db_path -1 ${data_path}/SRR11742949_1.fastq -2 ${data_path}/SRR11742949_2.fastq --read-seq-id 99.8699  > ${output_path}/SRR11742949_sylph_u_read_id.tsv
sylph profile -u $sylph_db_path -1 ${data_path}/SRR14560391_1.fastq -2 ${data_path}/SRR14560391_2.fastq --read-seq-id 99.8216 > ${output_path}/SRR14560391_sylph_u_read_id.tsv
