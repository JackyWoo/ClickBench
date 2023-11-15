#!/bin/bash

# Set the file paths for the first and second TSV files
file1="$1"
file2="$2"

# Create a temporary file to store the merged result
merged_file="merged_file.csv"
echo "sql,o1,o2,o3,n1,n2,n3"

# Merge the files
paste -d ',' "$file1" <(cut -d ',' -f 2- "$file2") > "$merged_file"

# Print the merged file
cat "$merged_file"

# Clean up the temporary file
rm "$merged_file"
