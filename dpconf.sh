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
cat $inputfile | ./fff -o ./all_packages -s 200

for target in $(ls -la ./all_packages/ | grep -v ' .'$ | grep -v ' ..'$)
do
for file in $(ls -la ./all_packages/$target/ | grep -v ' .'$ | grep -v ' ..'$)
do

mv ./all_packages/$target/$file/*.body ../
rm -r ./all_packages/$target/$file
mv ./all_packages/$target/*.body ../

done
done

#Start package.json validation
echo "Starting Dustilock analysis"
#./Dustilock -p ./all_packages -r
