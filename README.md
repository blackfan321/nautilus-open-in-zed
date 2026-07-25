# Open File/Directory in Zed

Inspired by https://github.com/SimBoi/nautilus-open-in-vscode

An extension for Nautilus, adds a menu item to the right-click directory/background to open file/folder in [Zed](https://zed.dev/). Also works for bulk opening files.

## Prerequisites
Ubuntu/Debian:
```bash
apt install -y git curl python3-nautilus
```

Fedora:
```bash
dnf install -y git curl nautilus-python
```

Arch:
```bash
pacman -S git curl nautilus-python
```

## Installation

1. Run in the terminal:
   ```bash
	# 1. download the extension script
	mkdir -p ~/.local/share/nautilus-python/extensions
	curl -L -o ~/.local/share/nautilus-python/extensions/nautilus-open-in-zed.py https://raw.githubusercontent.com/hrbtk/nautilus-open-in-zed/refs/heads/main/nautilus-open-in-zed.py
	# 2. add Zed to your System Path (if it's not)
	sudo ln -s ~/.local/bin/zed /usr/local/bin/zed
	# 3. restart nautilus
	nautilus -q
	```

## Uninstallation

1. Run in the terminal:
	```bash
	# 1. remove extension
	rm -f ~/.local/share/nautilus-python/extensions/nautilus-open-in-zed.py
	# 2. remove Zed symlink
	sudo unlink /usr/local/bin/zed
	# 3. restart Nautilus
	nautilus -q
	```

## NixOS

Supported architectures: `x86_64-linux` and `aarch64-linux`.

You also need [nautilus-python](https://search.nixos.org/packages?channel=unstable&query=nautilus-python) and [zed-editor](https://search.nixos.org/packages?channel=unstable&query=zed-editor) installed on your system.

### NixOS with flakes

```nix
{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    nautilus-open-in-zed = {
      url = "github:hrbtk/nautilus-open-in-zed";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, nautilus-open-in-zed, ... }: {
    nixosConfigurations.hostname = nixpkgs.lib.nixosSystem {
      modules = [{
        environment.systemPackages = [
          nautilus-open-in-zed.packages.x86_64-linux.nautilus-open-in-zed
        ];
      }];
    };
  };
}
```

### Home Manager

```nix
{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.nautilus-open-in-zed.packages.x86_64-linux.nautilus-open-in-zed
  ];
}
```
