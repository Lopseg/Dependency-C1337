#!/bin/bash
while getopts p:i: flag
do
    case "${flag}" in
        p) path=${OPTARG};;
        i) inputfile=${OPTARG};;
    esac
done
echo "Scanning directory: $path";
echo "Filename: $inputfile";
echo "$(wc -l $inputfile) URLS"

#Download de cada package.json utilizando o fff
cat hosts-targets.txt | fff -o $path

#Talvez a rotina a seguir nao seja necessaria
for url in $(cat $inputfile | sort -u):
do
domain_name=$(echo "$url" | sed -e 's|^[^/]*//||' -e 's|/.*$||')
mkdir $path/$domain_name
done

#Start package.json validation
echo "Starting Dustilock analysis"
./Dustilock -p ./$path/ -r
