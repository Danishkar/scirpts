#!/bin/bash

# Exit on error and undefined vars
set -euo pipefail

# Check for --*-list flag pattern
if [ "$#" -eq 1 ] && [[ "$1" =~ ^--.*-list$ ]]; then
    # Extract directory name from flag (remove -- prefix and -list suffix)
    dir_name="${1#--}"
    dir_name="${dir_name%-list}"

    # Check if directory exists
    if [ ! -d "$dir_name" ]; then
        echo "Error: $dir_name directory not found!"
        exit 1
    fi
    echo "Available scripts in $dir_name directory:"
    echo "=========================================="
    
    # Find and list all .sh files in the specified directory
    found_scripts=0
    for script in "$dir_name"/*.sh; do
        if [ -f "$script" ]; then
            echo "  - ${script}"
            found_scripts=1
        fi
    done
    
    if [ $found_scripts -eq 0 ]; then
        echo "  No .sh scripts found in $dir_name directory"
    fi
    echo "=========================================="
    exit 0
fi

if [ "$#" -eq 1 ] && [[ "$1" = "--get-dir" ]]; then
    echo "Available directories with shell scripts:"
    echo "========================================"
    
    found_dirs=0
    
    # Look for directories containing .sh files
    for dir in */; do
        if [ -d "$dir" ]; then
            # Check if directory contains any .sh files
            has_scripts=0
            for script in "$dir"*.sh; do
                if [ -f "$script" ]; then
                    has_scripts=1
                    break
                fi
            done
            
            if [ $has_scripts -eq 1 ]; then
                dir_name="${dir%/}"  # Remove trailing slash
                script_count=$(find "$dir" -name "*.sh" -type f | wc -l)
                echo "  - $dir_name ($script_count script(s))"
                found_dirs=1
            fi
        fi
    done
    
    if [ $found_dirs -eq 0 ]; then
        echo "  No directories with shell scripts found"
    fi
    
    echo "========================================"
    echo "Use: $0 --<directory>-list to see scripts in a specific directory"
    exit 0
fi

# Check if script argument is provided
if [ "$#" -lt 1 ]; then
    echo "Usage: $0 <relative-path-to-script> # Execute a script"
    echo "       $0 --<directory>-list        # List scripts in a directory"
    exit 1
fi

SCRIPT_PATH="$1"

# Check if script exists
if [ ! -f "$SCRIPT_PATH" ]; then
    echo "Error: Script '$SCRIPT_PATH' not found!"
    exit 1
fi

# Make the script executable if not already
chmod +x "$SCRIPT_PATH"

# Execute the script
echo "Running $SCRIPT_PATH ..."
"$SCRIPT_PATH"

echo "Script $SCRIPT_PATH executed successfully."