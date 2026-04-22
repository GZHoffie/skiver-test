output_path="./output/predict_unclassified_reads"
mkdir -p ${output_path}/log
data_path="./data/zymo"



sylph_db_path="/home/ubuntu/tp-test/databases/gtdb-r220-c200-dbv1.syldb"
sylph profile -u $sylph_db_path ${data_path}/ERR3152366.fastq.gz > ${output_path}/ERR3152366_sylph_u.tsv
sylph profile -u $sylph_db_path ${data_path}/SRR13128014.fastq > ${output_path}/SRR13128014_sylph_u.tsv

sylph profile -u $sylph_db_path ${data_path}/ERR3152366.fastq.gz --read-seq-id 95.7883  > ${output_path}/SRR11742949_sylph_u_read_id.tsv
sylph profile -u $sylph_db_path ${data_path}/SRR13128014.fastq --read-seq-id 99.9097 > ${output_path}/SRR14560391_sylph_u_read_id.tsv
