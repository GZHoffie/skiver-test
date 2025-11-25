output_dir=output/quality_trimming
mkdir -p $output_dir


/usr/bin/time -o $output_dir/ERR2935851.time -v \
fastp \
  -i ./data/zymo/ERR2935851_1.fastq.gz -I ./data/zymo/ERR2935851_2.fastq.gz \
  -o ./data/zymo/ERR2935851_1.trim.fastq.gz -O ./data/zymo/ERR2935851_2.trim.fastq.gz \
  --cut_tail \
  --cut_window_size 4 \
  --length_required 50 \
  --thread 8 \
  --html $output_dir/ERR2935851.html --json $output_dir/ERR2935851.json


/usr/bin/time -o $output_dir/ERR3152366.time -v \
fastplong \
  -i ./data/zymo/ERR3152366.fastq.gz \
  -o ./data/zymo/ERR3152366.trim.fastq.gz \
  -f 100 \
  -t 100 \
  --html $output_dir/ERR3152366.html --json $output_dir/ERR3152366.json