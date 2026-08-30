FROM mcr.microsoft.com/devcontainers/python:3.11

# Install system dependencies required for audio processing and ML compiling
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    ffmpeg \
    libsndfile1 \
    pkg-config \
    # libopus-dev \
    build-essential \
    git \
    wget \
    unzip \
    curl \
    # mono-devel \
    # patchelf \
    # wine64 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


RUN pip install --upgrade pip
