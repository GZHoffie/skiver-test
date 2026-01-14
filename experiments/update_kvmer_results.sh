
## zymo
output_dir="./output/zymo"

kvmer_dir="../kv-mer/target/release/kvmer"

b_subtilis_ref="./data/zymo/ZymoBIOMICS.STD.refseq.v2/Genomes/Bacillus_subtilis_complete_genome.fasta"
b_subtilis_assembly="./data/zymo/mCaller_analysis_scripts/assemblies/bsubtilis_pb.fasta"


# Analyze without reference
/usr/bin/time -o ${output_dir}/log/ERR3152366_kvmer_analyze.time -v ${kvmer_dir} analyze ${output_dir}/ERR3152366.kvmer  --hazard-ratio ${output_dir}/ERR3152366_kvmer_hazard_ratio.csv > ${output_dir}/ERR3152366_kvmer.csv 2> ${output_dir}/log/ERR3152366_kvmer_analyze.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_kvmer_analyze.time -v ${kvmer_dir} analyze ${output_dir}/ERR2935851.kvmer  --hazard-ratio ${output_dir}/ERR2935851_kvmer_hazard_ratio.csv > ${output_dir}/ERR2935851_kvmer.csv 2> ${output_dir}/log/ERR2935851_kvmer_analyze.log
/usr/bin/time -o ${output_dir}/log/SRR7498042_kvmer_analyze.time -v ${kvmer_dir} analyze ${output_dir}/SRR7498042.kvmer --hazard-ratio ${output_dir}/SRR7498042_kvmer_hazard_ratio.csv > ${output_dir}/SRR7498042_kvmer.csv 2> ${output_dir}/log/SRR7498042_kvmer_analyze.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_trim_kvmer_analyze.time -v ${kvmer_dir} analyze ${output_dir}/ERR2935851_trim.kvmer --hazard-ratio ${output_dir}/ERR2935851_trim_kvmer_hazard_ratio.csv > ${output_dir}/ERR2935851_trim_kvmer.csv 2> ${output_dir}/log/ERR2935851_trim_kvmer_analyze.log
/usr/bin/time -o ${output_dir}/log/SRR13128014_kvmer_analyze.time -v ${kvmer_dir} analyze ${output_dir}/SRR13128014.kvmer --hazard-ratio ${output_dir}/SRR13128014_kvmer_hazard_ratio.csv > ${output_dir}/SRR13128014_kvmer.csv 2> ${output_dir}/log/SRR13128014_kvmer_analyze.log
# Analyze without reference --bidirectional
/usr/bin/time -o ${output_dir}/log/ERR3152366_kvmer_bi_analyze.time -v ${kvmer_dir} analyze --bidirectional ${output_dir}/ERR3152366_bi.kvmer --hazard-ratio ${output_dir}/ERR3152366_bi_kvmer_hazard_ratio.csv > ${output_dir}/ERR3152366_bi_kvmer.csv 2> ${output_dir}/log/ERR3152366_kvmer_bi_analyze.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_kvmer_bi_analyze.time -v ${kvmer_dir} analyze --bidirectional ${output_dir}/ERR2935851_bi.kvmer --hazard-ratio ${output_dir}/ERR2935851_bi_kvmer_hazard_ratio.csv > ${output_dir}/ERR2935851_bi_kvmer.csv 2> ${output_dir}/log/ERR2935851_kvmer_bi_analyze.log
/usr/bin/time -o ${output_dir}/log/SRR7498042_kvmer_bi_analyze.time -v ${kvmer_dir} analyze --bidirectional ${output_dir}/SRR7498042_bi.kvmer --hazard-ratio ${output_dir}/SRR7498042_bi_kvmer_hazard_ratio.csv > ${output_dir}/SRR7498042_bi_kvmer.csv 2> ${output_dir}/log/SRR7498042_kvmer_bi_analyze.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_trim_kvmer_bi_analyze.time -v ${kvmer_dir} analyze --bidirectional ${output_dir}/ERR2935851_trim_bi.kvmer --hazard-ratio ${output_dir}/ERR2935851_trim_bi_kvmer_hazard_ratio.csv > ${output_dir}/ERR2935851_trim_bi_kvmer.csv 2> ${output_dir}/log/ERR2935851_trim_kvmer_bi_analyze.log
/usr/bin/time -o ${output_dir}/log/SRR13128014_kvmer_bi_analyze.time -v ${kvmer_dir} analyze --bidirectional ${output_dir}/SRR13128014_bi.kvmer --hazard-ratio ${output_dir}/SRR13128014_bi_kvmer_hazard_ratio.csv > ${output_dir}/SRR13128014_bi_kvmer.csv 2> ${output_dir}/log/SRR13128014_kvmer_bi_analyze.log


