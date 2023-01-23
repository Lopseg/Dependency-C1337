#!/bin/bash
while getopts i: flag
do
    case "${flag}" in
        i) inputfile=${OPTARG};;
    esac
done
./telegram.py "Processing input file: $inputfile"
echo "Filename: $inputfile";
echo "$(wc -l $inputfile) URLS"

./telegram.py "Creating directory: all_packages"
mkdir all_packages


#Download de cada package.json utilizando o fff
./telegram.py "Downloading packages using fff"
cat $inputfile | fff -o ./all_packages -s 200

./telegram.py "Cleaning downloaded packages"
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
./telegram.py "Starting Dustilock analysis"
echo "Starting Dustilock analysis"
./dustilock -p ./all_packages -r
./telegram.py "Removing all packages"
rm -rf ./all_packages/
