#!/usr/bin/env bash
# summarizeIPStsv.sh
# Usage: bash summarizeIPStsv.sh results/proteins.tsv results/

mkdir -p $2  # make the output folder if it doesn't exist

# Summarize domains
cut -f12,13 $1| sort | uniq -c | sort -k1 -rn >$2/domains.txt

# Summarize GO Terms
cut -f14 $1 | \
perl -ne '@list=split/\|/, $_; foreach my $i (@list){ print "$i\n"; }' | \
sort | uniq -c | sort -k1 -rn >$2/go_ids.txt

# Summarize paths
cut -f15 $1 | \
perl -ne '@list=split/\|/, $_; foreach my $i (@list){ print "$i\n"; }' | \
sort | uniq -c | sort -k1 -rn >$2/path_ids.txt
