FROM ubuntu

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && apt -y upgrade

RUN apt install -y \
    net-tools iputils-ping \
    build-essential cmake git \
    curl wget \
    emacs \
    openmpi-bin openmpi-common \
    netcdf-bin libnetcdf-dev libnetcdff-dev

RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm -rf ~/miniconda.sh && \
    ln -sf /opt/conda/etc/profile.d/conda.s /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN /opt/conda/bin/conda install -yc conda-forge \
    jupyter netcdf4 xarray matplotlib \
    dask cartopy jupyterlab

RUN /opt/conda/bin/conda install -yc conda-forge \
    numpy scipy basemap basemap-data-hires cftime \
    lpsolve55 pip

WORKDIR /opt/

RUN /usr/bin/git clone https://github.com/ESMG/pyroms.git

RUN /opt/conda/bin/pip install -e pyroms/pyroms && \
    /opt/conda/bin/pip install -e pyroms/pyroms_toolbox && \
    /opt/conda/bin/pip install -e pyroms/bathy_smoother

CMD ["bash"]