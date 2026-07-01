# R script for running an array of linear regressions using Batch Jobs on Google Cloud Workstations
# Note this code does not use googleCloudStorageR package for transferring files due to 
# authentication issues when running jobs in batch. Instead the code uses the native `gcloud` capabilities.

tryCatch({  
  
  task_index <- Sys.getenv("BATCH_TASK_INDEX")
  if (task_index == "") { task_index <- "0" }

  bucket_name <- "nsass-gc-bucket"

  # Local temporary paths inside the container
  local_input  <- "/tmp/data.csv"
  local_output <- "/tmp/par.csv"

  # 1. DOWNLOAD data using native gcloud command line tool
  download_cmd <- paste0("gcloud storage cp gs://", bucket_name, "/inputs/rep_", task_index, "/data.csv ", local_input)
  system(download_cmd)

  # 2. READ data 
  tmp <- read.csv(local_input)

  # 3. FIT linear regression
  fit <- lm(y ~ x, data = tmp)
  out <- data.frame(par = unname(fit$coefficients)) 
  # Save file locally first so gcloud can transfer the .csv file
  write.csv(out, local_output, row.names = FALSE) 

  # 4. UPLOAD results back to the bucket using gcloud
  upload_cmd <- paste0("gcloud storage cp ", local_output, " gs://", bucket_name, "/inputs/rep_", task_index, "/par.csv")
  system(upload_cmd)

}, error = function(e) {
  cat(paste("ERROR MESSAGE:", e$message, "\n"), file = stderr())
  quit(status = 1) # Tells Google Batch the task failed
})