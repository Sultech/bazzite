#!/bin/bash

# Define the video options to append
VIDEO_OPTIONS="video=DP-1:1920x1080@61 video=DP-3:1920x1080@185"

# Use rpm-ostree to append kernel arguments if missing
rpm-ostree kargs --append-if-missing="$VIDEO_OPTIONS"

echo "Checked and appended video options to kernel arguments if they were missing."

