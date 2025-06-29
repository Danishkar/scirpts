#!/bin/bash

PASSWORD_FILE="$HOME/passwords.csv" #File to save passwords
LENGTH=16                           # Default password length

# Function to generate a random password
generate_password() {
  tr -dc 'A-Za-z0-9!@#$%^&*()-_+=' </dev/urandom | head -c $LENGTH
}

# Check for correct number of arguments
if [ $# -ne 2 ]; then
  echo "Usage: $0 <username> <save_to_file (true/false)>"
  exit 1
fi

USERNAME=$1
SAVE_TO_FILE=$2
PASSWORD=$(generate_password)

if [ "$SAVE_TO_FILE" == "true" ]; then
  echo "$USERNAME,$PASSWORD" >>$PASSWORD_FILE
  echo "Password for $USERNAME saved to $PASSWORD_FILE."
else
  echo "Generated password for $USERNAME: $PASSWORD"
fi
