# cli-dist

binary distribution for the inference.sh CLI tool.

## quick install

### using curl (linux/macos)

    # Install latest version
    curl -L https://cli.inference.sh/install.sh | bash

    # Or install specific version
    VERSION=1.0.0 curl -L https://cli.inference.sh/install.sh | bash

<!-- ### using pip -->

    <!-- pip install git+https://github.com/inference-sh/cli.git -->

## manual installation

1. download the appropriate binary for your system:
   - linux (x86_64): [inferencesh-linux-amd64](https://raw.githubusercontent.com/inference-sh/cli-dist/main/latest/inferencesh-linux-amd64)
   - macOS (Intel): [inferencesh-darwin-amd64](https://raw.githubusercontent.com/inference-sh/cli-dist/main/latest/inferencesh-darwin-amd64)
   - macOS (Apple Silicon): [inferencesh-darwin-arm64](https://raw.githubusercontent.com/inference-sh/cli-dist/main/latest/inferencesh-darwin-arm64)
   - windows: [inferencesh-windows-amd64.exe](https://raw.githubusercontent.com/inference-sh/cli-dist/main/latest/inferencesh-windows-amd64.exe)

2. make the binary executable (linux/macos):

    chmod +x ./inferencesh-*

3. move to a directory in your path:

    # linux/macos
    sudo mv ./inferencesh-* /usr/local/bin/inferencesh

    # optional: create infsh alias
    sudo ln -s /usr/local/bin/inferencesh /usr/local/bin/infsh

## version history

### v0.1.0

