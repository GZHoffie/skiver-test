output_dir="./output/parameter_dependence"
mkdir -p ${output_dir}
mkdir -p ${output_dir}/log

option=""

# dependence on k and v
k_values=(15 17 19 21 23 25 27 29 31)
v_values=(9 11 13 15 17 19 21 23 25 27 29 31)
e_values=(1e-15) #(0 1e-12 1e-9 1e-6 1e-3)

data_path="./data/zymo/ERR3152366.fastq.gz"
identifier="ERR3152366"

# Split v values into two groups to avoid running too many processes in parallel
v_values=(9 11 13 15 17 19)

#for k in "${k_values[@]}"; do
#    for v in "${v_values[@]}"; do
#        skiver sketch ${data_path} -k $k -v $v -o ${output_dir}/${identifier}_k${k}_v${v}.kvmer &
#    done
#    wait
#done

for k in "${k_values[@]}"; do
    for e in "${e_values[@]}"; do
        for v in "${v_values[@]}"; do
        
            skiver analyze ${output_dir}/${identifier}_k${k}_v${v}.kvmer -k $k -v $v -e $e ${option} -o ${output_dir}/${identifier}_k${k}_v${v}_e${e} &
        done

        wait
        rm ${output_dir}/${identifier}_*.kvmer.csv
        rm ${output_dir}/${identifier}_*.summary_read_position.csv
    done
done

v_values=(21 23 25 27 29 31)

#for k in "${k_values[@]}"; do
#    for v in "${v_values[@]}"; do
#        skiver sketch ${data_path} -k $k -v $v -o ${output_dir}/${identifier}_k${k}_v${v}.kvmer &
#    done
#    wait
#done

for k in "${k_values[@]}"; do
    for e in "${e_values[@]}"; do
        for v in "${v_values[@]}"; do
        
            skiver analyze ${output_dir}/${identifier}_k${k}_v${v}.kvmer -k $k -v $v -e $e ${option} -o ${output_dir}/${identifier}_k${k}_v${v}_e${e} &
        done

        wait
        rm ${output_dir}/${identifier}_*.kvmer.csv
        rm ${output_dir}/${identifier}_*.summary_read_position.csv
    done
done



data_path="./data/zymo/SRR7498042.fastq"
identifier="SRR7498042"

v_values=(9 11 13 15 17 19)

#for k in "${k_values[@]}"; do
#    for v in "${v_values[@]}"; do
#        skiver sketch ${data_path} -k $k -v $v -o ${output_dir}/${identifier}_k${k}_v${v}.kvmer &
#    done
#    wait
#done

for k in "${k_values[@]}"; do
    for e in "${e_values[@]}"; do
        for v in "${v_values[@]}"; do
        
            skiver analyze ${output_dir}/${identifier}_k${k}_v${v}.kvmer -k $k -v $v -e $e ${option} -o ${output_dir}/${identifier}_k${k}_v${v}_e${e} &
        done

        wait
        rm ${output_dir}/${identifier}_*.kvmer.csv
        rm ${output_dir}/${identifier}_*.summary_read_position.csv
    done
done

v_values=(21 23 25 27 29 31)

#for k in "${k_values[@]}"; do
#    for v in "${v_values[@]}"; do
#        skiver sketch ${data_path} -k $k -v $v -o ${output_dir}/${identifier}_k${k}_v${v}.kvmer &
#    done
#    wait
#done

for k in "${k_values[@]}"; do
    for e in "${e_values[@]}"; do
        for v in "${v_values[@]}"; do
        
            skiver analyze ${output_dir}/${identifier}_k${k}_v${v}.kvmer -k $k -v $v -e $e ${option} -o ${output_dir}/${identifier}_k${k}_v${v}_e${e} &
        done

        wait
        rm ${output_dir}/${identifier}_*.kvmer.csv
        rm ${output_dir}/${identifier}_*.summary_read_position.csv
    done
done


data_path="./data/HG002/12_1_22_R1041_ULCIR_HG002_1_dorado0.4.0_sup4.1.0_5mCG_5hmCG_removed_tabs.fastq.gz"
identifier="HG002"

v_values=(9 11 13 15 17 19)

#for k in "${k_values[@]}"; do
#    for v in "${v_values[@]}"; do
#        skiver sketch ${data_path} -k $k -v $v -o ${output_dir}/${identifier}_k${k}_v${v}.kvmer &
#    done
#    wait
#done

for k in "${k_values[@]}"; do
    for e in "${e_values[@]}"; do
        for v in "${v_values[@]}"; do
        
            skiver analyze ${output_dir}/${identifier}_k${k}_v${v}.kvmer -k $k -v $v -e $e ${option} -o ${output_dir}/${identifier}_k${k}_v${v}_e${e} &
        done

        wait
        rm ${output_dir}/${identifier}_*.kvmer.csv
        rm ${output_dir}/${identifier}_*.summary_read_position.csv
    done
done

v_values=(21 23 25 27 29 31)

#for k in "${k_values[@]}"; do
#    for v in "${v_values[@]}"; do
#        skiver sketch ${data_path} -k $k -v $v -o ${output_dir}/${identifier}_k${k}_v${v}.kvmer &
#    done
#    wait
#done

for k in "${k_values[@]}"; do
    for e in "${e_values[@]}"; do
        for v in "${v_values[@]}"; do
        
            skiver analyze ${output_dir}/${identifier}_k${k}_v${v}.kvmer -k $k -v $v -e $e ${option} -o ${output_dir}/${identifier}_k${k}_v${v}_e${e} &
        done

        wait
        rm ${output_dir}/${identifier}_*.kvmer.csv
        rm ${output_dir}/${identifier}_*.summary_read_position.csv
    done
done