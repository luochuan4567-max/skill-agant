#!/usr/bin/env bash
# Usage: extract-frames.sh <video_path> <output_dir> [num_frames]
# Requires Bash, FFmpeg, ffprobe, awk. Use a fresh output directory.
set -euo pipefail
if (( $# < 2 || $# > 3 )); then
  echo "Usage: $0 <video_path> <output_dir> [num_frames]" >&2
  exit 2
fi
VIDEO="$1"
OUT_DIR="$2"
NUM_FRAMES="${3:-12}"
[[ -f "$VIDEO" ]] || { echo "Video not found: $VIDEO" >&2; exit 1; }
[[ "$NUM_FRAMES" =~ ^[1-9][0-9]*$ ]] && (( NUM_FRAMES <= 200 )) || {
  echo "num_frames must be an integer from 1 to 200" >&2; exit 2;
}
FFMPEG="${FFMPEG:-ffmpeg}"
FFPROBE="${FFPROBE:-ffprobe}"
for dep in "$FFMPEG" "$FFPROBE" awk; do
  command -v "$dep" >/dev/null || { echo "Missing dependency: $dep" >&2; exit 1; }
done
mkdir -p "$OUT_DIR"
shopt -s nullglob
OLD_FRAMES=("$OUT_DIR"/frame_*.jpg)
if (( ${#OLD_FRAMES[@]} > 0 )) || [[ -e "$OUT_DIR/audio.wav" || -e "$OUT_DIR/metadata.txt" ]]; then
  echo "Output already contains generated files; choose a fresh directory: $OUT_DIR" >&2
  exit 1
fi
DURATION=$("$FFPROBE" -v error -show_entries format=duration -of default=nw=1:nk=1 "$VIDEO")
awk -v d="$DURATION" 'BEGIN {exit !(d ~ /^[0-9]+([.][0-9]+)?$/ && d > 0)}' || {
  echo "Invalid or unavailable duration: $DURATION" >&2; exit 1;
}
RESOLUTION=$("$FFPROBE" -v error -select_streams v:0 -show_entries stream=width,height -of csv=s=x:p=0 "$VIDEO")
[[ -n "$RESOLUTION" ]] || { echo "No video stream found" >&2; exit 1; }
FPS=$("$FFPROBE" -v error -select_streams v:0 -show_entries stream=r_frame_rate -of default=nw=1:nk=1 "$VIDEO")
FPS_FILTER=$(awk -v n="$NUM_FRAMES" -v d="$DURATION" 'BEGIN {printf "%.9f", n/d}')
"$FFMPEG" -nostdin -n -v error -i "$VIDEO" -vf "fps=$FPS_FILTER" -frames:v "$NUM_FRAMES" -q:v 2 "$OUT_DIR/frame_%03d.jpg"
FRAMES=("$OUT_DIR"/frame_*.jpg)
(( ${#FRAMES[@]} > 0 )) || { echo "No frames extracted" >&2; exit 1; }
AUDIO_STREAM=$("$FFPROBE" -v error -select_streams a:0 -show_entries stream=index -of csv=p=0 "$VIDEO")
AUDIO_STATUS=absent
if [[ -n "$AUDIO_STREAM" ]]; then
  "$FFMPEG" -nostdin -n -v error -i "$VIDEO" -map 0:a:0 -vn -acodec pcm_s16le -ar 16000 -ac 1 "$OUT_DIR/audio.wav"
  AUDIO_STATUS=extracted
fi
{
  echo "duration_seconds=$DURATION"
  echo "resolution=$RESOLUTION"
  echo "fps=$FPS"
  echo "num_frames_requested=$NUM_FRAMES"
  echo "num_frames_extracted=${#FRAMES[@]}"
  echo "audio_status=$AUDIO_STATUS"
} > "$OUT_DIR/metadata.txt"
echo "Extracted ${#FRAMES[@]} frames; audio=$AUDIO_STATUS; output=$OUT_DIR"
