#!/bin/bash

input_file=$1
output_file=$2

# Remove unrelated characters (including N,n,-) from the input file
sed 's/[Nn-]//g' "$input_file" > "$output_file"