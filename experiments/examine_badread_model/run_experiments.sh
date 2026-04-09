badread_path="./tools/Badread"

for file in ${badread_path}/badread/qscore_models/*.gz
do
    gzip -d -c $file > ${file%.gz}
done