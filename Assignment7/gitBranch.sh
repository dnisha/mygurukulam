#!/bin/bash

OPERATION=""
BRANCH=""
NEW_BRANCH=""

while getopts "rlb:d:m1:2:" opt; do
  case $opt in
    b)
        echo "got b with value $OPTARG"
        OPERATION=Create
        BRANCH=$OPTARG
      ;;
    d)
        echo "got d with value $OPTARG"
        OPERATION=Delete
        BRANCH=$OPTARG
      ;;
    l)
        echo "got m with value $OPTARG"
        OPERATION=List
      ;;
    m)
        echo "got m with value $OPTARG"
        OPERATION=Merge
      ;;
    r)
        echo "got r with value $OPTARG"
        OPERATION=Rebase
      ;;
    2)
        echo "got 2 with value $OPTARG"
        NEW_BRANCH=$OPTARG
      ;;
    1)
        echo "got 1 with value $OPTARG"
        BRANCH=$OPTARG
    
      ;;
  esac
done 2>/dev/null

main () {

    case ${OPERATION} in  
    "Create")  

        create_branch ${BRANCH}      
        ;;  
    "List")  

        list_branch ${BRANCH}      
        ;;  

    "Delete")  

        delete_branch ${BRANCH}      
        ;;

    "Merge")  

        merge_branch ${BRANCH} ${NEW_BRANCH}  
        ;;  
    
    "Rebase")  
        rebase_branch ${BRANCH} ${NEW_BRANCH}  
        ;;  
    esac

}

list_branch () {
    git branch -a
}

create_branch () {
    git branch ${BRANCH}
}

delete_branch () {
    git branch -d ${BRANCH}
}

merge_branch () {
    git checkout ${BRANCH}
    git merge ${NEW_BRANCH}
}

rebase_branch () {
    git checkout ${BRANCH}
    git rebase main ${NEW_BRANCH}
}

main $1