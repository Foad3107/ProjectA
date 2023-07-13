#!/bin/bash


# Create the directories
mkdir /tmp/foad/trueKeyZeroWeight/
mkdir /tmp/foad/trueKeyOneWeight/
mkdir /tmp/foad/falseKeyZeroWeight/
mkdir /tmp/foad/falseKeyOneWeight/
mkdir /tmp/foad/dummy_traces/
# Loop 500 times and run the command each time
for i in {1..500}; do

    # Change plain_0 variable to random hex bytes
    result=`python3 ./pyfile.py`

    # Run the command

    cd ./examples/sw/simple_system/AES_test/
    make
    cd -
    make build-simple-system
    make run-simple-system

    IFS=',' read -r trueKeyVal falseKeyVal <<< "$result"

    # Move the file to the new directory with a new name
    cp ./trace_core_00000000.log /tmp/foad/dummy_traces/trace$i.log
    if [ $trueKeyVal == 1 ]; then
	 cp hamming_weight.txt /tmp/foad/trueKeyOneWeight/hamming_weight$i.txt
    fi	 

    if [ $trueKeyVal == 0 ]; then
	 cp hamming_weight.txt /tmp/foad/trueKeyZeroWeight/hamming_weight$i.txt
    fi

    if [ $falseKeyVal == 1 ]; then
	 cp hamming_weight.txt /tmp/foad/falseKeyOneWeight/hamming_weight$i.txt
    fi	 

    if [ $falseKeyVal == 0 ]; then
	 cp hamming_weight.txt /tmp/foad/falseKeyZeroWeight/hamming_weight$i.txt
    fi
   	
    #remove the file
    rm ./hamming_weight.txt 

done
