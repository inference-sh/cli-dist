# cli-dist

Binary distribution for the inference.sh CLI tool.

## Quick Install

### Using curl (Linux/macOS)

    # Install latest version
    curl -L https://raw.githubusercontent.com/inference-sh/cli-dist/main/install.sh | bash

    # Or install specific version
    VERSION=1.0.0 curl -L https://raw.githubusercontent.com/inference-sh/cli-dist/main/install.sh | bash

### Using pip

    pip install git+https://github.com/inference-sh/cli.git

## Manual Installation

1. Download the appropriate binary for your system:
   - Linux (x86_64): [inferencesh-linux-amd64](https://raw.githubusercontent.com/inference-sh/cli-dist/main/latest/inferencesh-linux-amd64)
   - macOS (Intel): [inferencesh-darwin-amd64](https://raw.githubusercontent.com/inference-sh/cli-dist/main/latest/inferencesh-darwin-amd64)
   - macOS (Apple Silicon): [inferencesh-darwin-arm64](https://raw.githubusercontent.com/inference-sh/cli-dist/main/latest/inferencesh-darwin-arm64)
   - Windows: [inferencesh-windows-amd64.exe](https://raw.githubusercontent.com/inference-sh/cli-dist/main/latest/inferencesh-windows-amd64.exe)

2. Make the binary executable (Linux/macOS):

    chmod +x ./inferencesh-*

3. Move to a directory in your PATH:

    # Linux/macOS
    sudo mv ./inferencesh-* /usr/local/bin/inferencesh

    # Optional: Create infsh alias
    sudo ln -s /usr/local/bin/inferencesh /usr/local/bin/infsh