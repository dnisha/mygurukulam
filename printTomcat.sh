#!/bin/bash

if [ $# -eq 0 ]
then
    echo "Error: No number provided."
    exit 1
fi


number=$1

if (( number % 15 == 0 ))
then
    echo "tomcat"
elif (( number % 3 == 0 ))
then
    echo "tom"
elif (( number % 5 == 0 ))
then
    echo "cat"
fi