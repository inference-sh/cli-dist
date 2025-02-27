# cli-dist

binary distribution for the inference.sh CLI tool.

## quick install

### install latest version
```
curl -fsSL https://cli.inference.sh/install.sh | bash
```

### install specific version
```
curl -fsSL https://cli.inference.sh/install.sh | VERSION=1.0.0 bash
```

### verify the installation
```
inferencesh --version
```

## manual installation

1. download the appropriate binary for your system:
   - linux (x86_64): [inferencesh-linux-amd64](https://raw.githubusercontent.com/inference-sh/cli-dist/main/latest/inferencesh-linux-amd64)
   - macOS (Intel): [inferencesh-darwin-amd64](https://raw.githubusercontent.com/inference-sh/cli-dist/main/latest/inferencesh-darwin-amd64)
   - macOS (Apple Silicon): [inferencesh-darwin-arm64](https://raw.githubusercontent.com/inference-sh/cli-dist/main/latest/inferencesh-darwin-arm64)
   - windows: [inferencesh-windows-amd64.exe](https://raw.githubusercontent.com/inference-sh/cli-dist/main/latest/inferencesh-windows-amd64.exe)

2. make the binary executable (linux/macos):
```
chmod +x ./inferencesh-*
```

3. move to a directory in your path:
```
sudo mv ./inferencesh-* /usr/local/bin/inferencesh
```

4. optional: create infsh alias
```
sudo ln -s /usr/local/bin/inferencesh /usr/local/bin/infsh
```
