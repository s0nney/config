#!/bin/bash

delay=5  # Set your desired delay in seconds
screenshot_dir="$HOME/Pictures/Screenshots"
mkdir -p "$screenshot_dir"

echo "Filename options:"
echo "1 - Enter custom name"
echo "2 - Use random name"
read -p "Choose naming option (1 or 2): " name_choice

if [ "$name_choice" = "1" ]; then
    read -p "Enter file name (without extension): " custom_name
    filename="${custom_name}.png"
elif [ "$name_choice" = "2" ]; then
    filename=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '')
    filename="${filename}.png"
else
    echo "Invalid choice. Using random name."
    filename=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8 ; echo '')
    filename="${filename}.png"
fi

full_path="$screenshot_dir/$filename"

echo "Screenshot mode:"
echo "1 - Fullscreen"
echo "2 - Select region"
read -p "Enter capture choice (1 or 2): " capture_choice

echo "Taking screenshot in $delay seconds..."
for ((i=delay; i>0; i--)); do
    echo "$i..."
    sleep 1
done

if [ "$capture_choice" = "1" ]; then
    grim "$full_path"
elif [ "$capture_choice" = "2" ]; then
    echo "Select the area to capture..."
    grim -g "$(slurp)" "$full_path"
else
    echo "Invalid choice. Defaulting to fullscreen."
    grim "$full_path"
fi

echo "Screenshot saved as $full_path"
