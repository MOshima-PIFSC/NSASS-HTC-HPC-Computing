
#!/bin/bash

# print where we are
pwd
ls -l
echo $PATH
echo $@

# make directory to work in and set-up
mkdir -p working/
mkdir -p working/rtmp
export TMPDIR=$_CONDOR_SCRATCH_DIR/rtmp
mv Start.tar.gz working/
mv r_and_ss.r working/
cd working/

# unpack everything from initial tar file
tar -xzf Start.tar.gz
orig_files=$(ls)

# rename variables passed into the script
target_dir=$1

# define variables for R script
random_seed=123
n_replicates=500

# begin calcs
start=`date +%s`
Rscript r_and_ss.r $target_dir $random_seed $n_replicates

# end of calcs book-keeping
end=`date +%s`
runtime=$((end-start))
echo $runtime
echo Start $start >  runtime.txt
echo End $end >> runtime.txt
echo Runtime $runtime >> runtime.txt

# Clean-up
rm Start.tar.gz

# Create empty file so that it does not mess up when repacking tar
touch End.tar.gz
tar -czf End.tar.gz ss_dMVLN.RData ss_report.RData runtime.txt 
cd ..
mv working/End.tar.gz .