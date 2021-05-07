#!/bin/bash
##
##
## This is a simple and dirty bash script to do a whois lookup 
## from a list of ip addresses where each is on a single line
## 
## It calls whois to loop over a list of hosts provided 
## along with the provided host address after that and line number from the provided list
## Note: Using colours for better readability
function display_usage() {


      cat 1>&2 <<EOF
whois_scan.sh 0.1.0 (2021-07-05)
Simple whois scanner for recon or debugging of various decentralized systems and networks

USAGE:
    ./whois_scan.sh -l[--list] [OPTION]

OPTIONS:
    -l  --list              PATH to lisf of hosts
    -o  --output            Name and/or path for the output file
    -h  --help              Display usage
EOF
}

## Sorry, I just love colours. Delete this if you don't want colours...:) 
RED='\033[1;91m' # WARNINGS
YELLOW='\033[1;93m' # HIGHLIGHTS
WHITE='\033[1;97m' # LARGER FONT
LBLUE='\033[1;96m' # HIGHLIGHTS / NUMBERS ...
LGREEN='\033[1;92m' # SUCCESS
NOCOLOR='\033[0m' # DEFAULT FONT

## If no arguments supplied, display usage
if [ -z "$1" ]
then
printf "%b\n\n" "${RED}You need to provide list of hosts.${WHITE} Run the script again with ${YELLOW} --list ${WHITE}<PATH-TO-LIST>${NOCOLOR}" && exit 2
display_usage
fi

## Print usage
if [[ ("$1" = "--help") ||  "$1" = "-h" ]]
then
display_usage
exit 0
fi 

## Save the list as var and check if the file exists.
if [[ ("$1" = "--list") ||  "$1" = "-l" ]]
then
    
list=$(echo $2) && if [ ! -e ${list} ] ; then printf "%b\n\n" "${WHITE} List ${RED} not found ${WHITE}, are you sure the path is correct?${NOCOLOR}" && exit 2; fi
printf "%b\n\n" "${YELLOW} ${list} ${WHITE} will be used for the whois scan.${NOCOLOR}" 
sleep 2
fi 

## Set the output file 

if [[ ("$3" = "--output") || "$3" = "-o" ]]
then


output_file=$(echo $4) && printf "%b\n\n" "${WHITE}Saving output into ${YELLOW} ${output_file} ${WHITE}.${NOCOLOR}"
fi

## Kill the loop with CTRL+C
trap trapint 2
function trapint {
    exit 0
}

## loop over the list and do whois scan and print out the line number of host, ip addr of host
function scan() {
#set -x
while read ipv4
do  
  line=$((line+1))
  printf "%b\n\n" "${YELLOW}WHOIS ${WHITE} RECORDS FOR ${LBLUE} ${ipv4}${WHITE} AS HOST ${YELLOW}#${line}${WHITE}:${NOCOLOR}" | tee -a $output_file
  whois $ipv4 | tee -a $output_file 
  printf "%b\n\n" "${WHITE}<-----WHOIS---RECORDS---FOR---${LBLUE}HOST${WHITE}----${YELLOW}${line}${WHITE}------------------------->${NOCOLOR}" | tee -a $output_file
  #line=$((line+1))
done < $list    
exit 0
}
scan 2>/dev/null
