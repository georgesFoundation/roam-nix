# Changelog

All notable changes to the Roam Nix package will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

### Added
- Initial Nix package for Roam
- Complete dependency coverage based on AUR analysis
- Auto ELF binary patching with autoPatchelfHook
- Comprehensive test suite
- Desktop integration (icons, .desktop file)
- Modern Nix flake support
- Traditional Nix compatibility
- GitHub Actions CI/CD pipeline
- Full documentation and examples

### Dependencies
- gtk3 (GNOME/GTK toolkit)
- libappindicator-gtk3 (system tray support)
- nss & nspr (security services)
- glib, pango, cairo (graphics libraries)
- libX11 stack (display system)
- pulseaudio & alsa-lib (audio)
- libsecret (keyring access)
- cups (printing support)
- Complete X11 and graphics stack

### Features
- ✅ Builds successfully on NixOS
- ✅ Binary runs without library errors
- ✅ Desktop integration works
- ✅ Comprehensive dependency resolution
- ✅ Modern Nix flake interface
- ✅ Traditional Nix compatibility
- ✅ Automated testing pipeline
- ✅ Production-ready packaging

### Documentation
- Complete README with installation guides
- Development and contributing guidelines
- Troubleshooting section
- Example configurations
- CI/CD pipeline setup

## [196.0.0-beta001] - 2026-01-15

### Updated
- Roam application to version 196.0.0-beta001
- Changed download URL to version-specific .deb using version variable
- Updated SHA256 hash for new .deb package
- Simplified dependencies to match AUR package

## [1.0.0] - 2025-12-15

### Added
- Initial release of Roam Nix package
- Support for Roam version 191.0.0-beta001
- Based on official AUR package analysis
- Complete Electron application dependency coverage