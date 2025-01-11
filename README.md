**Project Title - InterProScan Functional Annonation**
This repository contains a set of scripts to run InterProScan on a set of peptide sequences, extract 
relevant information from the results, and summarize the findings in a TSV format. These scripts can be useful for analyzing functional annotations of genes and proteins.

**Dependencies**
The scripts are written in Bash and require the following dependencies:

InterProScan v.5 
HMMER v.3
GNU Parallel

**Usage**
The scripts are designed to be run sequentially, with output from one script serving as input to the next.
The four scripts are:

**prepareForIPS.sh:**
This script prepares the data for the InterProScan pipeline by extracting a specific number of lines 
(specified as an argument) from the input FASTA file, removing any asterisks), and saving the output as a new file.

**runIPS.sh:**
This script runs the InterProScan program on the cleaned data produced by prepareForIPS.sh. 
The program is executed with specific options and parameters, including input and output file paths, CPU usage, and the InterProScan applications and databases to use. The script redirects standard output and error messages to separate log files in the results/logs folder

**summarizeIPStsv.sh:**
This script is used to submit a job to a computing cluster (in this case, a Slurm job scheduler). 
It specifies various parameters for the job, including the job name, the requested resources 
(e.g., nodes, CPUs, memory), the output file name, and the email address to notify when the job completes. 
The script also defines several variables used in the pipeline, including file paths, folder names, 
and the number of lines to process. The script loads the necessary Anaconda environment and
executes the following pipeline steps: 
prepare the data for InterProScan, run InterProScan on the cleaned data, and summarize the output. 
Each step is implemented by invoking the corresponding shell script in the scripts folder. 
The script logs messages to the standard output and error streams, which are redirected to 
separate log files in the results/logs folder.

**sbatch_IPS.sh:** 
This script takes two arguments: the path to the InterProScan output file (proteins.tsv) 
and the path to the output folder. It generates several summary 
files from the output file: one for domain frequencies (domains.txt), one for GO term frequencies (go_ids.txt),
and one for pathway frequencies (pathways.txt). The script extracts the relevant fields from the input file
using the cut command, and then applies various Unix commands (sort, uniq, perl) to count the occurrences
of each domain, GO term, or pathway. 
The results are sorted in descending order of frequency and written to separate text files in the output folder.
If the output folder does not exist, the script creates it using the mkdir command.

**Procedure:**

1.Create the 4 scripts mentioned above.

2.Ensure that the required dependencies are installed.

3.Prepare the FASTA file of peptide sequences.

4.Modify the scripts as necessary to match your system/server and data path.

5.Run the scripts in sequence, using the output of each script as input to the next.
Example:

We can use the "grep" command to count the number of lines in a file that contain a particular character or string. In this case, we are using "grep" to count the number of lines in a file that start with the ">" character. We then use the "wc" command to count the total number of such lines in the file.

To determine the number of lines to process for a given percentage of the file, we use the average number of lines per peptide in the file. This allows us to estimate how many lines to take as a representative sample of the file.

For example, if we want to process the first 5% of the peptides in the file, we can estimate the number of lines to take by multiplying the total number of peptides by 0.05, and then multiplying that result by the average number of lines per peptide. We can then use the "head" command to extract that number of lines from the beginning of the file, and use "grep" to count the number of lines that start with the ">" character in that subset of lines.

This approach allows us to efficiently process a representative sample of the file without having to process the entire file, which can be time-consuming and resource-intensive.

In order to test the pipelines before running the sbatch scripts,the scripts are run individually using the following commands:
 
*bash prepareForIPS.sh 2801 data/Trinity.fasta.transdecoder.pep data/top05_Trinity.fasta.transdecoder.pep*

*bash runIPS.sh data/top05_Trinity.fasta.transdecoder.pep results/proteins.tsv*

*bash summarizeIPStsv.sh proteins.tsv results/*

*sbatch sbatch_IPS.sh*

**Methods**
InterProScan is a tool for functional analysis of protein sequences.
It integrates multiple protein signature recognition methods to provide a comprehensive analysis of protein sequences, 
including prediction of protein domains, motifs, and functional sites.

The HMMER algorithm is used in InterProScan to identify protein domains in sequences. 
HMMER is a software package for profile hidden Markov model (HMM) analysis, which can be used to identify 
homologous sequences in protein and DNA databases.

**Acknowledgment**
Developed at Northeastern University for BINF6308 coursework.
Author: Renuka Athinarayanan

