#!/usr/bin/env bash

mkdir -p Output
mkdir -p ProcessedLigand

# Working directory
WDIR=$(pwd)

# Number of jobs per node
JOBS_PER_NODE=4 # Adjust this according to your needs

# Source the run_vina function
source $WDIR/processLigands.bash

# Run the application using GNU Parallel
echo "Parallel-Vina is running..."
find ./Ligand -type f -name '*.pdbqt' >input.lst

# Run the application.
#	--slf "$PBS_NODEFILE" \
echo "Parallel-Vina is running..."
parallel --progress \
	--joblog Output/job.log \
	--resume \
	--jobs $JOBS_PER_NODE \
	--workdir $WDIR \
	"source $WDIR/processLigands.bash; run_vina {}" :::: input.lst >Output/ParallelVina.log

echo "Processing has finished."
echo "See the ParallelVina.log file."

echo "Analyzing the results..."
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
