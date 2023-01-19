#!/bin/bash
while getopts i: flag
do
    case "${flag}" in
        i) inputfile=${OPTARG};;
    esac
done
echo "Filename: $inputfile";
echo "$(wc -l $inputfile) URLS"

mkdir all_packages


#Download de cada package.json utilizando o fff
cat $inputfile | fff -o ./all_packages -s 200

for target in $(ls ./all_packages/ )
do
for file in $(ls ./all_packages/$target/ )
do

rm -r ./all_packages/$target/$file/*.headers
mv ./all_packages/$target/$file/*.body ../dustilock/all_packages/$target/
rm -rf ./all_packages/$target/package.json
rm -rf ./all_packages/$target/package-lock.json
mv ./all_packages/$target/*.body ./all_packages/$target/package.json


done
done

#Start package.json validation
echo "Starting Dustilock analysis"
./dustilock -p ./all_packages -r
rm -rf ./all_packages/
