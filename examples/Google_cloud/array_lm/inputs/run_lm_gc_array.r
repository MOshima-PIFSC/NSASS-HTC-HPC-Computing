# 1. Read the task index provided by Google Batch
task_index <- Sys.getenv("BATCH_TASK_INDEX")
if (task_index == "") {
  task_index <- "0"
}

# 2. Pad it to 2 digits (e.g., "00", "01")
padded_index  <- sprintf("%02d", as.integer(task_index))

# 3. Use the VM's mount path (/mnt/share) instead of "gs://" urls
# This points directly to your bucket's structure via the volume mount
input_file  <- paste0("/mnt/share/inputs/rep_", padded_index, "/data.csv")
output_file <- paste0("/mnt/share/inputs/rep_", padded_index, "/par.csv")

# 4. Read the data directly from the mounted bucket
tmp <- read.csv(input_file)

# 5. Run your linear regression
fit <- lm(y ~ x, data = tmp)
out <- data.frame(par = unname(fit$coefficients))

# 6. Write the file directly back to the mounted bucket!
# No gcs_upload() or extra packages required.
write.csv(out, file = output_file, row.names = FALSE)

message("Successfully saved results to: ", output_file)