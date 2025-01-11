#!/usr/bin/bash
# runIPS.sh

mkdir -p results
mkdir -p results/logs

interproscan.sh \
-i $1 \
-o $2 \
-f tsv \
-cpu 2 \
-dp \
--goterms \
--pathways \
-appl Pfam,Superfamily \
--iprlookup 
