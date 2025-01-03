#!/bin/bash

# Detect the operating system
OS=$(uname -s | tr '[:upper:]' '[:lower:]')

# Detect the architecture
ARCH=$(uname -m)

# Determine Bazelisk URL based on OS and architecture
if [[ "$OS" == "darwin" ]]; then
    if [[ "$ARCH" == "arm64" ]]; then
        BAZELISK_URL="https://github.com/bazelbuild/bazelisk/releases/download/v1.25.0/bazelisk-darwin-arm64"
    else
        BAZELISK_URL="https://github.com/bazelbuild/bazelisk/releases/download/v1.25.0/bazelisk-darwin-amd64"
    fi
elif [[ "$OS" == "linux" ]]; then
    if [[ "$ARCH" == "arm64" ]]; then
        BAZELISK_URL="https://github.com/bazelbuild/bazelisk/releases/download/v1.25.0/bazelisk-linux-arm64"
    else
        BAZELISK_URL="https://github.com/bazelbuild/bazelisk/releases/download/v1.25.0/bazelisk-linux-amd64"
    fi
else
    echo "Unsupported OS: $OS"
    exit 1
fi

# Remove any old Bazelisk installation
if [[ -d .bazelisk ]]; then
    echo "Removing old Bazelisk installation..."
    rm -rf .bazelisk
fi

# Install Bazelisk locally in the repository
echo "Installing Bazelisk for $OS ($ARCH)..."
mkdir -p .bazelisk
curl -L $BAZELISK_URL -o .bazelisk/bazel
chmod +x .bazelisk/bazel

# Add a note for users
echo "Bazelisk installed at .bazelisk/bazel. Add it to your PATH or use ./bazelisk/bazel."
