#!/bin/bash

R='\033[1;31m'
O='\033[1;32m'
Y='\033[1;33m'
B='\033[1;34m'
NC='\033[0m'

desc() {
  printf "################################################\n# Use with arguments:                          #\n#  -a task_name [-[0-3]] : Add new task        #\n#  -d task_name : Delete task                  #\n#  -o task_name : Open task                    #\n#  -l [-c] : List open\\closed tasks            #\n################################################\n"
}

add() {
  if [ -f open_tasks/[0-3]\.${1} ]; then
    echo "Bookmark already exists!" >&2
    exit 1
  fi
  pre=3
  pri=NONE
  case $2 in
    1)
      pre=2
      pri=LOW
      ;;
    2)
      pre=1
      pri=MID
      ;;
    3)
      pre=0
      pri=HIGH
      ;;
  esac
  cp ./template ./open_tasks/"${pre}.${1}"
  printf "Priority: [${pri}]\n" >> ./open_tasks/"${pre}.${1}"
  nano ./open_tasks/"${pre}.${1}"
}

del() {
  mv open_tasks/[0-3]\.${1} closed_tasks/
}

open() {
  nano open_tasks/[0-3]\.${1}
}

list() {
  printf "${2}:\n"
  ls ${1} | 
  while read x; 
    do 
      case ${x:0:1} in
        0)
          printf "[${R}High${NC}] ${x:2}\n"
          ;;
        1)
          printf "[${O}Mid${NC}]  ${x:2}\n"
          ;;
        2)
          printf "[${Y}Low${NC}]  ${x:2}\n"
          ;;
        3)
          printf "[${B}None${NC}] ${x:2}\n"
          ;;
      esac
    done
}

getopts ":a:d:o:l" opt
case $opt in
  a)
    task_name=$OPTARG
    getopts "123" pri
    add $task_name $pri
    exit 0
    ;;
  d)
    del $OPTARG
    exit 0
    ;;
  l)
    getopts "c" c
    if [ $c = c ]; then
      list "closed_tasks/" "Closed tasks"
    else
      list "open_tasks/" "Open tasks"
    fi
    exit 0
    ;;
  o)
    open $OPTARG
    exit 0
    ;;
  \?)
    desc
    exit 0
    ;;
  :)
    echo $OPTARG
    echo "Option -$OPTARG  requries an argument." >&2
    exit 1
    ;;
esac
