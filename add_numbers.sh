#!/bin/bash
# Add two numbers.

# If no numbers are given 
if [ $# -ne 2 ]; then
    echo "Supply two numbers, no more, no less"
    exit 1
fi

# Parameters 
first=$1
second=$2

# What is printed 
echo "The sum of $first and $second is $(( $first + $second ))"