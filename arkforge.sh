#!/usr/bin/env bash
# ╭─────────────────────────────────────────────╮
# │           ARKFORGE ENHANCED v1.1.4          │
# │      Modular Ecosystem Orchestrator         │
# │           Commander: koobie777              │
# │        The ARK Ecosystem Supreme            │
# ╰─────────────────────────────────────────────╯

###--- Base Directories ---###
ARK_BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ARK_MODULES_DIR="$ARK_BASE_DIR/modules"
ARK_CONFIG_DIR="$ARK_BASE_DIR/config"
ARK_DOCS_DIR="$ARK_BASE_DIR/docs"

###--- Load ARK Settings ---###
if [[ -f "$ARK_CONFIG_DIR/ark-settings.conf" ]]; then
    source "$ARK_CONFIG_DIR/ark-settings.conf"
fi

###--- ARK Colors ---###
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
NC='\033[0m'

###--- TMUX Session Management ---###
ARK_TMUX_SESSION="arkforge"

# Check if we're in tmux
ark_in_tmux() {
    [[ -n "$TMUX" ]]
}

# Exit handler
ark_exit() {
    clear
    echo -e "${CYAN}"
    echo "╭─────────────────────────────────────────────╮"
    echo "│         🛰️ EXITING THE ARK                 │"
    echo "╰─────────────────────────────────────────────╯"
    echo -e "${NC}"

    echo -e "${GREEN}Thank you for using ARKFORGE, Commander!${NC}"
    echo -e "${YELLOW}The ARK Fleet stands ready for your return.${NC}"
    echo ""

    # If we're in tmux, show session info
    if ark_in_tmux; then
        echo -e "${CYAN}You're in a tmux session.${NC}"
        echo -e "${YELLOW}Detach with: Ctrl-B, then D${NC}"
        echo -e "${YELLOW}Exit tmux window: Ctrl-D or 'exit'${NC}"
    fi

    echo ""
    echo -e "${CYAN}May The ARK be with you! 🛰️${NC}"
    echo ""

    # Exit the script
    exit 0
}

# Error handler with pause
ark_error_handler() {
    local error_msg="$1"
    echo -e "\n${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${RED}⚠️  ERROR DETECTED IN THE ARK${NC}"
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${YELLOW}Error: ${error_msg}${NC}"
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    read -p "Press Enter to continue..."
}

###--- Main Menu ---###
ark_main_menu() {
    clear
    echo -e "${CYAN}"
    echo "╭─────────────────────────────────────────────────────────────╮"
    echo "│                🛰️  ARKFORGE ECOSYSTEM v1.1.4                │"
    echo "│                Modular Build Command Center                 │"
    echo "│  Commander: koobie777                     │"
    echo "│  Status: Operational        Time: $(date -u '+%Y-%m-%d %H:%M:%S') UTC │"
    echo "╰─────────────────────────────────────────────────────────────╯"
    echo -e "${NC}"

    # Show tmux status
    if ark_in_tmux; then
        local session_name=$(tmux display-message -p '#S' 2>/dev/null)
        echo -e "${GREEN}TMUX: Running in session '$session_name'${NC}"
    else
        echo -e "${YELLOW}TMUX: Not in tmux session (use './ark' to launch with tmux)${NC}"
    fi

    echo -e "${GREEN}Your ARK Fleet:${NC} OnePlus 12 \"waffle\" (primary), OnePlus 10 Pro \"op515dl1\" (secondary)"
    echo

    echo -e "${PURPLE}Primary Operations:${NC}"
    echo "  1) Smart Build      - Device discovery → repo selection → build"
    echo "  2) Recovery Build   - Build TWRP/OrangeFox recovery"
    echo "  3) ROM Build        - Compile a full ROM for a device"
    echo "  4) Boot/Recovery Images - Build boot/recovery from ROM source"
    echo "  5) Resume Build     - Continue interrupted builds"
    echo "  6) Repo Sync Only   - Sync repositories without building"
    echo

    echo -e "${PURPLE}Modules & System:${NC}"
    echo "  7) Device Manager         - Manage device database/configs"
    echo "  8) Repository Manager     - Manage ROM sources"
    echo "  9) Directory Manager      - Manage build/cache/output directories"
    echo "  10) Configuration Manager - ARK/Forge settings and customization"
    echo

    echo -e "${PURPLE}Fleet & Documentation:${NC}"
    echo "  11) Show Fleet Status  - List all ARK Fleet devices"
    echo "  12) User Guide         - Read the ARKFORGE user guide"
    echo "  13) Tmux Manager       - Manage ARK tmux sessions"
    echo
    echo "  0) Exit ARKFORGE"
    echo

    read -p "Select ARKFORGE operation: " choice

    case $choice in
        1) source "$ARK_MODULES_DIR/ark-smart-device-discovery.sh" || ark_error_handler "Module load failed" ;;
        2) ark_error_handler "Recovery Build - Module in development" ;;
        3) source "$ARK_MODULES_DIR/ark-build-engine.sh" || ark_error_handler "Module load failed" ;;
        4) source "$ARK_MODULES_DIR/ark-boot-recovery-builder.sh" || ark_error_handler "Module load failed" ;;
        5) source "$ARK_MODULES_DIR/ark-resume-build.sh" || ark_error_handler "Module load failed" ;;
        6) source "$ARK_MODULES_DIR/ark-repo-sync-only.sh" || ark_error_handler "Module load failed" ;;
        7) ark_error_handler "Device Manager - Module in development" ;;
        8) source "$ARK_MODULES_DIR/ark-repo-manager-enhanced.sh" || ark_error_handler "Module load failed" ;;
        9) source "$ARK_MODULES_DIR/ark-directory-manager-fixed.sh" && ark_list_build_directories ;;
        10) source "$ARK_MODULES_DIR/ark-config-manager.sh" || ark_error_handler "Module load failed" ;;
        11) ark_show_fleet_status ;;
        12) ark_show_user_guide ;;
        13) source "$ARK_MODULES_DIR/ark-tmux-manager.sh" || ark_error_handler "Module load failed" ;;
        0) ark_exit ;;
        *) ark_error_handler "Invalid selection: $choice" ;;
    esac

    # Return to menu unless we selected exit
    ark_main_menu
}

# Function to show fleet status
ark_show_fleet_status() {
    clear
    echo -e "${CYAN}"
    echo "╭─────────────────────────────────────────────╮"
    echo "│         🛰️ ARK FLEET STATUS                │"
    echo "╰─────────────────────────────────────────────╯"
    echo -e "${NC}"

    echo -e "${GREEN}Commander koobie777's Fleet:${NC}"
    echo "  • OnePlus 12 'waffle' - ${GREEN}Primary Device${NC}"
    echo "  • OnePlus 10 Pro 'op515dl1' - ${GREEN}Secondary Device${NC}"
    echo ""
    read -p "Press Enter to continue..."
}

# Start ARKFORGE
ark_main_menu
