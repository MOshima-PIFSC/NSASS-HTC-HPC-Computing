# Translated from linux-r4ss-v4.def using Gemini (June 26 2026). Trying to run the tutorials in Google Cloud Workstation using Batch. 
# 1. Base Image 
FROM rocker/r-ver:latest

# Install basic Linux networking, system utilities, and Python 3
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    python3 \   
    && rm -rf /var/lib/apt/lists/*

# Install the official Google Cloud CLI inside the container
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
    apt-get update && apt-get install -y google-cloud-cli && \
    rm -rf /var/lib/apt/lists/*

# Set up your app workspace
RUN mkdir /app
# Copy R script directly into the Docker container
COPY run_lm_gc_array.r /app/run_lm_gc_array.r

WORKDIR /app

CMD ["R"]