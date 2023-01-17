#!/bin/bash
#nao finalizado
while getopts p:f: flag
do
    case "${flag}" in
        p) path=${OPTARG};;
        f) filename=${OPTARG};;
    esac
done
echo "Scanning directory: $path";
echo "Filename: $filename";


for full_url in $(cat $filename):
do
domain_name=$(echo "$url" | sed -e 's|^[^/]*//||' -e 's|/.*$||')
mkdir $path/$domain_name
done

for url in $(cat $filename)
do
wget -q -P $(pwd)/$path/$domain_name $url
done


echo "Starting Dustilock analysis"
./Dustilock -p ./$path/ -r
