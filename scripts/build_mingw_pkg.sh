#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status
set -o pipefail  # Prevent errors in a pipeline from being masked

echo "Navigating to the package generator directory..."
cd /home/docker/scopy/tools/packagegenerator

echo "Installing Python dependencies..."
pip3 install -r requirements.txt

echo "Testing the package generator script..."
python3 ./package_generator.py -h

echo "Creating package directory for the repository..."
mkdir -p /home/docker/scopy/packages/${GITHUB_REPOSITORY}

echo "Copying package files to the repository directory..."
cp -r /home/docker/scopy/package/* /home/docker/scopy/packages/${GITHUB_REPOSITORY}/

echo "Navigating to the Scopy root directory..."
cd /home/docker/scopy

echo "Creating and navigating to the build directory..."
mkdir -p build && cd build

echo "Running CMake with MinGW Makefiles..."
cmake .. -G "MinGW Makefiles"

echo "Building the project with MinGW Make..."
mingw32-make -j$(nproc)

echo "Copying the package directory to the artifact location..."
cp -r /home/docker/scopy/packages/${GITHUB_REPOSITORY} /home/docker/artifact_x86_64 || echo "Package directory not found!"

echo "Returning to the package generator directory..."
cd /home/docker/scopy/tools/packagegenerator

echo "Running the package generator script to create the final artifact..."
python3 ./package_generator.py -a --src=/home/docker/artifact_x86_64/${GITHUB_REPOSITORY} --dest=/home/docker/artifact_x86_64

echo "Build and packaging process completed successfully!"