# Analyze with reference
/usr/bin/time -o ${output_dir}/log/ERR3152366_kvmer_ref_analyze.time -v ${kvmer_dir} analyze -l 1 --use-all -r ./data/zymo/ZymoBIOMICS.STD.refseq.v2/zymo_community_reference.fasta ${output_dir}/ERR3152366.kvmer --hazard-ratio ${output_dir}/ERR3152366_kvmer_ref_hazard_ratio.csv > ${output_dir}/ERR3152366_kvmer_ref.csv 2> ${output_dir}/log/ERR3152366_kvmer_ref_analyze.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_kvmer_ref_analyze.time -v ${kvmer_dir} analyze -l 1 --use-all -r ${b_subtilis_assembly} ${output_dir}/ERR2935851.kvmer --hazard-ratio ${output_dir}/ERR2935851_kvmer_ref_hazard_ratio.csv > ${output_dir}/ERR2935851_kvmer_ref.csv 2> ${output_dir}/log/ERR2935851_kvmer_ref_analyze.log
/usr/bin/time -o ${output_dir}/log/SRR7498042_kvmer_ref_analyze.time -v ${kvmer_dir} analyze -l 1 --use-all -r ${b_subtilis_assembly} ${output_dir}/SRR7498042.kvmer --hazard-ratio ${output_dir}/SRR7498042_kvmer_ref_hazard_ratio.csv > ${output_dir}/SRR7498042_kvmer_ref.csv 2> ${output_dir}/log/SRR7498042_kvmer_ref_analyze.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_trim_kvmer_ref_analyze.time -v ${kvmer_dir} analyze -l 1 --use-all -r ${b_subtilis_assembly} ${output_dir}/ERR2935851_trim.kvmer --hazard-ratio ${output_dir}/ERR2935851_trim_kvmer_ref_hazard_ratio.csv > ${output_dir}/ERR2935851_trim_kvmer_ref.csv 2> ${output_dir}/log/ERR2935851_trim_kvmer_ref_analyze.log
/usr/bin/time -o ${output_dir}/log/SRR13128014_kvmer_ref_analyze.time -v ${kvmer_dir} analyze -l 1 --use-all -r ./data/zymo/D6331.refseq/zymo_gut_microbiome_reference.fasta ${output_dir}/SRR13128014.kvmer --hazard-ratio ${output_dir}/SRR13128014_kvmer_ref_hazard_ratio.csv > ${output_dir}/SRR13128014_kvmer_ref.csv 2> ${output_dir}/log/SRR13128014_kvmer_ref_analyze.log

