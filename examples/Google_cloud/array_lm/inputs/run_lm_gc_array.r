# Read the task index provided by Google Batch
task_index <- Sys.getenv("BATCH_TASK_INDEX")

# Fallback for local testing if the variable isn't set
if (task_index == "") {
  task_index <- "0"
}

# Convert the dynamic string index to an integer, then pad it to 2 digits
numeric_index <- as.integer(task_index)
padded_index  <- sprintf("%02d", numeric_index)

# Construct the dynamic Cloud Storage paths using the index
input_folder  <- paste0("gs://nsass-gc-bucket/inputs/rep_", padded_index)
input_file    <- paste0(input_folder, "/data.csv")
output_file   <- paste0(input_folder, "/par.csv")
tmp=read.csv('data.csv')
fit=lm(y~x,data=tmp)
out = data.frame(par=unname(fit$coefficients))
# Step A: Write the file locally inside the container
write.csv(out,file='par.csv')
# Step B: Upload that local file to the unique GCS path we calculated
gcs_upload(
  file = "par.csv",
  bucket = "batch-project-test-bucket", # Swap with your actual bucket variable
  name = output_file
)
