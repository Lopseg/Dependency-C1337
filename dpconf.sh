#!/bin/bash
while getopts i: flag
do
    case "${flag}" in
        i) inputfile=${OPTARG};;
    esac
done
echo "Filename: $inputfile";
echo "$(wc -l $inputfile) URLS"

#Download de cada package.json utilizando o fff
cat hosts-targets.txt | .fff -o ./all_packages -s 200


#Start package.json validation
echo "Starting Dustilock analysis"
./Dustilock -p ./all_packages -r
