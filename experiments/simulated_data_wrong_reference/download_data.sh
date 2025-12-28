datasets download genome taxon "Escherichia coli" \
  --reference --assembly-source RefSeq --include genome \
  --filename ./data/references ecoli.zip
unzip -q ecoli_reference_only.zip -d ecoli_reference_only