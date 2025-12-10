#!/usr/bin/env bash
set -euo pipefail

# Encrypt all files with a corresponding `.sops` file if they are newer.
# Skips files that are not newer or do not exist.

export SOPS_AGE_KEY_FILE="$HOME/.gnupg/age/sysconf.txt"

find . -type f -name "*.sops" | while read -r sops_file; do
    # Determine the corresponding unencrypted file
    orig_file="${sops_file%.sops}"

    if [ -f "$orig_file" ]; then
        # Check if the original file is newer than the .sops file
        if [ "$orig_file" -nt "$sops_file" ]; then
            
            echo "Encrypting $orig_file → $sops_file"

            sops --encrypt "$orig_file" > "$orig_file.sops"
        else
            # File exists but is not newer; do nothing
            :
        fi
    else
        # Corresponding file does not exist; do nothing
        :
    fi
done
