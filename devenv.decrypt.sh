#!/usr/bin/env bash
set -euo pipefail

# Decrypt all `.sops` files in the current directory tree.
# For each `.sops` file found, it writes the decrypted content
# to the corresponding file without the `.sops` extension.

# Traverse the tree starting from current directory
find . -type f -name "*.sops" | while read -r sops_file; do
    # Determine the corresponding unencrypted file
    orig_file="${sops_file%.sops}"

    echo "Decrypting $sops_file → $orig_file"

    # Decrypt the file using sops and overwrite the original
    sops --decrypt "$sops_file" > "$orig_file"
done
