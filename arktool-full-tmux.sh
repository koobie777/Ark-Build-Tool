#!/usr/bin/env bash
set -euo pipefail

# ╭──────────────────────────────╮
# │       TEAM 🜁  A R K         │
# ╰──────────────────────────────╯
echo -e "\n🌌 Welcome to TEAM 🜁  A R K Build Toolkit 🌌"
echo "────────────────────────────────────────────"
echo

# ──────────────── Auto-Tmux ────────────────
if [[ -z "${TMUX:-}" ]]; then
  session_name="arktool"
  tmux new-session -A -s "$session_name" "$0"
  exit
fi

# ──────────────── Theme ────────────────
if [[ "${THEME:-dark}" == "light" ]]; then
  menu_color="\033[1;34m"
  reset_color="\033[0m"
else
  menu_color="\033[1;36m"
  reset_color="\033[0m"
fi

# ──────────────── ROM Select ────────────────
ROM_DIR="$HOME/android"
ROM_LIST=($(find "$ROM_DIR" -mindepth 1 -maxdepth 1 -type d -exec test -e '{}/build/envsetup.sh' \; -print | xargs -n1 basename))

[[ ${#ROM_LIST[@]} -eq 0 ]] && echo "❌ No ROMs in $ROM_DIR" && exit 1

echo "📦 Select a ROM to build:"
select ROM in "${ROM_LIST[@]}" "Exit"; do
  [[ -z "$ROM" || "$ROM" == "Exit" ]] && exit 0
  BUILD_DIR="$ROM_DIR/$ROM"
  break
done

# ──────────────── Config ────────────────
CONFIG_DIR="$HOME/.config/arktool"
CONFIG_FILE="$CONFIG_DIR/$ROM.conf"
mkdir -p "$CONFIG_DIR"

[[ ! -f "$CONFIG_FILE" ]] && cat <<EOF > "$CONFIG_FILE"
LUNCH_COMBO="${ROM}_waffle-userdebug"
TARGET_PRODUCT="waffle"
TARGET_BUILD_VARIANT="userdebug"
BUILD_TYPE="rom"
CUSTOM_TARGETS="bacon"
EXTRA_FLAGS=""
OUTPUT_DIR="\$HOME/builds/$ROM"
USE_CCACHE=true
MAKE_JOBS=1
SYNC_JOBS=$(nproc)
NTFY_TOPIC="ark-$ROM"
THEME="dark"
MAKE_CMD="m"
PRE_BUILD_HOOK=""
POST_BUILD_HOOK=""
EOF

source "$CONFIG_FILE"

declare -A REQUIRED_CONFIG_DEFAULTS=(
  ["LUNCH_COMBO"]="${ROM}_waffle-userdebug"
  ["TARGET_PRODUCT"]="waffle"
  ["TARGET_BUILD_VARIANT"]="userdebug"
  ["BUILD_TYPE"]="rom"
  ["CUSTOM_TARGETS"]="bacon"
  ["EXTRA_FLAGS"]=""
  ["OUTPUT_DIR"]="\$HOME/builds/$ROM"
  ["USE_CCACHE"]="true"
  ["MAKE_JOBS"]="1"
  ["SYNC_JOBS"]="$(nproc)"
  ["NTFY_TOPIC"]="ark-$ROM"
  ["THEME"]="dark"
  ["MAKE_CMD"]="m"
  ["PRE_BUILD_HOOK"]=""
  ["POST_BUILD_HOOK"]=""
)

for key in "${!REQUIRED_CONFIG_DEFAULTS[@]}"; do
  if ! grep -q "^$key=" "$CONFIG_FILE"; then
    echo "$key="${REQUIRED_CONFIG_DEFAULTS[$key]}"" >> "$CONFIG_FILE"
  fi
done

: "${LUNCH_COMBO:=${ROM}_waffle-userdebug}"
: "${TARGET_PRODUCT:=waffle}"
: "${CUSTOM_TARGETS:=bacon}"
: "${OUTPUT_DIR:=$HOME/builds/$ROM}"
: "${SYNC_JOBS:=$(nproc)}"
: "${NTFY_TOPIC:=ark-$ROM}"
: "${MAKE_CMD:=m}"

log_file="$BUILD_DIR/build.log"
ntfy_topic="$NTFY_TOPIC"

send_ntfy() {
  command -v curl &>/dev/null && curl -s -H "Title: ARKTool" -d "$2" "https://ntfy.sh/$1" >/dev/null || true
}

run_in_build_shell() {
  local BUILD_CMD="$1"
  cd "$BUILD_DIR"

  [[ -n "${PRE_BUILD_HOOK:-}" ]] && bash -c "$PRE_BUILD_HOOK"

  local start_ts=$(date +%s)
  local start_human=$(date)

  eval "source build/envsetup.sh && lunch $LUNCH_COMBO && $BUILD_CMD" 2>&1 | tee "$log_file"
  local status=${PIPESTATUS[0]}

  local end_ts=$(date +%s)
  local end_human=$(date)
  local duration=$((end_ts - start_ts))

  mkdir -p "$OUTPUT_DIR"
  final_zip=$(find "$BUILD_DIR/out/target/product/$TARGET_PRODUCT" -name "$CUSTOM_TARGETS*.zip" -type f -printf "%T@ %p\n" | sort -n | tail -1 | cut -d' ' -f2-)

  if [[ -f "$final_zip" ]]; then
    cp "$final_zip" "$OUTPUT_DIR/"
    echo "✅ Zip copied to: $OUTPUT_DIR/$(basename "$final_zip")"
    [[ -n "${POST_BUILD_HOOK:-}" ]] && bash -c "$POST_BUILD_HOOK"
  else
    echo "⚠️  Build zip not found: $CUSTOM_TARGETS*.zip"
  fi

  echo "📄 Build log saved at: $log_file"

  git_branch=$(cd "$BUILD_DIR" && git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
  git_tag=$(cd "$BUILD_DIR" && git describe --tags --exact-match 2>/dev/null || echo "none")

  cat <<EOF > "$OUTPUT_DIR/build-meta.txt"
BUILD_START_TIME=$start_human
BUILD_END_TIME=$end_human
BUILD_DURATION=$((duration/60))m $((duration%60))s
GIT_BRANCH=$git_branch
GIT_TAG=$git_tag
LUNCH_COMBO=$LUNCH_COMBO
TARGET_PRODUCT=$TARGET_PRODUCT
CUSTOM_TARGETS=$CUSTOM_TARGETS
EOF

  send_ntfy "$ntfy_topic" "Build done in $((duration/60))m $((duration%60))s"

  if [[ $status -ne 0 ]]; then
    echo -e "\n❌ Build exited with code $status"
    echo "🔧 What do you want to do?"
    echo "  1) View log"
    echo "  2) Retry"
    echo "  3) Return to menu"
    read -p "🔢 Choice [1-3]: " fail_choice
    case "$fail_choice" in
      1) view_log ;;
      2) run_in_build_shell "$BUILD_CMD" ;;
      *) return ;;
    esac
  fi
}

sync_sources() {
  cd "$BUILD_DIR"
  repo sync --force-sync -j"$SYNC_JOBS" | tee -a "$BUILD_DIR/sync.log"
  echo "✅ Sync complete. Press enter to continue."
  read
}

clean_only() {
  cd "$BUILD_DIR"
  make clean
  echo "🧹 Clean complete. Press enter to continue."
  read
}

view_log() {
  echo "📖 Showing build log:"
  echo "──────────────────────────────"
  cat "$log_file"
  echo "──────────────────────────────"
  read -p "🔁 Press Enter to return..."
}

open_terminal() {
  if command -v gnome-terminal &>/dev/null; then
    gnome-terminal --working-directory="$BUILD_DIR" &
  elif command -v konsole &>/dev/null; then
    konsole --workdir "$BUILD_DIR" &
  else
    echo "❌ No supported terminal found."
    read
  fi
}

edit_config() {
  nano "$CONFIG_FILE"
}

menu() {
  echo -e "$menu_color"
  echo "🛰️ Choose your build action:"
  echo "  1️⃣  Clean Build"
  echo "  2️⃣  Resume Build"
  echo "  3️⃣  Build Recovery + Boot"
  echo "  4️⃣  Clean Only"
  echo "  5️⃣  Sync + Clean Build"
  echo "  6️⃣  Sync Only"
  echo "  7️⃣  Launch Terminal"
  echo "  8️⃣  Edit Config"
  echo "  9️⃣  View Build Log"
  echo "  🔚  Exit"
  echo -ne "$reset_color"
}

while true; do
  clear
  menu
  echo
  read -p "🔢 Enter your choice [1-10]: " choice
  case "$choice" in
    1) run_in_build_shell "$MAKE_CMD clean && $MAKE_CMD $CUSTOM_TARGETS $EXTRA_FLAGS" ;;
    2) run_in_build_shell "$MAKE_CMD $CUSTOM_TARGETS $EXTRA_FLAGS" ;;
    3) run_in_build_shell "$MAKE_CMD bootimage recoveryimage $EXTRA_FLAGS" ;;
    4) clean_only ;;
    5) sync_sources && run_in_build_shell "$MAKE_CMD clean && $MAKE_CMD $CUSTOM_TARGETS $EXTRA_FLAGS" ;;
    6) sync_sources ;;
    7) open_terminal ;;
    8) edit_config ;;
    9) view_log ;;
    10) echo "👋 Exiting..." && exit 0 ;;
    *) echo "❓ Invalid option. Press enter to retry." && read ;;
  esac
done
