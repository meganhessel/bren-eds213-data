#!/bin/bash

label=$1
num_reps=$2
query=$3
db_file=$4
csv_file=$5

# get current time and store it
start=$SECONDS  

# loop num_reps times & duckdb db_file query & end loop
for i in $(seq "$num_reps"); do 
    duckdb "$db_file" "$query" > /dev/null 2>&1 # Run query 
done

# get current time
end=$SECONDS 

# compute elapsed time
elapsed=$((end - start)) 

# divide elapsed time by num_reps
avg=$(echo "scale=7; $elapsed / $num_reps" | bc)

# write output as csv 
echo "$label,$avg" >> "$csv_file" # Append into CSV file 

