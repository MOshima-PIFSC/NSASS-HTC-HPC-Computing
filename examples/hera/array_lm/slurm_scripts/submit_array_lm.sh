#!/bin/bash
# submit_array_lm.sh
# read directories from a file list

#SBATCH --account=project_name
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --job-name=array_lm
#SBATCH --output=/scratch1/NMFS/project_name/User.Name/logs/slurm-%x-%A_%a.out
#SBATCH --mail-user=User.Name@noaa.gov
#SBATCH --mail-type=all
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G                    
#SBATCH --time=0-00:01:00               
#SBATCH --array=0-9
#SBATCH -D .
pwd; hostname; date
echo $SLURM_ARRAY_TASK_ID

# create an array with all data directories
line_index=$(($SLURM_ARRAY_TASK_ID+1))
echo ${line_index}
dir_file=/scratch1/NMFS/project_name/User.Name/examples/hera/inputs/hera_job_directories.txt
echo ${dir_file}
rep_dir=$(sed -n ${line_index}p ${dir_file}) 
echo $rep_dir

# change to target directory
cd ${rep_dir}

# load R
module add R

# run script & calculate runtime
start=`date +%s`
R CMD BATCH --vanilla /scratch1/NMFS/project_name/User.Name/inputs/run_lm_hera_array.r
end=`date +%s`
runtime=$((end-start))
echo $runtime
echo Start $start >  runtime.txt
echo End $end >> runtime.txt
echo Runtime $runtime >> runtime.txt

# clean-up files that we don't want to save
rm data.csv *.Rout

# Create empty file so that it does not mess up when repacking tar
touch output.tar.gz
# pack everything in directory
tar -czf output.tar.gz --exclude='output.tar.gz' .
# delete what is left since everything is returned to the directory
find . -type f ! -name '*.tar.gz' -delete