#!/usr/bin/env bash

mkdir -p Output
mkdir -p ProcessedLigand

run_vina() {
	local file=$1
	local tmp=${file%.pdbqt}
	local name="${tmp##*/}"
	./Vina/vina --config ./Vina/conf.txt \
		--ligand "$file" \
		--out "./Output/${name}.pdbqt.pdbqt" \
		--log "./Output/${name}.txt"
}

export -f run_vina

# Run the application.
echo "Parallel-Vina is running..."
find ./Ligand -type f -name '*.pdbqt' | parallel --joblog job.log --resume run_vina >Output/ParallelVina.log

# use the following when using PBS to access all allocated nodes and processes
# NP=$(cat ${PBS_NODEFILE} | wc -l)
# find ./Ligand -type f -name '*.pdbqt' | parallel -j "$NP" --joblog Output/job.log --resume run_vina >Output/ParallelVina.log

echo "Processing has finished."
echo "See the ParallelVina.log file."

echo "Analyzing the results..."
mv job.log ./Output
cd Output
awk '/^[-+]+$/{getline; print FILENAME, $2}' *.txt | sed 's/\.\/Output\///' | sed 's/\.txt//' >result
echo "See the 'result' file in the 'Output' directory."

echo "Sorting the results..."
sort -k 2,2n result >SortedResult
echo "See the 'SortedResult' file in the 'Output' directory."

echo "Processing the docking outputs..."
while read -r line; do
	ligand=$(echo "$line" | awk '{print $1}')
	cp "./${ligand}.pdbqt.pdbqt" "../ProcessedLigand/${ligand}.pdbqt"
done <SortedResult

echo "See the 'ProcessedLigand' directory."
