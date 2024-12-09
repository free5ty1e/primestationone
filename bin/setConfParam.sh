#!/bin/bash

# Check if the correct number of arguments are provided
if [ $# -ne 3 ]; then
    echo "Usage: $0 <config_file> <parameter> <value>"
    exit 1
fi

config_file="$1"
parameter="$2"
value="$3"

# Check if the config file exists
if [ ! -f "$config_file" ]; then
    echo "Error: Config file not found: $config_file"
    exit 1
fi

# Check if the parameter exists in the config file
if grep -q "^$parameter=" "$config_file"; then
    # Parameter exists, update its value
    sed -i "s/^$parameter=.*/$parameter=$value/" "$config_file"
    echo "Parameter updated successfully."
else
    # Parameter does not exist, add it
    echo "$parameter=$value" >> "$config_file"
    echo "Parameter added successfully."
fi
