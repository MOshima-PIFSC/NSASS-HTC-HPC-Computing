#!/bin/bash
# wrapper_r_and_ss.sh
echo "Running on host `hostname`"

# rename variables passed into the script
slurm_array_task_id=$1
dir_file=$2

# create an array with all data directories
line_index=$(($slurm_array_task_id+1))
echo ${line_index}
echo $dir_file
rep_dir=$(sed -n ${line_index}p $dir_file) 
echo $rep_dir

# change to target directory
cd ${rep_dir}

# make working directory
mkdir -p working/
cd working/

# copy files to working/
cp $3 .

# define variables for R script
input_data_path=$4

# begin calcs
start=`date +%s`
Rscript $5 $rep_dir $input_data_path 

# end of calcs book-keeping
end=`date +%s`
runtime=$((end-start))
echo $runtime
echo Start $start >  runtime.txt
echo End $end >> runtime.txt
echo Runtime $runtime >> runtime.txt

# Create empty file so that it does not mess up when repacking tar
touch End.tar.gz
# only pack up certain items
tar -czf End.tar.gz ss_report.RData runtime.txt 
# move tar out of working/
cd ..
mv working/End.tar.gz .
# delete working/
rm -r working/
