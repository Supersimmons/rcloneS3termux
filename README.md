📤 Android Auto Uploader to S3-Compatible Storage (Cubbit, etc.) via rclone (Termux-based)

This script scans your Android device's Camera folder and automatically uploads all media files (photos, videos, etc.) to a remote S3-compatible storage, such as Cubbit, organized by year/month
It is designed to run on Termux using rclone.
🔧 Features

    ✅ Dry-run mode: simulate uploads before actually copying

    📅 Organizes files by modification date (year/month)

    ♻️ Skips files already uploaded (based on size/checksum)

    🧾 Logs successfully uploaded files

    🐚 Compatible with sh (Bourne shell) – works in Termux without requiring bash

🗃 Compatible with

    ✅ Cubbit S3

    ✅ Any S3-compatible service (Wasabi, Backblaze B2, MinIO, etc.)

    ✅ Also works with any rclone-supported backend (Google Drive, Dropbox, etc.) by editing the dest_base value

📁 Folder Structure Example

```s3remote:your-bucket/folder/
├── 2025/
│   ├── 04/
│   └── 05/
```
📄 Example Log Output
```
🔍 Scanning files...
⬆️ Uploading IMG_20250426_141233.jpg → s3remote:your-bucket/folder/2025/04/
⬆️ Uploading VID_20250501_102859.mp4 → s3remote:your-bucket/folder/2025/05/
⏭️ File already exists with identical content: selfie_20250421.jpg
✅ Upload completed: 2 file(s) uploaded to s3remote:your-bucket/folder/ (Files scanned: 3)
```
🚀 Requirements

* Termux
* rclone installed and configured with an S3-compatible remote
* Access to your /DCIM/Camera folder on Android
* Storage permissions granted in Termux:
  <blockquote>Run: termux-setup-storage</blockquote>
