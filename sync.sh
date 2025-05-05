#!/bin/sh

# ✅ Enable/disable dry-run mode (1 = simulate, 0 = actually upload)
DRYRUN=0

# 📁 Source folder containing photos/videos to scan
src="/data/data/com.termux/files/home/storage/dcim/Camera"

# 🗂 Base destination folder on Cubbit or Any S3-compatible service
dest_base="s3remote:your-bucket/folder/"

# 🧾 Log file (only successfully copied files)
log_file="/data/data/com.termux/files/home/storage/shared/upload_log.txt"

# 🧮 Counters
count=0
uploaded=0

echo "🔍 Scanning files..."
echo "📃 Log start: $(date)" > "$log_file"

# Find all files (any extension), excluding .trashed files
find "$src" -type f ! -name ".trashed-*" | while read -r file; do
    # Extract year and month from the file's modification date
    year=$(date -r "$file" +%Y)
    month=$(date -r "$file" +%m)
    dest="$dest_base/$year/$month"

    count=$((count+1))

    # Check if the file already exists with the same checksum
    if rclone check "$file" "$dest" --download --one-way --size-only --checkers=1 --quiet; then
        echo "⏭️ File already exists with identical content: $(basename "$file")"
        continue
    fi

    echo "⬆️ Uploading $(basename "$file") → $dest/"
    if [ "$DRYRUN" -eq 1 ]; then
        echo "[Dry-Run] Simulating upload: $(basename "$file")" >> "$log_file"
    else
        if rclone copy "$file" "$dest" --create-empty-src-dirs --transfers=1 --checksum --quiet; then
            echo "$(basename "$file") → $dest/" >> "$log_file"
            uploaded=$((uploaded+1))
        else
            echo "⚠️ Error during upload of $(basename "$file")" >> "$log_file"
        fi
    fi
done

echo "✅ Upload completed: $uploaded file(s) uploaded to $dest_base/ (Files scanned: $count)"
echo "📌 Log end: $(date)" >> "$log_file"
