#!/bin/sh

# Set the path to your password store
password_dir="$HOME/.password-store"

# Check if the password store directory exists
if [ ! -d "$password_dir" ]; then
  echo "Password store directory not found: $PASSWORD_STORE_DIR"
  exit 1
fi

# Find all password files in the password store directory
files=$(find "$PASSWORD_STORE_DIR" -type f -name "*.gpg" | sed -e "s|$PASSWORD_STORE_DIR/||" -e "s|\.gpg$||")

# Use fzf to let the user select a file
selected_file=$(echo "$files" | fzy)

# Check if the user selected a file
if [ -n "$selected_file" ]; then
  # Use pass to copy the selected password to the clipboard
  pass -c "$selected_file"

  echo "Password copied to clipboard: $selected_file"
else
  echo "No file selected. Exiting."
  exit 1
fi
