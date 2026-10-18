#!/usr/bin/env bash
set -euo pipefail

INPUT_DIR="${1:-$RUNNER_TEMP/oneui9-inputs}"
JADX="$RUNNER_TEMP/jadx/bin/jadx"
APKTOOL="$RUNNER_TEMP/apktool.jar"

# Ensure these are the same APKs originally provided for this project.
echo "81a9e975a9a88a92a94f855c1c4a69dc68dcff28b5e28adfac5adc8ebebc68b4  $INPUT_DIR/SystemUI.apk" | sha256sum -c -
echo "02cc4c77a077a8b30ab97ddf24079e9f1b96e97d9414c5a1aab0f13a88de35f1  $INPUT_DIR/TouchWizHome_2017.apk" | sha256sum -c -

for entry in "SystemUI9:SystemUI.apk" "HomeUI9:TouchWizHome_2017.apk"; do
  output="${entry%%:*}"
  input="$INPUT_DIR/${entry#*:}"
  echo "::group::JADX $output"
  mkdir -p "$output"
  java -version
  "$JADX" --no-res --show-bad-code -j 4 -d "$output/jadx" "$input"
  echo '::endgroup::'

  echo "::group::Apktool $output"
  if ! java -Xmx5g -jar "$APKTOOL" d -f -s "$input" -o "$output/apktool"; then
    echo "::warning::Resource decode failed for $output; retrying without resource decoding"
    rm -rf "$output/apktool"
    java -Xmx5g -jar "$APKTOOL" d -f -s -r "$input" -o "$output/apktool" || echo "::warning::Apktool fallback failed for $output"
  fi
  echo '::endgroup::'

  # Keep text resources/manifests, omit duplicate bulky imagery/embedded binaries.
  if [[ -d "$output/apktool" ]]; then
    find "$output/apktool" -type f \( -name '*.png' -o -name '*.webp' -o -name '*.jpg' -o -name '*.jpeg' -o -name '*.ogg' -o -name '*.mp3' -o -name '*.ttf' -o -name '*.otf' \) -delete
  fi
  sha256sum "$input" > "$output/INPUT_SHA256.txt"
  rm -f "$output/.gitkeep"
done

find SystemUI9 HomeUI9 -type f -size +90M -print -delete
du -sh SystemUI9 HomeUI9
echo "Generated files: $(find SystemUI9 HomeUI9 -type f | wc -l)"