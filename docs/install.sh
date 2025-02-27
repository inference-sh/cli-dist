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

# Set install directory and handle platform-specific setup
if [ "$(id -u)" -ne 0 ] && [ -z "$INSTALL_DIR" ]; then
    INSTALL_DIR="$HOME/.local/bin"
    mkdir -p "$INSTALL_DIR"

    # Detect shell and configure PATH
    if [ "$OS" = "darwin" ]; then
        # macOS typically uses .zshrc by default since Catalina
        if [ -n "$ZSH_VERSION" ]; then
            SHELL_RC="$HOME/.zshrc"
        else
            SHELL_RC="$HOME/.bash_profile"
        fi
    else
        # Linux typically uses .bashrc
        SHELL_RC="$HOME/.bashrc"
    fi

    # Add to PATH if not already there
    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        echo "Adding $INSTALL_DIR to your PATH..."
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$SHELL_RC"
        export PATH="$HOME/.local/bin:$PATH"
        echo "NOTE: You may need to restart your terminal or run:"
        echo "      source $SHELL_RC"
    fi
else
    INSTALL_DIR=${INSTALL_DIR:-/usr/local/bin}
fi

# Base URL for downloads
BASE_URL="https://raw.githubusercontent.com/inference-sh/cli-dist/main"

# Construct binary name and URL
BINARY_NAME="inferencesh-${OS}-${ARCH}"
if [ "${OS}" = "windows" ]; then
    BINARY_NAME="${BINARY_NAME}.exe"
fi

# For 'latest' version, use the /latest path, otherwise use /versions/vX.Y.Z
if [ "${VERSION}" = "latest" ]; then
    DOWNLOAD_URL="${BASE_URL}/latest/${BINARY_NAME}"
else
    DOWNLOAD_URL="${BASE_URL}/versions/${VERSION}/${BINARY_NAME}"
fi

echo "Installing inference.sh CLI..."
echo "OS: ${OS}"
echo "Architecture: ${ARCH}"
echo "Version: ${VERSION}"
echo "Download URL: ${DOWNLOAD_URL}"

# Create temp directory
TMP_DIR=$(mktemp -d)
trap 'rm -rf ${TMP_DIR}' EXIT

# Remove existing installation and symlink
if [ -f "${INSTALL_DIR}/inferencesh" ]; then
    echo "Removing existing installation..."
    rm -f "${INSTALL_DIR}/inferencesh"
fi

if [ -L "${INSTALL_DIR}/infsh" ]; then
    echo "Removing existing symlink..."
    rm -f "${INSTALL_DIR}/infsh"
fi

# Download binary with better error handling
echo "Downloading binary..."
if ! curl -fL "${DOWNLOAD_URL}" -o "${TMP_DIR}/${BINARY_NAME}"; then
    echo "Error: Failed to download binary from ${DOWNLOAD_URL}"
    echo "Please check if the binary exists at the specified URL"
    exit 1
fi

# Verify the downloaded file is not empty
if [ ! -s "${TMP_DIR}/${BINARY_NAME}" ]; then
    echo "Error: Downloaded file is empty"
    exit 1
fi

# Make binary executable
chmod +x "${TMP_DIR}/${BINARY_NAME}"

# Move binary to install directory
echo "Installing to ${INSTALL_DIR}/inferencesh..."
mv "${TMP_DIR}/${BINARY_NAME}" "${INSTALL_DIR}/inferencesh"

# Create symlink for alternative name
echo "Creating 'infsh' symlink..."
ln -sf "${INSTALL_DIR}/inferencesh" "${INSTALL_DIR}/infsh"

echo "Installation complete!"
echo "Try running 'inferencesh' or 'infsh'"