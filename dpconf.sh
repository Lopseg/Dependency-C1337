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

for target in $(ls -la ./all_packages/*)
do
for file in $(ls -la ./all_packages/$target/*)
do

for final_file in $(ls -la ./all_packages/$target/$file/*)
do
mv ./all_packages/$target/$file/$final_file ./all_packages/$target/
rm -r ./all_packages/$target/$file
mv ./all_packages/$target/$final_file ./all_packages/$target/$file

done
done

#Start package.json validation
echo "Starting Dustilock analysis"
./Dustilock -p ./all_packages -r
