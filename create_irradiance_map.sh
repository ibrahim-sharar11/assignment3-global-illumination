#!/bin/bash
# Script to create irradiance map from environment map
# This script resizes and blurs the environment map images for Part 2a

set -e

ENV_MAP_DIR="VancouverConventionCentre"
IRRADIANCE_DIR="VancouverConventionCentreIrradiance"

# Check if ImageMagick is installed
if ! command -v convert &> /dev/null; then
    echo "Error: ImageMagick 'convert' command not found."
    echo "Install with: brew install imagemagick (macOS) or apt-get install imagemagick (Linux)"
    exit 1
fi

# Check if environment map directory exists
if [ ! -d "$ENV_MAP_DIR" ]; then
    echo "Error: Environment map directory '$ENV_MAP_DIR' not found."
    echo "Please extract VancouverConventionCentre.zip first."
    exit 1
fi

# Create irradiance map directory
mkdir -p "$IRRADIANCE_DIR"

echo "Creating irradiance map..."
echo "This will resize images to 512x512 and apply Gaussian blur (radius 25)..."

# Process each cube map face
for img in "$ENV_MAP_DIR"/*.jpg; do
    if [ -f "$img" ]; then
        filename=$(basename "$img")
        echo "Processing $filename..."
        convert "$img" -resize 512x512 -gaussian-blur 0x25 "$IRRADIANCE_DIR/$filename"
    fi
done

echo "Done! Irradiance map created in '$IRRADIANCE_DIR/'"
echo "You can now run Part 2a with: ./example12_irradiance a c"

