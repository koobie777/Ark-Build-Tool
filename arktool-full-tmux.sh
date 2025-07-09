#!/usr/bin/env bash
set -euo pipefail

# ╭──────────────────────────────╮
# │       TEAM 🜁  A R K         │
# ╰──────────────────────────────╯
echo -e "\n🌌 \033[1;36mWelcome to TEAM 🜁  A R K Build Toolkit\033[0m 🌌"
echo "────────────────────────────────────────────"
echo

# ──────────────── COLOR SUPPORT ────────────────
color() {
  case "$1" in
    menu) echo -e "\033[1;32m" ;; # green
    ok) echo -e "\033[1;36m" ;;   # cyan
    err) echo -e "\033[1;31m" ;;  # red
    *) echo -e "\033[0m" ;;       # default
  esac
}
reset_color="\033[0m"

# ──────────────── ROM Select ────────────────
ROM_DIR="$HOME/android"
ROM_LIST=($(find "$ROM_DIR" -mindepth 1 -maxdepth 1 -type d -exec test -e '{}/build/envsetup.sh' \; -print | xargs -n1 basename))

[[ ${#ROM_LIST[@]} -eq 0 ]] && echo "❌ No ROMs found in $ROM_DIR" && exit 1

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
NTFY_TOPIC="ark-$ROM"
THEME="dark"
EOF

source "$CONFIG_FILE"
log_file="$BUILD_DIR/build.log"
ntfy_topic="${NTFY_TOPIC:-ark-$ROM}"

# ──────────────── Functions ────────────────
send_ntfy() {
  command -v curl &>/dev/null && curl -s -H "Title: ARKTool" -d "$2" "https://ntfy.sh/$1" >/dev/null || true
}

run_in_build_shell() {
  local BUILD_CMD="$1"
  cd "$BUILD_DIR"
  local start=$(date +%s)

  bash --rcfile <(
    echo 'source build/envsetup.sh'
    echo "lunch $LUNCH_COMBO"
    echo "$BUILD_CMD"
    echo 'ret=\${PIPESTATUS[0]}'
    echo 'echo ""; read -p \"🔁 Press Enter to return to menu...\"'
    echo 'exit $ret'
  ) /dev/null

  local end=$(date +%s)
  local duration=$((end - start))

  mkdir -p "$OUTPUT_DIR"
  final_zip="$BUILD_DIR/out/target/product/$TARGET_PRODUCT/$CUSTOM_TARGETS.zip"
  [[ -f "$final_zip" ]] && cp "$final_zip" "$OUTPUT_DIR/" || true

  send_ntfy "$ntfy_topic" "✅ Build finished in $((duration/60))m $((duration%60))s."
}

sync_sources() {
  cd "$BUILD_DIR"
  repo sync --force-sync -j$(nproc) | tee -a "$BUILD_DIR/sync.log"
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
  echo -e "$(color menu)"
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
  echo "  🔚  10) Exit"
  echo -ne "$reset_color"
}

# ──────────────── Main Menu Loop ────────────────
while true; do
  menu
  echo -n "🪐 Enter choice [1-10]: "
  read -r choice
  case "$choice" in
    1) clean_only; run_in_build_shell "m -j1 ${CUSTOM_TARGETS:-bacon} $EXTRA_FLAGS | tee \"$log_file\"" ;;
    2) run_in_build_shell "m -j1 ${CUSTOM_TARGETS:-bacon} $EXTRA_FLAGS | tee \"$log_file\"" ;;
    3)
      [[ "$BUILD_TYPE" =~ ^(twrp|orangefox|recovery)$ ]] && targets="recoveryimage" || targets="bootimage recoveryimage"
      run_in_build_shell "m -j1 $targets $EXTRA_FLAGS | tee \"$log_file\"" ;;
    4) clean_only ;;
    5) sync_sources; clean_only; run_in_build_shell "m -j1 ${CUSTOM_TARGETS:-bacon} $EXTRA_FLAGS | tee \"$log_file\"" ;;
    6) sync_sources ;;
    7) open_terminal ;;
    8) edit_config ;;
    9) view_log ;;
    10) echo -e "$(color ok)👋 Exiting ARKTool. Commander out.$reset_color" && break ;;
    *) echo -e "$(color err)❌ Invalid option.$reset_color" ;;
  esac
  echo ""
done
