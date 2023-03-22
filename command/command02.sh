# command02.sh
# 1. Execute SPAdes 3 times with these k values; 23, 79, and 125
# Save the result to each output directory.
#   - k=23: ./sars_cov_2_k23
#   - k=79: ./sars_cov_2_k79
#   - k=125: ./sars_cov_2_k125
# The output directory can be set by adding "-o" option.
# Run SPAdes with "--only-assember" option to speed up.
DP="~/exercise03/data/"

F1="SRR13668359_1.fastq.gz"
F2="SRR13668359_2.fastq.gz"
ksize=(23 79 125)

for k in "${ksize[@]}"
do
    spades.py -o ./sars_cov_2_k$k -k $k --only-assembler --pe1-1 $DP$F1 --pe1-2 $DP$F2
done

# 2. Copy scaffolds.fasta files from the output directories of previous step to result directory and name
#    them as sars_cov_2_k*.fasta. (Result file: sars_cov_2_k*.fasta)
#    You can copy files with "cp" command. The usage of "cp" command is quite similar to "mv" command.
for k in "${ksize[@]}"
do
    cp ./sars_cov_2_k$k/scaffolds.fasta ~/exercise03/result/sars_cov_2_k$k.fasta
done
