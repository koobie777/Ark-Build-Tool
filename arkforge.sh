#!/usr/bin/env bash
# ╭─────────────────────────────────────────────╮
# │           ARKFORGE ENHANCED v1.1.1          │
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

###--- Main Menu Update ---###
ark_main_menu() {
    clear
    echo -e "${CYAN}"
    echo "╭─────────────────────────────────────────────────────────────╮"
    echo "│                🛰️  ARKFORGE ECOSYSTEM v1.1.1                │"
    echo "│                Modular Build Command Center                 │"
    echo "│  Commander: ${ARK_COMMANDER:-koobie777}                     │"
    echo "│  Status: Operational        Time: $(date -u '+%Y-%m-%d %H:%M:%S') UTC │"
    echo "╰─────────────────────────────────────────────────────────────╯"
    echo -e "${NC}"

    echo -e "${GREEN}Your ARK Fleet:${NC} OnePlus 12 \"waffle\" (primary), OnePlus 10 Pro \"op515dl1\" (secondary)"
    echo

    echo -e "${PURPLE}Primary Operations:${NC}"
    echo "  1) Smart Build      - Device discovery → repo selection → build"
    echo "  2) Recovery Build   - Build TWRP/OrangeFox recovery"
    echo "  3) ROM Build        - Compile a full ROM for a device"
    echo "  4) Boot/Recovery Images - Build boot/recovery from ROM source"
    echo "  5) Resume Build     - Continue interrupted builds"
    echo

    echo -e "${PURPLE}Modules & System:${NC}"
    echo "  6) Device Manager         - Manage device database/configs"
    echo "  7) Repository Manager     - Manage ROM sources"
    echo "  8) Directory Manager      - Manage build/cache/output directories"
    echo "  9) Configuration Manager  - ARK/Forge settings and customization"
    echo

    echo -e "${PURPLE}Fleet & Documentation:${NC}"
    echo "  10) Show Fleet Status  - List all ARK Fleet devices"
    echo "  11) User Guide         - Read the ARKFORGE user guide"
    echo
    echo "  0) Exit ARKFORGE"
    echo

    read -p "Select ARKFORGE operation: " choice

    case $choice in
        1) source "$ARK_MODULES_DIR/ark-smart-device-discovery.sh" ;;
        2) echo "Recovery Build - Coming Soon"; sleep 2 ;;
        3) source "$ARK_MODULES_DIR/ark-build-engine.sh" ;;
        4) source "$ARK_MODULES_DIR/ark-boot-recovery-builder.sh" ;;
        5) source "$ARK_MODULES_DIR/ark-resume-build.sh" ;;
        6) echo "Device Manager - Module Loading..."; sleep 2 ;;
        7) source "$ARK_MODULES_DIR/ark-repo-manager-enhanced.sh" ;;
        8) source "$ARK_MODULES_DIR/ark-directory-manager-fixed.sh" && ark_list_build_directories ;;
        9) source "$ARK_MODULES_DIR/ark-config-manager.sh" ;;
        10) ark_show_fleet_status ;;
        11) ark_show_user_guide ;;
        0) ark_exit ;;
        *) echo -e "${RED}Invalid selection${NC}"; sleep 2 ;;
    esac

    ark_main_menu
}

# Start ARKFORGE
ark_main_menu
