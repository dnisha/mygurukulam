#!/bin/bash

SIZE=${1}
OPERATION=${2}

case "$OPERATION" in

        "t1")
                for (( i=1; i<=${SIZE}; i++ ))
                do
                         for ((j=1; j<=${SIZE}-i; j++))
                         do
                         echo -n " "
                         done

                         for ((k=1; k<=i; k++))
                         do
                         echo -n "*"
                         done

                         echo
                done
        ;;

        "t2")
                for ((i=1; i<=${SIZE}; i++))
                do
                        for ((j=1; j<=i; j++))
                        do
                        echo -n "*"
                        done

                        echo
                done
        ;;

        "t3")
                for ((i=1; i<=${SIZE}; i++))
                do
                        for ((j=1; j<=${SIZE}-i; j++))
                        do
                        echo -n " "
                        done

                        for ((k=1; k<=i*2-1; k++))
                        do
                        echo -n "*"
                        done

                        echo
                done
        ;;

        "t4")
                for ((i=1; i<=${SIZE}; i++ ))
                do
                        for ((j=i; j<=${SIZE}; j++))
                        do
                        echo -n "*"
                        done

                        echo
                done
        ;;

        "t5")
                for ((i=1; i<=${SIZE}; i++ ))
                do
                        for ((j=1; j<i; j++))
                        do
                        echo -n " "
                        done

                        for ((k=i; k<=${SIZE}; k++))
                        do
                        echo -n "*"
                        done

                        echo
                done
        ;;

        "t6")
                for ((i=1; i<=${SIZE}; i++ ))
                do
                        for ((j=1; j<i; j++))
                        do
                        echo -n " "
                        done

                        for ((k=1; k<=(2*${SIZE})-(2*i-1); k++))
                        do
                        echo -n "*"
                        done

                        echo
                done
        ;;

        "t7")

                for ((i=1; i<=${SIZE}; i++))
                do

                        for ((j=${SIZE}; j>i; j--))
                        do
                        echo -n " "
                        done

                        for ((k=1; k<=(2*i-1); k++))
                        do
                        echo -n "*"
                        done

                        echo
                done

                for ((i=(${SIZE}-1); i>=1; i--))
                do
                        for ((j=${SIZE}; j>i; j--))
                        do
                        echo -n " "
                        done

                        for ((k=1; k<=(2*i-1); k++))
                        do
                        echo -n "*"
                        done

                        echo
                done
        ;;
esac
