# GNU-Parallel-Vina: GNU Parallel Based Implementation of Autodock Vina

---

GNU-Parallel-Vina is an open-source parallelization of AutoDock Vina, which massively reduces the time of virtual screening by using compute clusters or network of computers. It is developed based on GNU Parallel and intended for both shared and distributed memory environments. The goal of GNU-Parallel-Vina is to reduce the overall time of screening ligand data set. AutoDock Vina is the primary docking program of GNU-Parallel-Vina.

In GNU-Parallel-Vina, protein-ligand docking is distributed across different CPU cores where each core performs docking of a single ligand against a target receptor. Distribution of the ligand set allows docking multiple ligands concurrently on multiple cores.

GNU-Parallel-Vina reduces the overall time of doing virtual screening dramatically compared to the traditional virtual screening approach by using state-of-the-art parallel processing. It also reduces the magnitude and complexity of the screening problem and focuses on drug discovery and optimization efforts on the most promising leads.

## Requirements

GNU Parallel (can be installed via package managers like apt, yum, or brew).

## Usage

1. Convert your target receptor (i.e., protein) and all ligands into _pdbqt format_ format (using any traditional tools).
2. Put all the ligand files in the `Ligand` directory.
3. Put your configuration file (`conf.txt`) and target receptor in the `src` directory.
4. Adjust `JOBS_PER_NODE` according to your neends in the `runParallelVINA.bash` file.
5. When using a PBS scheduler, add the `--slf $PBS_NODEFILE` flag in `runParallelVINA.bash` file to access all allocated nodes, otherwise run as defualt.
6. To run the program type `./runParallelVINA.bash` in CLI.
7. All output files are placed in the `Output` directory.
   - `job.log` file contains detailed logs of the parallel job execution.
   - `ParallelVINA.log` file contains summary of the parallel procesing.
   - `SortedResult` file contains _binding affinity_ of all ligands in sorted order.
   - `<ligand_name>.pdbqt.pdbqt` & `<ligand_name>.pdbqt.txt` files contain the detailed result of individual ligand.

## Acknowledgement

This project is a fork of the original [MPI-Vina](https://github.com/mokarrom/mpi-vina/).
