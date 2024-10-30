#!/bin/bash
# read directories from a file list

pwd; hostname; date

cd $1
export SLURM_ARRAY_TASK_ID=$2

echo $SLURM_ARRAY_TASK_ID

# define current directory
cwd=$(pwd)

# define paths for singularity container
singularity_container=${cwd}/linux-r4ss-v4.sif

# define variables and paths here to avoid hard coding insider the wrapper script
job_wrapper_script=${cwd}/slurm_scripts/wrapper-r.sh
dir_file=${cwd}/inputs/hera_job_directories.txt
r_script=${cwd}/slurm_scripts/ss3-example-calcs.r
input_data_path=${cwd}/inputs/models/
r_script_name=ss3-example-calcs.r

# change permissions on scripts to allow it to run
chmod 777 $job_wrapper_script
dos2unix $job_wrapper_script
chmod 777 $r_script
dos2unix $r_script

# run bash wrapper script within singularity environment
singularity exec $singularity_container $job_wrapper_script $SLURM_ARRAY_TASK_ID $dir_file $r_script $input_data_path $r_script_name >& logs/out-parallel.$SLURM_ARRAY_TASK_ID