# Analyze with reference --bidirectional
/usr/bin/time -o ${output_dir}/log/ERR3152366_kvmer_bi_ref_analyze.time -v ${kvmer_dir} analyze --bidirectional -l 1 --use-all -r ./data/zymo/ZymoBIOMICS.STD.refseq.v2/zymo_community_reference.fasta ${output_dir}/ERR3152366_bi.kvmer --hazard-ratio ${output_dir}/ERR3152366_bi_kvmer_ref_hazard_ratio.csv > ${output_dir}/ERR3152366_bi_kvmer_ref.csv 2> ${output_dir}/log/ERR3152366_kvmer_bi_ref_analyze.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_kvmer_bi_ref_analyze.time -v ${kvmer_dir} analyze --bidirectional -l 1 --use-all -r ${b_subtilis_assembly} ${output_dir}/ERR2935851_bi.kvmer --hazard-ratio ${output_dir}/ERR2935851_bi_kvmer_ref_hazard_ratio.csv > ${output_dir}/ERR2935851_bi_kvmer_ref.csv 2> ${output_dir}/log/ERR2935851_kvmer_bi_ref_analyze.log
/usr/bin/time -o ${output_dir}/log/SRR7498042_kvmer_bi_ref_analyze.time -v ${kvmer_dir} analyze --bidirectional -l 1 --use-all  -r ${b_subtilis_assembly} ${output_dir}/SRR7498042_bi.kvmer --hazard-ratio ${output_dir}/SRR7498042_bi_kvmer_ref_hazard_ratio.csv > ${output_dir}/SRR7498042_bi_kvmer_ref.csv 2> ${output_dir}/log/SRR7498042_kvmer_bi_ref_analyze.log
/usr/bin/time -o ${output_dir}/log/ERR2935851_trim_kvmer_bi_ref_analyze.time -v ${kvmer_dir} analyze --bidirectional -l 1 --use-all  -r ${b_subtilis_assembly} ${output_dir}/ERR2935851_trim_bi.kvmer --hazard-ratio ${output_dir}/ERR2935851_trim_bi_kvmer_ref_hazard_ratio.csv > ${output_dir}/ERR2935851_trim_bi_kvmer_ref.csv 2> ${output_dir}/log/ERR2935851_trim_kvmer_bi_ref_analyze.log
/usr/bin/time -o ${output_dir}/log/SRR13128014_kvmer_bi_ref_analyze.time -v ${kvmer_dir} analyze --bidirectional -l 1 --use-all -r ./data/zymo/D6331.refseq/zymo_gut_microbiome_reference.fasta ${output_dir}/SRR13128014_bi.kvmer --hazard-ratio ${output_dir}/SRR13128014_bi_kvmer_ref_hazard_ratio.csv > ${output_dir}/SRR13128014_bi_kvmer_ref.csv 2> ${output_dir}/log/SRR13128014_kvmer_bi_ref_analyze.log

## human
output_dir="./output/human"

# Analyze without reference
/usr/bin/time -o ${output_dir}/log/HG002_kvmer_analyze.time -v ${kvmer_dir} analyze -k 31 -v 13 ${output_dir}/HG002.kvmer --hazard-ratio ${output_dir}/HG002_kvmer_hazard_ratio.csv 2> ${output_dir}/log/HG002_kvmer_analyze.log > ${output_dir}/HG002_kvmer.csv
/usr/bin/time -o ${output_dir}/log/HG002_R941_kvmer.time -v ${kvmer_dir} analyze -k 31 -v 13 ${output_dir}/HG002_R941.kvmer --hazard-ratio ${output_dir}/HG002_R941_kvmer_hazard_ratio.csv 2> ${output_dir}/log/HG002_R941_kvmer_analyze.log > ${output_dir}/HG002_R941_kvmer.csv
/usr/bin/time -o ${output_dir}/log/HG002_hifi_kvmer.time -v ${kvmer_dir} analyze -k 31 -v 13 ${output_dir}/HG002_hifi.kvmer --hazard-ratio ${output_dir}/HG002_hifi_kvmer_hazard_ratio.csv 2> ${output_dir}/log/HG002_hifi_kvmer_analyze.log > ${output_dir}/HG002_hifi_kvmer.csv

# Analyze without reference --bidirectional
/usr/bin/time -o ${output_dir}/log/HG002_bi_kvmer_analyze.time -v ${kvmer_dir} analyze --bidirectional -k 31 -v 13 ${output_dir}/HG002_bi.kvmer --hazard-ratio ${output_dir}/HG002_bi_kvmer_hazard_ratio.csv 2> ${output_dir}/log/HG002_bi_kvmer_analyze.log > ${output_dir}/HG002_bi_kvmer.csv
/usr/bin/time -o ${output_dir}/log/HG002_R941_bi_kvmer_analyze.time -v ${kvmer_dir} analyze --bidirectional -k 31 -v 13 ${output_dir}/HG002_R941_bi.kvmer --hazard-ratio ${output_dir}/HG002_R941_bi_kvmer_hazard_ratio.csv 2> ${output_dir}/log/HG002_R941_bi_kvmer_analyze.log > ${output_dir}/HG002_R941_bi_kvmer.csv
/usr/bin/time -o ${output_dir}/log/HG002_hifi_bi_kvmer_analyze.time -v ${kvmer_dir} analyze --bidirectional -k 31 -v 13 ${output_dir}/HG002_hifi_bi.kvmer --hazard-ratio ${output_dir}/HG002_hifi_bi_kvmer_hazard_ratio.csv 2> ${output_dir}/log/HG002_hifi_bi_kvmer_analyze.log > ${output_dir}/HG002_hifi_bi_kvmer.csv


