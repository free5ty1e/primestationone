#!/bin/bash
set -e

echo "Installing system dependencies..."
sudo apt-get update
# sudo apt-get install -y patchelf

echo "Installing Python dependencies..."
# requirements.txt 
# pip install -r requirements.txt || echo "WARN: requirements.txt had build failures (continuing; crepe/madmom installed below if possible)"

# echo "Installing .NET SDK for ForgeTool build..."
# curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --channel 8.0 --install-dir /tmp/dotnet
# export PATH=/tmp/dotnet:$PATH
