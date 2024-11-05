
#!/bin/bash
# prep files for condor job execution
dos2unix ./scripts/osg-wrapper-r.sh
dos2unix ./scripts/osg_job_directories.txt
dos2unix ./scripts/osg-ss3-example-calcs.r

# make directory structure
xargs -d '\n' mkdir -p -- < ./scripts/osg_job_directories.txt

# change permissions on wrapper script
chmod 777 ./scripts/osg-wrapper-r.sh