# Analyze with reference
/usr/bin/time -o ${output_dir}/log/HG002_kvmer_ref_analyze.time -v ${kvmer_dir} analyze -k 31 -v 13 -l 1 -c 10000 --use-all ${output_dir}/HG002.kvmer -r ./data/HG002/hg002v1.1.fasta.gz --hazard-ratio ${output_dir}/HG002_kvmer_ref_hazard_ratio.csv 2> ${output_dir}/log/HG002_kvmer_ref_analyze.log > ${output_dir}/HG002_kvmer_ref.csv
/usr/bin/time -o ${output_dir}/log/HG002_R941_kvmer_ref_analyze.time -v ${kvmer_dir} analyze -k 31 -v 13 -l 1 -c 10000 --use-all ${output_dir}/HG002_R941.kvmer -r ./data/HG002/hg002v1.1.fasta.gz --hazard-ratio ${output_dir}/HG002_R941_kvmer_ref_hazard_ratio.csv 2> ${output_dir}/log/HG002_R941_kvmer_ref_analyze.log > ${output_dir}/HG002_R941_kvmer_ref.csv
/usr/bin/time -o ${output_dir}/log/HG002_hifi_kvmer_ref_analyze.time -v ${kvmer_dir} analyze -k 31 -v 13 -l 1 -c 10000 --use-all ${output_dir}/HG002_hifi.kvmer -r ./data/HG002/hg002v1.1.fasta.gz --hazard-ratio ${output_dir}/HG002_hifi_kvmer_ref_hazard_ratio.csv 2> ${output_dir}/log/HG002_hifi_kvmer_ref_analyze.log > ${output_dir}/HG002_hifi_kvmer_ref.csv

# Analyze with reference --bidirectional
/usr/bin/time -o ${output_dir}/log/HG002_bi_kvmer_ref_analyze.time -v ${kvmer_dir} analyze --bidirectional -k 31 -v 13 -l 1 -c 10000 --use-all ${output_dir}/HG002_bi.kvmer -r ./data/HG002/hg002v1.1.fasta.gz --hazard-ratio ${output_dir}/HG002_bi_kvmer_ref_hazard_ratio.csv 2> ${output_dir}/log/HG002_bi_kvmer_ref_analyze.log > ${output_dir}/HG002_bi_kvmer_ref.csv
/usr/bin/time -o ${output_dir}/log/HG002_R941_bi_kvmer_ref_analyze.time -v ${kvmer_dir} analyze --bidirectional -k 31 -v 13 -l 1 -c 10000 --use-all ${output_dir}/HG002_R941_bi.kvmer -r ./data/HG002/hg002v1.1.fasta.gz --hazard-ratio ${output_dir}/HG002_R941_bi_kvmer_ref_hazard_ratio.csv 2> ${output_dir}/log/HG002_R941_bi_kvmer_ref_analyze.log > ${output_dir}/HG002_R941_bi_kvmer_ref.csv
/usr/bin/time -o ${output_dir}/log/HG002_hifi_bi_kvmer_ref_analyze.time -v ${kvmer_dir} analyze --bidirectional -k 31 -v 13 -l 1 -c 10000 --use-all ${output_dir}/HG002_hifi_bi.kvmer -r ./data/HG002/hg002v1.1.fasta.gz --hazard-ratio ${output_dir}/HG002_hifi_bi_kvmer_ref_hazard_ratio.csv 2> ${output_dir}/log/HG002_hifi_bi_kvmer_ref_analyze.log > ${output_dir}/HG002_hifi_bi_kvmer_ref.csv