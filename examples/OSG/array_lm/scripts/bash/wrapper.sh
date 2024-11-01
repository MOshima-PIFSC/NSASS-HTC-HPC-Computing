
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
mv data.csv working/
mv run_lm_osg_array.r working/
cd working/

# get names of input files
orig_files=$(ls)

# rename variables passed into the script
target_dir=$1

# begin calcs
start=`date +%s`
# run R script
Rscript run_lm_osg_array.r $target_dir 

# end of calcs book-keeping
end=`date +%s`
runtime=$((end-start))
echo $runtime
echo Start $start >  runtime.txt
echo End $end >> runtime.txt
echo Runtime $runtime >> runtime.txt

# Clean-up
rm data.csv

# Create empty file so that it does not mess up when repacking tar
touch End.tar.gz
# Tar outputs together
tar -czf End.tar.gz par.csv runtime.txt 
cd ..
mv working/End.tar.gz .