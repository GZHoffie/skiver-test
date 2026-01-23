# Experiments for skiver

Below we list the experiment that is contained in each directory. Most directories contain a `run_experiments.sh` file that should be run to create results in the `output/` directory, which are used to generate plots in `plot_results.ipynb`.

|directory|Experiment|
|---------|----------|
|`ablation_study`|Ablation study for skiver: with a constant hazard rate model / without hazard rate outlier filter.|
|`alignment_with_isolates`|Try to use BEST + Minimap2 on the Zymo Log mock community dataset, with references being the isolated genome instead of all the reference genomes.|
|`counting_error_free_kmers`|The most important experiment: on real datasets, find the ground truth survival and hazard rate, and compare skiver with the baselines on their abilities to predict survival and hazard rate.|
|`coverage_dependence`|Experiments of skiver on simulated datasets.|
|`error_spectrum`|Plots of the sequencing error spectra estimated by skiver and BEST+Minimap2.|
|`hazard_rate_example`|For two toy reads, generate how the failure rate/hazard rate look like.|
|`human`|Scripts for running skiver/BEST + Minimap on human reads|
|`multiple_alleles`|Experiments on the behavior of skiver when there are multiple strains in a sample.|
|`qc_by_kmer`|Running KMC + Genomescope2.0 on the zymo/human datasets.|
|`qc_by_quality_score`|Running seqtk on the zymo/human datasets.|
|`simulated_data`|Scripts for generating simulated reads using badread.|
|`simulated_data_wrong_reference`|Experiments on using BEST + Minimap2 to profile error rate of a simulated reads, but given a slightly wrong reference (same species, different strain)|
|`time_memory_usage`|For plotting and summarizing the time/memory usage of the baselines.|
|`zymo`|Scripts for running  skiver/BEST + Minimap on zymo reads.|