# Recon Automation Script

This Bash script automates various reconnaissance tasks for a target domain. It performs WHOIS lookup, NMAP scanning, subdomain enumeration, host availability check, information gathering, email reconnaissance, directory enumeration, and takes screenshots of live subdomains.

## Usage
      
        $ ./recon.sh <target_domain>

Replace <target_domain> with the domain you want to perform reconnaissance on. For example:

        $ ./recon.sh example.com

## Prerequisites

### Make sure you have the following tools installed:

    whois
    nmap
    subfinder
    assetfinder
    photon
    amass
    httprobe
    theHarvester
    h8mail
    dirbuster
    gowitness

## Installation

Clone this repository:

        $ git clone https://github.com/singhx-hub/Auto-Recon-Script.git
        $ cd Auto-Recon-Script

 Make the script executable:

        $ chmod +x recon.sh

Install the required dependencies mentioned in the Prerequisites section.

## Directory Structure

The script creates the following directory structure to organize the results:

- <target_domain>/
  - whois_info/
    - whois.txt
  - subdomains/
    - subdomains.txt
    - alive.txt
  - screenshots/
  - nmap_result/
    - nmap.txt
  - directory_enum/
    - dirb.txt
  - harvester/
    - data.txt
    - extracted_emails.txt
  - dirbuster/

## Results

The script generates the following results:

    WHOIS information: The WHOIS lookup result is saved in the whois_info/whois.txt file.
    
    NMAP scan: The NMAP scan result is saved in the nmap_result/nmap.txt file.
    
    Subdomain enumeration: The script uses multiple tools (subfinder, assetfinder, photon, amass) and saves the results in subdomains/subdomains.txt.
    
    Host availability: The script checks for available hosts by probing the subdomains and saves the responsive URLs in subdomains/alive.txt.
    
    Information gathering: The script uses theHarvester to gather information related to the target domain and saves the output in harvester/data.txt.
    
    Email reconnaissance: The script extracts email addresses from the harvested data and saves them in harvester/extracted_emails.txt. It then uses h8mail to perform additional email reconnaissance and appends the result to harvester/data.txt.
    
    Directory enumeration: The script uses dirbuster to perform directory enumeration and saves the result in dirbuster/dirb.txt.
    
    Screenshots: The script takes screenshots of the live subdomains using gowitness and saves them in the screenshots/ directory.

## Note

   Make sure you have the necessary permissions to run the script and create directories/files.
   The script assumes that the required tools are already installed and available in the system's PATH.

### Disclaimer: Use this script responsibly and only on targets that you have permission to assess. Be mindful of legal and ethical considerations. The author takes no responsibility for any misuse or damage caused by this script.
