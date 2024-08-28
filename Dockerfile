# Pin base image
# Base image https://hub.docker.com/_/r-base
# Latest version of R compatible with Bioconductor 3.19 is 4.4.1
FROM r-base:4.4.1
LABEL description="Base docker image with R"

# Install procps (so that Nextflow can poll CPU usage)
RUN apt-get update && \
    apt-get install -y procps && \
    apt-get clean -y

# Install requirements for devtools
# RUN apt-get install build-essential libcurl4-gnutls-dev libxml2-dev libssl-dev -y

#RUN Rscript \
RUN Rscript -e 'install.packages("remotes")'
RUN Rscript -e 'remotes::install_github("JCVenterInstitute/FRmatch")'
