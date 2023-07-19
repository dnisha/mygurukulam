#!/bin/bash

flag_a=false
flag_l=false
flag_d=false
flag_m=false
flag_r=false

while getopts "an:h:l:u:p:mn:r:i:" opt; do
  case $opt in
    a)
      echo "Option 'a' is set."
      a=$OPTARG
      flag_a=true
      ;;
    n)
      echo "Option 'n' is set."
      n=$OPTARG
      ;;
    h)
      echo "Option 'c' is set."
      h=$OPTARG
      ;;
    u)
      echo "Option 'c' is set."
      u=$OPTARG
      ;;
    p)
      echo "Option 'c' is set."
      p=$OPTARG
      ;;
    l)
      echo "Option 'l' is set."
      l=$OPTARG
      flag_l=true
      ;;
    d)
      echo "Option 'd' is set."
      flag_d=true
      ;;
    m)
      echo "Option 'm' is set."
      m=$OPTARG
      flag_m=true
      ;;
    r)
      echo "Option 'r' is set."
      r=$OPTARG
      flag_r=true
      ;;
    i)
      i=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      ;;
  esac
done



echo "OPTION A=$a N=$n H=$h U=$u P=$p R=$r L=$l I=$i D=$d"


if $flag_a; then
  echo "Flag 'a' is used."
    if [ $flag_a ] && [ ! -z ${n} ] && [ ! -z ${p} ]; then
    echo "performing add operation"
    fi
fi

if $flag_l; then
  echo "Flag 'l' is used with value: $server_name"
fi

if $flag_m; then
  echo "Flag 'm' is used with value: $server_host"
fi

if $flag_r; then
  echo "Flag 'r' is used with value: $username"
fi

