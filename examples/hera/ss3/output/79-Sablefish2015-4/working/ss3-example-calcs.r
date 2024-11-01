
# where is the job executing
    print(getwd())

# load packages
    library(r4ss)

# get args from bash environment
    args = commandArgs(trailingOnly = TRUE)
    print(args)

# get scenario
    scenario = tail(strsplit(args[1],"/")[[1]],n=1)
    model = strsplit(scenario,"-")[[1]][2]
    peel = as.numeric(strsplit(scenario,"-")[[1]][3])

# copy model files
    model_files = list.files(paste0(args[2],model,"/"),full.names=TRUE)
    file.copy(from=model_files,to=getwd())

# modify starter
    tmp_starter = SS_readstarter()
    tmp_starter$retro_yr = -peel

# write files
    SS_writestarter(tmp_starter, overwrite = TRUE)

# run stock synthesis
    run(exe="ss3_linux")

# extract model output
    ss_report = try(SS_output(dir=getwd()),silent=TRUE) 

# save output
    save(ss_report,file="ss_report.RData")
