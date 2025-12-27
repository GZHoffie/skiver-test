# Download E. coli genome
./data/download_from_accession.sh GCF_000005845.2 Ecoli_K12_MG1655 ./data/reference
./data/download_from_accession.sh GCF_000008865.2 Ecoli_O157_H7 ./data/reference

# Download reference genomes for zymo community
wget https://s3.amazonaws.com/zymo-files/BioPool/ZymoBIOMICS.STD.refseq.v2.zip
unzip ZymoBIOMICS.STD.refseq.v2.zip
rm ZymoBIOMICS.STD.refseq.v2.zip


# Merge the references into a single fasta file for minimap2
cat ZymoBIOMICS.STD.refseq.v2/Genomes/*.fasta > ZymoBIOMICS.STD.refseq.v2/zymo_community_reference.fasta

# Download Illumina reads
# Source: https://lomanlab.github.io/mockcommunity/
mkdir -p ./data/zymo/
cd ./data/zymo/
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR293/001/ERR2935851/ERR2935851_2.fastq.gz
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR293/001/ERR2935851/ERR2935851_1.fastq.gz

# Download PacBio Sequel reads
prefetch SRR7415629	

fasterq-dump SRR7415629 --split-files -O ./data/zymo/

# Download Bacillus subtilis assembly
git clone https://github.com/al-mcintyre/mCaller_analysis_scripts.git


# Download Human Reads (HG002)
mkdir -p ./data/HG002/
cd ./data/HG002/

wget https://s3-us-west-2.amazonaws.com/human-pangenomics/T2T/scratch/HG002/sequencing/ont/12_1_22_R1041_ULCIR_HG002_dorado0.4.0/12_1_22_R1041_ULCIR_HG002_1_dorado0.4.0_sup4.1.0_5mCG_5hmCG.fastq.gz
# Human reference
wget https://s3-us-west-2.amazonaws.com/human-pangenomics/T2T/HG002/assemblies/hg002v1.1.fasta.gz


# Download Zymo community nanopore reads R10.4
wget https://s3.climb.ac.uk/nanopore/Zymo-GridION-EVEN-BB-SN-PCR-R10HC-flipflop.fq.gz