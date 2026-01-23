# Datasets

This directory contains scripts to download the reads and reference genomes used in the experiments.

## Prerequisite

- Download [NCBI datasets CLI](https://www.ncbi.nlm.nih.gov/datasets/docs/v2/command-line-tools/download-and-install/) to automate downloading reads and references from NCBI.

   ```bash
   conda install -c conda-forge ncbi-datasets-cli
   ```

- Install [sra-tools](https://github.com/ncbi/sra-tools/wiki/02.-Installing-SRA-Toolkit) for downloading reads from SRA.
- `wget` from linux.

## Steps

Directly run the commands in [`download_data.sh`](./download_data.sh) to download the necessary reads and references used in the exepriments. The commands in the script should be run under directory `skiver-test/`.