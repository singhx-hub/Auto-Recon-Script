#!/bin/bash

domain=$1     
RED="\e[32m"    # Red color
GREEN="\e[32m"  # Green color
YELLOW="\e[33m" # Yellow color
RESET="\e[0m"   # Reset color
banner= "
 ____                            _            _     _   
|  _ \ ___  ___ ___  _ __       / \   ___ ___(_)___| |_ 
| |_) / _ \/ __/ _ \| '_ \     / _ \ / __/ __| / __| __|
|  _ <  __/ (_| (_) | | | |   / ___ \\__ \__ \ \__ \ |_ 
|_| \_\___|\___\___/|_| |_|  /_/   \_\___/___/_|___/\__|
                                 *Powered by Singhx_Hub*
"
whois_info="$domain/whois_info"
subdomains="$domain/subdomains"
screenshots="$domain/screenshots"
nmap_result="$domain/nmap_result"
directory="$domain/directory_enum"
harvester="$domain/harvester"
dirb_enum="$domain/dirbuster"

if [ "$1" == "" ] || [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    echo -e "Usage: $0 <target_domain>"
    echo -e "Example: $0 example.com"
    exit 1
fi
    
if [ ! -d "$domain" ]; then
    mkdir "$domain"
fi

if [ ! -d "$whois_info" ]; then
    mkdir "$whois_info"
fi

if [ ! -d "$subdomains" ]; then
    mkdir "$subdomains"
fi

if [ ! -d "$screenshots" ]; then
    mkdir "$screenshots"
fi

if [ ! -d "$nmap_result" ]; then
    mkdir "$nmap_result"
fi

if [ ! -d "$directory" ]; then
    mkdir "$directory_enum"
fi

if [ ! -d "$harvester" ]; then
    mkdir "$harvester"
fi

echo -e "${GREEN}=================================================================${RESET}"
echo -e "${RED} $banner ${RESET}"
echo -e "${GREEN}=================================================================${RESET}"
echo "Target: $1"

echo -e "${YELLOW}[+] Running WHOIS...${RESET}"
whois $1 > $whois_info/whois.txt

echo -e "${YELLOW}[+] NMAP is in operation...${RESET}"
nmap -sN -p- $1 -v > $nmap_result/nmap.txt

echo -e "${YELLOW}[+] Subdomain enumeration is in progress...${RESET}"
subfinder -d $1 > $subdomains/subdomains.txt

echo -e "${YELLOW}[+] Assetfinder is in progress...${RESET}"
assetfinder $domain | grep $domain >> $subdomains/subdomains.txt

echo -e "${YELLOW}[+] Photon is in progress...${RESET}"
photon $domain >> $subdomains/subdomains.txt

echo -e "${YELLOW}[+] Amass is in progress. This may take some while...${RESET}"
amass enum -d $domain >> $subdomains/subdomains.txt

echo -e "${YELLOW}[+] Checking for available hosts...${RESET}"
$(cat $domain/subdomains.txt | grep $domain | sort -u | httprobe -prefer-https | grep https | sed 's/https\?:\/\///') >> "$subdomains/alive.txt" 

echo -e "${YELLOW}[+] Harvester is in progress...${RESET}"
theHarvester -d $domain > $harvester/data.txt

echo -e "${YELLOW}[+] H8mail is in progress...${RESET}"
grep -E -o "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b" $harvester/data.txt >> $harvester/extracted_emails.txt
h8mail -t $harvester/extracted_emails.txt >> $harvester/data.txt

echo -e "${YELLOW}[+] Dirbuster is in progress...${RESET}"
dirbuster -dir -u $domain -w directory.txt > $dirb_enum/dirb.txt

echo -e "${YELLOW}[+] Taking Screenshots...${RESET}"
gowitness file -f "$subdomains/alive.txt" -P "$screenshots/" --no-http