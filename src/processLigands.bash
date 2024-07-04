#!/usr/bin/env bash

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
