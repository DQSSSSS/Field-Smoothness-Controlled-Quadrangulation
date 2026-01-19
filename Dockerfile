FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    libstdc++6 \
    libc6 \
    libgcc-s1 \
    bash \
    libsuitesparse-dev \
    wget \
    cmake \
    make \
    build-essential \
    g++ \
    gcc \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y \
    libgoogle-glog-dev

RUN apt-get update && \
    apt-get install -y \
    libunwind-14-dev

RUN apt-get update && \
    apt-get install -y \
    libatlas-base-dev

WORKDIR /app

COPY . /app/

RUN chmod +x /app/bin/*

# install gurobi, version 11.0.3, link: https://www.gurobi.com/downloads/gurobi-software/
# unzip it in project root directory, its name is gurobi1103
# you should have a gurobi.lic file in project root directory, apply it in your gurobi license manager: https://license.gurobi.com/manager/licenses

RUN mkdir -p /home/anderliang/gurobi1103 && \
    cp -r /app/gurobi1103/linux64 /home/anderliang/gurobi1103/

ENV LD_LIBRARY_PATH=/app/bin:/app/gurobi1103/linux64/lib:/home/anderliang/gurobi1103/linux64/lib:/app/glog/build:${LD_LIBRARY_PATH:-}

ENV PATH=/app/gurobi1103/linux64/bin:${PATH:-}
ENV GUROBI_HOME=/app/gurobi1103
ENV GRB_LICENSE_FILE=/app/gurobi.lic