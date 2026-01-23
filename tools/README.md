# Tools for running experiments

The following tools are used to generate simulated reads or as baselines in the paper.

**All the following commands should be run under directory `skiver-test/tools`.**

## Badread

Badread is used to generated simulated sequenced long reads. Install with

```bash
pip3 install git+https://github.com/rrwick/Badread.git
badread --help
```

## Seqtk

Seqtk is used for summarizing the quality scores in the sequencing files.

```bash
git clone https://github.com/lh3/seqtk.git;
cd seqtk; make
```

The executable will be in `./tools/seqtk/seqtk`.

## KMC

KMC for generating k-mer histograms for GenomeScope2.0.

```bash
wget https://github.com/refresh-bio/KMC/releases/download/v3.2.4/KMC3.2.4.linux.x64.tar.gz
tar zxvf KMC3.2.4.linux.x64.tar.gz --one-top-level
```

The executable will be in `./tools/KMC3.2.4.linux.x64/bin/kmc`

## GenomeScope2.0

GenomeScope for k-mer based error estimation.

```bash
conda install -c conda-forge r-base r-minpack.lm r-argparse
git clone https://github.com/tbenavi1/genomescope2.0.git
cd genomescope2.0/
Rscript install.R
```

The executable would be located in `./tools/genomescope2.0/genomescope.R`.

## Minimap2

Minimap2 to generate SAM alignment file against some reference file.

```bash
# Under ./tools directory
git clone https://github.com/lh3/minimap2
cd minimap2 && make
```

The binary would be under `./tools/minimap2/minimap2`.

## BEST

BEST is used to infer sequencing error rate from SAM files. Use my forked version of BEST to enable counting k-mers in the reads that are error-free.

```bash
# Under ./tools directory
git clone https://github.com/GZHoffie/best.git
cd best
# build the executable
cargo build --release
```

The executable will be located in `./best/target/release/best`.

## skiver

Follow the guide in the [skiver repository](https://github.com/GZHoffie/skiver) to install skiver.

# Scripts for running the tools

We provide scripts to run pipelines automatically. For each of these scripts, do check that the paths to the tools such as `minimap2_path`, `best_path` are set to the desired relative path starting from the root directory of this repository.

## Best + Minimap2

For single-end reads, run the script

```bash
# Assuming at base directory
./tools/run_best_minimap.sh ${read_file} ${reference_file} ${output_dir} ${output_prefix}
```

For paired-end reads, run the script

```bash
./tools/run_best_minimap_pair_end.sh ${read_file_1} ${read_file_2} ${reference_file} ${output_dir} ${output_prefix}
```

## KMC + Genomescope

Run KMC + Genomescope2.0 pipeline with

```bash
./tools/run_genomescope.sh ${read_file} ${output_dir} ${output_prefix} 
```