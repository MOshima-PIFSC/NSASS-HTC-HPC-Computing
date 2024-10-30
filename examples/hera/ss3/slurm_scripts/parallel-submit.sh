#!/bin/bash

# prep files for slurm job execution
mkdir ./logs
dos2unix ./inputs/hera_job_directories.txt
dos2unix ./slurm_scripts/parallel-job-exec.sh
chmod 777 ./slurm_scripts/parallel-job-exec.sh

# make directory structure
# recursively (mkdir -p) makes a new directory for each line in hera_job_directories.txt
xargs -d '\n' mkdir -p -- < ./inputs/hera_job_directories.txt

# Slurm job submission variables
# -A project name
# -t time requested (minutes)
# -q queue type: batch (billed allocation) or windfall
# -N nodes requested (leave at 1 since requesting additional nodes with each line)
# -j number of jobs to run in parallel per node (restricted by number of total CPUs and available RAM)
# seq job ids to run on each node (this can be greater than -j but only -j will be run at a time so the more job ids assigned to the node the longer they will wait to be executed)
sbatch -A project_name -t 60 -q batch -N 1 --wrap 'set -x; parallel -j 30 -S `scontrol show hostnames "$SLURM_JOB_NODELIST"|paste -sd,` `pwd`/slurm_scripts/parallel-job-exec.sh `pwd` ::: `seq 0 29`; report-mem'
sbatch -A project_name -t 60 -q batch -N 1 --wrap 'set -x; parallel -j 30 -S `scontrol show hostnames "$SLURM_JOB_NODELIST"|paste -sd,` `pwd`/slurm_scripts/parallel-job-exec.sh `pwd` ::: `seq 30 59`; report-mem'
sbatch -A project_name -t 60 -q batch -N 1 --wrap 'set -x; parallel -j 30 -S `scontrol show hostnames "$SLURM_JOB_NODELIST"|paste -sd,` `pwd`/slurm_scripts/parallel-job-exec.sh `pwd` ::: `seq 60 89`; report-mem'
