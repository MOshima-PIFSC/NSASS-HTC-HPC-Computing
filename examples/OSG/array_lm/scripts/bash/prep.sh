
#!/bin/bash
# prep files for condor job execution
dos2unix ${1}./wrapper.sh
dos2unix ${1}./../../inputs/osg_job_directories.txt
dos2unix ${1}./../../inputs/run_lm_osg_array.r

# make directory structure
xargs -d '\n' mkdir -p -- < ${1}./../../inputs/osg_job_directories.txt

# change permissions on wrapper script
chmod 777 ${1}./wrapper.sh
