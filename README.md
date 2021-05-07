## Simple whois scanner

## About 

This is a simple and dirty bash script to do a whois lookup 
from a list of ip addresses where each host is on a single line

It calls `whois` to loop over a list of hosts provided with `--list` or `-l` option 
prints out the provided host address after that and line number from the list after each `whois` query.

## Usage

```
    ./whois_scan.sh -l[--list] [OPTION]

OPTIONS:
    -l  --list              PATH to lisf of hosts
    -o  --output            Name and/or path for the output file
    -h  --help              Display usage
```

You need to have a list of hosts set up, just like with `nmap`, one host per each line.

#### Example list of hosts:

```
1.1.1.1
8.8.8.8
google.com
amazon.com
```

#### Note: Using colours for better readability. 
```bash
RED='\033[1;91m' # WARNINGS
YELLOW='\033[1;93m' # HIGHLIGHTS
WHITE='\033[1;97m' # LARGER FONT
LBLUE='\033[1;96m' # HIGHLIGHTS / NUMBERS ...
LGREEN='\033[1;92m' # SUCCESS
NOCOLOR='\033[0m' # DEFAULT FONT
```

