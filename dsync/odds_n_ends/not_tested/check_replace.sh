#!/bin/bash
# Usage: ./check_replace.sh input_file packages_file
# Example:
#   ./check_replace.sh myinput.txt installed_packages.txt

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_file> <packages_file>"
    exit 1
fi

input_file="$1"
packages_file="$2"

while IFS= read -r line; do
    # Check if the line contains "huawei" (case-insensitive)
    if echo "$line" | grep -qi "huawei"; then
        # Replace all occurrences of "huawei" with "honor"
        modified_line=$(echo "$line" | sed 's/huawei/honor/gI')
        # Check if the modified line is present in the packages file
        if grep -Fq "$modified_line" "$packages_file"; then
            echo "Match found: $modified_line"
        else
            echo "No match for: $modified_line"
        fi
    fi
done < "$input_file"