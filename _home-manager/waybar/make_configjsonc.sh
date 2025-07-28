#!/usr/bin/env bash

# Multiple style files (space-separated or passed as arguments)
style_files=(./style-base.css ./style-dark.css ./style-light.css)

template_file="./config.template"
output_file="./config.jsonc"

# 1. Load @define-color lines into Bash variables from all style files
for style_file in "${style_files[@]}"; do
  while IFS= read -r line; do
    if [[ "$line" =~ ^@define-color[[:space:]]+([A-Za-z0-9_]+)[[:space:]]+([^;]+)\;$ ]]; then
      var="${BASH_REMATCH[1]}"
      value="${BASH_REMATCH[2]}"
      declare "$var=$value"
    fi
  done < "$style_file"
done

# 2. Read the template
template=$(< "$template_file")

# 3. Find all @VARIABLE references in the template
vars=$(grep -o '@[A-Za-z_][A-Za-z0-9_]*' <<< "$template" | sort -u)

# 4. Substitute each @VAR with its actual value
for var in $vars; do
  key="${var:1}"  # remove the leading @
  value="${!key}" # indirect expansion
  template="${template//@$key/$value}"
done

# 5. Write the final config
echo "$template" > "$output_file"
