#!/system/bin/sh
# Usage:
#   adb push disableBloatware.sh com.google.remove com.android.remove com.hihonor.remove /storage/emulated/0/Download/odds_n_ends/
#   adb shell sh /storage/emulated/0/Download/odds_n_ends/disableBloatware.sh
#
# This script will iterate through the following files:
#   - com.google.remove
#   - com.android.remove
#   - com.hihonor.remove
# For each non-comment line (lines not starting with '#') in these files,
# it will execute:
#   pm clear <package>
#   pm uninstall <package>
#   pm uninstall --user 0 <package>

# Define the directory where the files are stored.
FILE_DIR="/storage/emulated/0/Download/odds_n_ends"

# Define an array of package list filenames.
FILES="$FILE_DIR/com.google.remove $FILE_DIR/com.android.remove $FILE_DIR/com.hihonor.remove"

# Iterate through each file in the list.
for PACKAGE_FILE in $FILES; do
  if [ ! -f "$PACKAGE_FILE" ]; then
    echo "Package file not found: $PACKAGE_FILE"
    continue
  fi

  echo "Processing file: $PACKAGE_FILE"
  
  # Read the file line by line.
  while IFS= read -r APP || [ -n "$APP" ]; do
    # Skip lines that start with '#' or are empty.
    case "$APP" in
      \#*) continue ;;
    esac
    if [ -z "$APP" ]; then
      continue
    fi

    echo "Processing package: $APP"
    pm clear "$APP"
    pm uninstall "$APP"
    pm uninstall --user 0 "$APP"
  done < "$PACKAGE_FILE"
done