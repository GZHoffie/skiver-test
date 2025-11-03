# Tools for running experiments

## NCBI datasets

For downloading reference genomes.

```bash
conda install -c conda-forge ncbi-datasets-cli
```

## Badread

Badread is used to generated simulated sequenced long reads. Install with

```bash
pip3 install git+https://github.com/rrwick/Badread.git
badread --help
```

## Seqtk

Seqtk is used for subsampling read datasets for analysis with various coverages.

```bash
git clone https://github.com/lh3/seqtk.git;
cd seqtk; make
```

## KMC

KMC for counting how many k-mers are error free.

```bash
conda install bioconda::kmc
```

## Minimap2

Minimap2 to generate SAM alignment file against some reference file.

```bash
# Under ./tools directory
git clone https://github.com/lh3/minimap2
cd minimap2 && make
```

The binary would be under `./minimap2/minimap2`.

## BEST

BEST is used to infer sequencing error rate from SAM files. Download directly from their release 0.1.0.

```bash
# Under ./tools directory
wget https://github.com/google/best/releases/download/0.1.0/best
chmod +x ./best
```

Test the binary using `./best`.

