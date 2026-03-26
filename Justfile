# Update Roam to the latest version
update:
    #!/usr/bin/env bash
    set -euo pipefail

    download_url="https://download.ro.am/Roam/8a86d88cfc9da3551063102e9a4e2a83/latest/linux/x64/Roam.deb"
    deb_path=$(mktemp /tmp/Roam-XXXXXX.deb)
    trap "rm -f $deb_path" EXIT

    echo "Downloading latest Roam .deb..."
    curl -fSL -o "$deb_path" "$download_url"

    echo "Extracting version..."
    new_version=$(ar p "$deb_path" control.tar.xz | tar xJf - --to-stdout ./control | grep '^Version:' | cut -d' ' -f2)
    echo "Latest version: $new_version"

    current_version=$(grep 'version = ' default.nix | head -1 | sed 's/.*"\(.*\)".*/\1/')
    echo "Current version: $current_version"

    if [ "$new_version" = "$current_version" ]; then
        echo "Already up to date!"
        exit 0
    fi

    echo "Fetching hash for versioned URL..."
    versioned_url="https://download.ro.am/Roam/8a86d88cfc9da3551063102e9a4e2a83/linux/debian/binary/${new_version}-roam_${new_version}_amd64.deb"
    new_hash=$(nix-prefetch-url "$versioned_url")
    echo "New hash: $new_hash"

    echo "Updating default.nix..."
    sed -i "s|version = \"$current_version\"|version = \"$new_version\"|" default.nix
    sed -i "s|sha256 = \".*\"|sha256 = \"$new_hash\"|" default.nix

    echo "Updated $current_version -> $new_version"
