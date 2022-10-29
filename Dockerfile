FROM rocker/r-ver:4.2.1
# 
# ENV S6_VERSION=v2.1.0.2
ENV ARCH=aarch64
ENV RENV_VERSION=0.16.0

ARG CONDA_ENV=r-renv-devcon
ENV CONDA_ENV=$CONDA_ENV

ARG PYTHON_VER=3.8
ENV PYTHON_VER=$PYTHON_VER

RUN mkdir project

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    jq \
    libxml2-dev \
    g++-11 \
    libz-dev \
    freetype2-demos \
    libpng-dev \
    libtiff-dev \
    libjpeg-dev \
    make \
    fontconfig \
    libfribidi-dev \
    libharfbuzz-dev \
    libfontconfig1-dev \
    locales \
    git \
    vim \
    libgit2-dev \
    && rm -rf /var/lib/apt/lists/*



RUN apt update && apt-get install -y --no-install-recommends \
    software-properties-common \
    && add-apt-repository -y ppa:deadsnakes/ppa \
    && apt update 

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-${ARCH}.sh -O ~/miniconda.sh \
    && /bin/bash ~/miniconda.sh -b -p /opt/conda \
    && export PATH=/opt/conda/bin:$PATH \
    && conda init bash \
    && conda install conda-build

RUN . /root/.bashrc \
    && conda create -y --name $CONDA_ENV python=$PYTHON_VER 
# 
RUN echo "conda activate $CONDA_ENV" >> ~/.bashrc

# install RENV
RUN R --vanilla -s -e "install.packages('remotes', repos = c(CRAN = 'https://cloud.r-project.org'));remotes::install_github('rstudio/renv@${RENV_VERSION}')"

# 
# 
# 
# COPY requirements.txt ./
# 