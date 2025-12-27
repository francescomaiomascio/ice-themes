#!/usr/bin/env bash
set -e

ROOT="$(cd "$(dirname "$0")" && pwd)"
MASTER="$ROOT/master/ice.png"

PNG_OUT="$ROOT/png"
FAVICON_OUT="$ROOT/favicon"
ELECTRON_OUT="$ROOT/electron"

# includiamo 48
SIZES=(1024 512 256 128 64 48 32 16)

echo "▶ Generating PNG sizes…"
mkdir -p "$PNG_OUT"
for size in "${SIZES[@]}"; do
  magick "$MASTER" -resize "${size}x${size}" "$PNG_OUT/${size}.png"
done

echo "▶ Generating favicon…"
mkdir -p "$FAVICON_OUT"
cp "$PNG_OUT/32.png" "$FAVICON_OUT/favicon-32.png"
cp "$PNG_OUT/16.png" "$FAVICON_OUT/favicon-16.png"
magick \
  "$PNG_OUT/16.png" \
  "$PNG_OUT/32.png" \
  "$PNG_OUT/48.png" \
  "$FAVICON_OUT/favicon.ico"

echo "▶ Generating Electron icons…"
mkdir -p "$ELECTRON_OUT"
cp "$PNG_OUT/512.png" "$ELECTRON_OUT/icon.png"
magick \
  "$PNG_OUT/256.png" \
  "$PNG_OUT/128.png" \
  "$PNG_OUT/64.png" \
  "$PNG_OUT/48.png" \
  "$PNG_OUT/32.png" \
  "$ELECTRON_OUT/icon.ico"

echo "✔ Icons generated successfully."
