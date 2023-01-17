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

for url in filename:
do
domain_name=$(echo "$url" | sed -e 's|^[^/]*//||' -e 's|/.*$||')
mkdir all_packages/$domain_name
wget url -P $(pwd)/all_packages/$domain_name $url
done

./Dustilock -p ./All-Packages/ -r
