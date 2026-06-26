# Translated from linux-r4ss-v4.def using Gemini (June 26 2026). Trying to run the tutorials in Google Cloud Workstation using Batch. 
# 1. Base Image (Bootstrap: docker / From: ubuntu:20.04)
FROM rocker/r-ver:4.4.0

# 2. Labels (%labels)
LABEL maintainer="nicholas.ducharme-barth@noaa.gov"
LABEL version="v0.0.4"
LABEL description="Linux (Ubuntu 20.04) container containing Stock Synthesis (version 3.30.22.1), R (version 4.4.0) and the R packages r4ss, ss3diags, data.table, magrittr, and mvtnorm."

# 3. Environment Variables (%environment)
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ENV PATH="/ss_exe:${PATH}"

# 4. Setup and System Dependencies (%post)
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && apt-get update -y && apt-get install -y --no-install-recommends \
        ca-certificates \
        gfortran \
        libbz2-dev \
        liblzma-dev \
        libpcre2-dev \
        libcairo2 \
        tzdata \
        curl \
        dos2unix \
        build-essential \
        cmake \
        g++ \
        libssl-dev \
        libssh2-1-dev \
        libcurl4-openssl-dev \
        libfontconfig1-dev \
        libxml2-dev \
        libgit2-dev \
        wget \
        tar \
        coreutils \
        gzip \
        findutils \
        sed \
        gdebi-core \
        locales \
        nano \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

# 5. Install R version 4.4.0
ENV R_VERSION=4.4.0
RUN curl -O https://cdn.rstudio.com/r/ubuntu-2004/pkgs/r-${R_VERSION}_1_amd64.deb \
    && gdebi -n r-${R_VERSION}_1_amd64.deb \
    && rm r-${R_VERSION}_1_amd64.deb \
    && ln -s /opt/R/${R_VERSION}/bin/R /usr/local/bin/R \
    && ln -s /opt/R/${R_VERSION}/bin/Rscript /usr/local/bin/Rscript

# 6. Install R Packages
RUN R -e "install.packages('remotes', dependencies=TRUE, repos='http://cran.rstudio.com/')" \
    && R -e "install.packages('data.table', dependencies=TRUE, repos='http://cran.rstudio.com/')" \
    && R -e "install.packages('magrittr', dependencies=TRUE, repos='http://cran.rstudio.com/')" \
    && R -e "install.packages('mvtnorm', dependencies=TRUE, repos='http://cran.rstudio.com/')" \
    && R -e "remotes::install_github('r4ss/r4ss')" \
    && R -e "remotes::install_github('PIFSCstockassessments/ss3diags')"

# 7. Record Build Date & Install Stock Synthesis Executable
RUN export build_date=$(date) \
    && mkdir -p /ss_exe \
    && curl -L -o /ss_exe/ss3_linux https://github.com/nmfs-ost/ss3-source-code/releases/download/v3.30.22.1/ss3_linux \
    && chmod 755 /ss_exe/ss3_linux

# Optional: Set default command (e.g., launching an interactive R session)
CMD ["R"]
