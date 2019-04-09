#!/bin/bash
NPM=false
cd ~/Developer/projects/TrikoUserApp

# Reading the terminal params
while getopts "n" opt; do
  case $opt in
  	n)
		NPM=true
		;;    
    *)	
      ;;
  esac
done

if $NPM ; then
	echo "Using npm...";
	npm start -- --reset-cache
else 
	echo "Using react-native-cli...";
	react-native run-android
fi