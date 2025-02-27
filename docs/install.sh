#!/bin/bash

set -e

# Default version is 'latest'
VERSION=${VERSION:-latest}

# Detect OS and architecture
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

# Map architecture names
case ${ARCH} in
    x86_64)
        ARCH="amd64"
        ;;
    arm64|aarch64)
        ARCH="arm64"
        ;;
    *)
        echo "Unsupported architecture: ${ARCH}"
        exit 1
        ;;
esac

# Set install directory (default to /usr/local/bin or allow custom)
INSTALL_DIR=${INSTALL_DIR:-/usr/local/bin}

# Base URL for downloads
BASE_URL="https://raw.githubusercontent.com/inference-sh/cli-dist/main"

# Construct binary name and URL
BINARY_NAME="inferencesh-${OS}-${ARCH}"
if [ "${OS}" = "windows" ]; then
    BINARY_NAME="${BINARY_NAME}.exe"
fi

DOWNLOAD_URL="${BASE_URL}/${VERSION}/${BINARY_NAME}"

echo "Installing inference.sh CLI..."
echo "OS: ${OS}"
echo "Architecture: ${ARCH}"
echo "Version: ${VERSION}"
echo "Download URL: ${DOWNLOAD_URL}"

# Create temp directory
TMP_DIR=$(mktemp -d)
trap 'rm -rf ${TMP_DIR}' EXIT

# Download binary
echo "Downloading binary..."
curl -L "${DOWNLOAD_URL}" -o "${TMP_DIR}/${BINARY_NAME}"

# Make binary executable
chmod +x "${TMP_DIR}/${BINARY_NAME}"

# Move binary to install directory
echo "Installing to ${INSTALL_DIR}/inferencesh..."
sudo mv "${TMP_DIR}/${BINARY_NAME}" "${INSTALL_DIR}/inferencesh"

# Create symlink for alternative name
echo "Creating 'infsh' symlink..."
sudo ln -sf "${INSTALL_DIR}/inferencesh" "${INSTALL_DIR}/infsh"

echo "Installation complete!"
echo "Try running 'inferencesh' or 'infsh'"