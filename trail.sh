#!/bin/bash

while getopts a:b:c: opt; do
  case $opt in
    a)
      echo "Option 'a' is set."
      a=$OPTARG
      ;;
    b)
      echo "Option 'b' is set with value: $OPTARG"
      b=$OPTARG
      ;;
    c)
      echo "Option 'c' is set."
      c=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      ;;
  esac
done

echo "OPTION A=$a B=$b C=$c"