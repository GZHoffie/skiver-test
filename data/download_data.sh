# Download E. coli genome
./data/download_from_accession.sh GCF_000005845.2 Ecoli_K12_MG1655 ./data/reference
./data/download_from_accession.sh GCF_000008865.2 Ecoli_O157_H7 ./data/reference

# Download Illumina reads
# Source: https://lomanlab.github.io/mockcommunity/
mkdir -p ./data/zymo/
cd ./data/zymo/
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR293/001/ERR2935851/ERR2935851_2.fastq.gz
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR293/001/ERR2935851/ERR2935851_1.fastq.gz

# Download PacBio Sequel reads
prefetch SRR7415629	

fasterq-dump SRR7415629 --split-files -O ./data/zymo/