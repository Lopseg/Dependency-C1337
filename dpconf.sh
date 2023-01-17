#!/bin/bash
while getopts p:f: flag
do
    case "${flag}" in
        p) path=${OPTARG};;
        f) filename=${OPTARG};;
    esac
done
echo "Scanning directory: $path";
echo "Filename: $filename";
echo "$(wc -l $filename) URLS"

for url in $(cat $filename):
do
domain_name=$(echo "$url" | sed -e 's|^[^/]*//||' -e 's|/.*$||')
mkdir $path/$domain_name
wget url -P $(pwd)/$path/$domain_name $url > out.log 2> /dev/null
done


echo "Starting Dustilock analysis"
./Dustilock -p ./$path/ -r
