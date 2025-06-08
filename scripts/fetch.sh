#!/bin/bash

# Custom ASCII Art - modify as desired
ascii_art=$(cat << "EOF"
 __
/_/\/\
\_\  /
/_/  \
\_\/\ \
   \_\/
EOF
)

# Get system information
sys_info=$(screenfetch -p -n -d '-host;-kernel;-res;-cpu;-gpu;-mem;-disk;-de;-wmtheme;-gtk;')

# Display side-by-side
paste <(echo "$ascii_art") <(echo "$sys_info") | column -s $'\t' -t
