# base image (stripped down ubuntu for Docker)
FROM continuumio/miniconda3

# metadata
LABEL base.image="miniconda3"
LABEL version="2"

# get some system essentials
RUN apt-get update && apt-get install -y wget && conda init bash
RUN apt install build-essential -y 
RUN apt install software-properties-common -y

#viral-mutation uses 3.7
RUN conda install python=3.7

#pip version of louvain not working for some reason
RUN conda install -c conda-forge louvain=0.6.1
RUN conda install -c anaconda cudatoolkit
RUN conda install -c anaconda cudnn 
RUN conda install -c nvidia libcusolver
#give tensorflow libcusolver.so.10
RUN ln /opt/conda/lib/libcusolver.so.11 /opt/conda/lib/libcusolver.so.10 

COPY ./ ./
WORKDIR .

# install all other dependencies
RUN pip install -r requirements.txt 
# ENTRYPOINT ["conda", "run", "-n", "rgi"]