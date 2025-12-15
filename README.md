# Roam Nix Package

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)](https://github.com/georgesFoundation/Roam-nix)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Nix Version](https://img.shields.io/badge/nix-2.18+-blue.svg)](https://nixos.org)

A complete Nix package for [Roam](https://ro.am), the AI-Powered Virtual HQ platform.

## 🚀 Quick Start

```bash
# Using flakes (recommended)
nix profile install github:georgesFoundation/Roam-nix#roam

# Or locally
git clone https://github.com/georgesFoundation/Roam-nix.git
cd Roam-nix
nix profile install .#roam

# Run Roam
roam
```

## What is Roam?

Roam is an immersive platform that gives remote companies their own virtual HQ for their colleagues, guests, customers, and professional network. It's an entire office building that you can customize for the specific composition of your company or team, consisting of individual offices, conference rooms, team rooms, theaters and more.

## 📦 Installation

### 🌟 Using Flakes (Recommended)

Add to your flake inputs:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    roam-nix.url = "github:georgesFoundation/Roam-nix";
  };

  outputs = { self, nixpkgs, roam-nix }: {
    packages.x86_64-linux = {
      roam = roam-nix.packages.x86_64-linux.roam;
      default = roam-nix.packages.x86_64-linux.roam;
    };
  };
}
```

Then add to your configuration:

```nix
# NixOS configuration.nix
environment.systemPackages = with pkgs; [ roam-nix.packages.x86_64-linux.roam ];

# Home Manager configuration.nix
home.packages = with pkgs; [ roam-nix.packages.x86_64-linux.roam ];
```

### 🚀 Direct Installation

```bash
# From GitHub (recommended)
nix profile install github:georgesFoundation/Roam-nix#roam

# From local clone
git clone https://github.com/georgesFoundation/Roam-nix.git
cd Roam-nix
nix profile install .#roam

# Traditional Nix (without flakes)
nix-env -if . -A roam
```

## Usage

After installation, you can run Roam with:

```bash
roam
```

Or from your application menu.

## Package Details

- **Version**: 191.0.0-beta001
- **Platform**: x86_64-linux
- **Source**: Official Roam .deb package
- **License**: MIT
- **Based on**: AUR package structure and dependencies

## Dependencies

This package includes all necessary runtime dependencies based on the official AUR package:
- gtk3
- libappindicator-gtk3 (for system tray support)
- nss
- xdg-utils
- at-spi2-core (accessibility)
- libdrm
- libgbm
- libxcb
- pulseaudio
- libsecret
- alsa-lib
- libXScrnSaver (screen saver support)

## 🛠️ Development

### Build & Test

```bash
# Build the package
nix build .#roam

# Run comprehensive tests
./test.sh

# Enter development shell
nix develop
```

### 🐛 Troubleshooting

If you encounter library errors, the package includes comprehensive dependency coverage:

- **GTK/GNOME**: gtk3, glib, pango, cairo, gdk-pixbuf
- **System Integration**: libappindicator-gtk3, libXScrnSaver, xdg-utils
- **Audio**: pulseaudio, alsa-lib
- **Security**: nss, nspr, libsecret
- **Display**: Full X11 stack (libX11, libXext, libXrandr, etc.)
- **Graphics**: libdrm, libgbm, libxcb
- **Accessibility**: at-spi2-core
- **Other**: cups, fontconfig, freetype, dbus, expat, image libraries

### 🔧 Contributing

1. Fork this repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes
4. Run tests: `./test.sh`
5. Commit: `git commit -m 'Add amazing feature'`
6. Push: `git push origin feature/amazing-feature`
7. Open a Pull Request

## Contributing

Feel free to submit issues and pull requests to improve this package.

## 📋 Package Details

- **Version**: 191.0.0-beta001
- **Platform**: x86_64-linux
- **Source**: Official Roam .deb package
- **License**: MIT
- **Based on**: AUR package structure and dependencies
- **Build System**: Nix flakes + autoPatchelfHook

## ⚙️ Features

✅ **Complete Dependencies**: All runtime libraries from AUR + comprehensive Electron stack
✅ **Auto Patching**: Uses autoPatchelfHook for binary compatibility
✅ **Proper Wrapping**: Binary wrapped with correct library paths
✅ **Desktop Integration**: Icons, desktop file, documentation included
✅ **AUR Compatible**: Follows Arch Linux packaging patterns
✅ **Well Tested**: Comprehensive test suite included
✅ **Modern Nix**: Works with flakes and traditional Nix

## 🔧 Technical Notes

- **Binary Source**: Repackages official Roam .deb for Nix compatibility
- **Dependency Resolution**: Based on AUR analysis + comprehensive Electron app requirements
- **Library Management**: autoPatchelfHook automatically patches ELF binaries
- **Error Handling**: Ignores problematic ffmpeg dependency to ensure build success
- **Environment Variables**: Properly sets GTK, GDK_PIXBUF, and GIO paths
- **Desktop Files**: Installs .desktop file and icons for application menu integration
