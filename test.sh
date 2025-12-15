#!/usr/bin/env bash

# Test script for Roam Nix package

set -e

echo "Testing Roam Nix package..."

# Check if package builds
echo "Building package..."
nix build .#roam

# Check if binary exists
if [ -f "./result/bin/roam" ]; then
    echo "✓ Binary found at ./result/bin/roam"
else
    echo "✗ Binary not found"
    exit 1
fi

# Check if binary is executable
if [ -x "./result/bin/roam" ]; then
    echo "✓ Binary is executable"
else
    echo "✗ Binary is not executable"
    exit 1
fi

# Check if desktop file exists
if [ -f "./result/share/applications/roam.desktop" ]; then
    echo "✓ Desktop file found"
else
    echo "✗ Desktop file not found"
    exit 1
fi

# Check if icons exist
if [ -d "./result/share/icons/hicolor" ]; then
    echo "✓ Icons directory found"
else
    echo "✗ Icons directory not found"
    exit 1
fi

# Check if main binary exists in lib directory
if [ -f "./result/lib/roam/Roam" ]; then
    echo "✓ Main binary found in lib directory"
else
    echo "✗ Main binary not found in lib directory"
    exit 1
fi

echo "All tests passed! 🎉"
echo ""
echo "To run Roam:"
echo "  ./result/bin/roam"
echo ""
echo "To install to your profile:"
echo "  nix profile install .#roam"
