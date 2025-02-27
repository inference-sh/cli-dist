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
# Remove existing installation and symlink
if [ -f "${INSTALL_DIR}/inferencesh" ]; then
    echo "Removing existing installation..."
    rm "${INSTALL_DIR}/inferencesh"
fi

if [ -L "${INSTALL_DIR}/infsh" ]; then
    echo "Removing existing symlink..."
    rm "${INSTALL_DIR}/infsh"
fi

# Move binary to install directory
echo "Installing to ${INSTALL_DIR}/inferencesh..."
mv "${TMP_DIR}/${BINARY_NAME}" "${INSTALL_DIR}/inferencesh"

# Create symlink for alternative name
echo "Creating 'infsh' symlink..."
ln -sf "${INSTALL_DIR}/inferencesh" "${INSTALL_DIR}/infsh"

echo "Installation complete!"
echo "Try running 'inferencesh' or 'infsh'"