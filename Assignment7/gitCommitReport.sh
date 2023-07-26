#!/bin/bash
URL=""
DAY=""
FILE_TYPE=""
REPORT_FILE=report.csv
COMMIT_CSV=/tmp/commit.csv
AUTHOR_CSV=/tmp/author.csv
DATE_CSV=/tmp/date.csv
EMAIL_CSV=/tmp/email.csv
COMMENT_CSV=/tmp/comment.csv
CHANGED_FILE_CSV=/tmp/changedfiles.csv
TMP_CSV=/tmp/tmp.csv

while getopts "u:d:" opt; do
  case $opt in
    u)
      URL=$OPTARG
      ;;
    d)
      DAY=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      ;;
  esac
done

main () {

    rm -rf ${REPORT_FILE}
    git clone ${URL}

    git log | awk -F ' ' '/^commit/  { print $2 }' > ${COMMIT_CSV}
    paste -d report.csv ${COMMIT_CSV} > ${TMP_CSV}
    mv ${TMP_CSV} report.csv

    git log | awk -F ' ' '/^Author/  { print $2 }' > ${AUTHOR_CSV}
    paste -d, report.csv ${AUTHOR_CSV} > ${TMP_CSV}
    mv ${TMP_CSV} report.csv

    git log | awk -F ':  ' '/^Date/  { print $2 }' > ${DATE_CSV}
    paste -d, report.csv ${DATE_CSV} > ${TMP_CSV}
    mv ${TMP_CSV} report.csv

    git log | awk -F' ' ' /^Author/ {print $3}' | sed 's/[<,>]//g' > ${EMAIL_CSV}
    paste -d, report.csv ${EMAIL_CSV} > ${TMP_CSV}
    mv ${TMP_CSV} report.csv
    
    git log | awk '/^    / { print $0 }' > ${COMMENT_CSV}
    paste -d, report.csv ${COMMENT_CSV} > ${TMP_CSV}
    mv ${TMP_CSV} report.csv


    rm -rf ${CHANGED_FILE_CSV}
    declare -a commit_messages
    while IFS= read -r line; do
      commit_messages+=("$line")
    done < ${COMMIT_CSV}

    for message in "${commit_messages[@]}"; do

    changed_file=$(git show --stat $message | awk '/[|] / {print}' | awk -F '|' '{print $1}' | tr '\n' '|' | tr -s '[:blank:]')
    echo -e "$changed_file" >> ${CHANGED_FILE_CSV}

    done

    paste -d, report.csv ${CHANGED_FILE_CSV} > ${TMP_CSV}
    mv ${TMP_CSV} report.csv
    format_file
    
}

create_report () {

    git log | awk -F ':  ' '/^Date/  { print $2 }' > ${FILE_TYPE}
    paste -d, report.csv ${FILE_TYPE} > ${TMP_CSV}
    mv ${TMP_CSV} report.csv

}

format_file () {

    header_row="ID,AUTHOR NAME,DATE,EMAIL,COMMIT,CHANGED FILES"
    echo "$header_row" > ${TMP_CSV}
    cat ${REPORT_FILE} | head -n ${DAY} >> ${TMP_CSV}
    mv ${TMP_CSV} ${REPORT_FILE}

}

main ${URL} ${DAY}