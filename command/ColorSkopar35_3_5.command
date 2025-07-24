#!/usr/bin/env bash

#########################
# Lens Metadata Settings
#########################
LENS_MAKE="Voigtländer"
LENS_MODEL="Voigtländer COLOR-SKOPAR 35mm F3.5 Aspherical"
LENS_NAME="Voigtländer Color Skopar 35mm F3.5 Aspherical"
FOCAL_LENGTH=35
FOCAL_LENGTH_EQUIV=35
MAX_APERTURE=3.5

#########################
# Initialization
#########################
executed=0
unexecuted=0
total=0
only_files_dropped=true
all_files=()
dir_names=()
dir_counts=()

valid_exts="dng arw raf cr2 cr3 nef orf rw2"

#########################
# Collect files
#########################
for input in "$@"; do
  if [ -f "$input" ]; then
    all_files+=("$input")
  elif [ -d "$input" ]; then
    only_files_dropped=false
    dirname=$(basename "$input")
    dir_names+=("$dirname")
    count=0
    while IFS= read -r -d '' file; do
      all_files+=("$file")
      count=$(expr $count + 1)
    done < <(find "$input" -type f -print0)
    dir_counts+=("$count")
  fi
done

total=${#all_files[@]}

#########################
# Write metadata
#########################
for file in "${all_files[@]}"; do
  ext="${file##*.}"
  ext_lower=$(echo "$ext" | tr '[:upper:]' '[:lower:]')
  match=false
  for v in $valid_exts; do
    if [ "$ext_lower" = "$v" ]; then
      match=true
      break
    fi
  done

  if $match; then
    /usr/local/bin/exiftool \
      -LensMake="$LENS_MAKE" \
      -LensModel="$LENS_MODEL" \
      -Lens="$LENS_NAME" \
      -FocalLength=$FOCAL_LENGTH \
      -FocalLengthIn35mmFormat=$FOCAL_LENGTH_EQUIV \
      -MaxApertureValue=$MAX_APERTURE \
      -overwrite_original \
      "$file" > /dev/null 2>&1
    executed=$(expr $executed + 1)
  else
    unexecuted=$(expr $unexecuted + 1)
  fi
done

#########################
# Generate AlertView message
#########################
summary=""

if $only_files_dropped; then
  summary="Total Dropped Files: $total\\n"
else
  dirs=""
  for i in "${!dir_names[@]}"; do
    name="${dir_names[$i]}"
    count="${dir_counts[$i]}"
    dirs="${dirs}${name} (${count}),"
  done
  dirs=${dirs%,}
  summary="Directory Name: $dirs\\nTotal Dropped Files: $total\\n"
fi

summary+="Files executed: $executed\\nFiles unexecuted: $unexecuted\\n\\n"
summary+="Set the following metadata:\\n"
summary+="Lens Maker: $LENS_MAKE\\nLens Model: $LENS_MODEL\\nLens Name: $LENS_NAME\\nFocal Length: $FOCAL_LENGTH mm\\nFocal Length (35mm equiv.): $FOCAL_LENGTH_EQUIV mm\\nMax Aperture: $MAX_APERTURE"

osascript -e "display dialog \"$summary\" buttons {\"OK\"} default button \"OK\" with title \"ExifTool Result\""
