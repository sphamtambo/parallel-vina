# GNU-Parallel-Vina: GNU Parallel Based Implementation of Autodock Vina

---

GNU-Parallel-Vina is an open-source tool that parallelizes AutoDock Vina, aimed at drastically reducing virtual screening times by utilizing compute clusters or networks of computers. Developed using GNU Parallel, it supports both shared and distributed memory environments. The primary goal is to accelerate the screening of ligand datasets, distributing protein-ligand docking tasks across multiple CPU cores and NODES for simultaneous processing.

## Requirements

GNU Parallel (can be installed via package managers like apt, yum, or brew).

## Usage

1. **Prepare Files**:

   - Convert your target receptor (i.e., protein) and all ligands into PDBQT format using traditional tools.
   - Place all ligand files in the `Ligand` directory.
   - Place your configuration file (`conf.txt`) in the `Vina` directory.
   - Place your target receptor in the `src` directory.

2. **Adjust Job Settings**:

   - Edit `runParallelVINA.bash` and adjust `JOBS_PER_NODE` according to your needs.
   - When using a PBS scheduler, edit the `runParallelVINA.bash` and add the `--slf $PBS_NODEFILE` flag to access all allocated nodes.

3. **Running the Program**:

   - Run the script by either typing `./runParallelVINA.bash` in the command line or submitting the `submit_vina_job.pbs` file via qsub.

4. **Output Files**:

   - All output files will be placed in the `Output` directory:
     - `job.log` contains detailed logs of the parallel job execution.
     - `ParallelVINA.log` contains a summary of the parallel processing.
     - `SortedResult` contains binding affinities of all ligands in sorted order.
     - `<ligand_name>.pdbqt.pdbqt` and `<ligand_name>.pdbqt.txt` files contain detailed results of individual ligands.

5. **Processed Ligands**:

   - The `ProcessedLigand` directory contains:
     - `<ligand_name>.pdbqt` files of individual ligands.

6. **Failed Jobs**:

   - Edit `runParallelVINA.bash`and use the `--resume-failed` flag to re-run failed jobs.

## Acknowledgement

This project is a fork of the original [MPI-Vina](https://github.com/mokarrom/mpi-vina/).
