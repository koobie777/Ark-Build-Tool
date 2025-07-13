#!/usr/bin/env bash
# ╭─────────────────────────────────────────────╮
# │           ARKFORGE ENHANCED v1.1.0          │
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
ARK_SUCCESS="\033[32m"
ARK_INFO="\033[36m"
ARK_ACCENT="\033[35m"
ARK_WARN="\033[33m"
ARK_ERROR="\033[31m"
NC="\033[0m"

ark_print() {
    local level="$1"; shift
    local message="$*"
    local timestamp=$(date -u '+%H:%M:%S')
    case $level in
        success) echo -e "${ARK_SUCCESS}[$timestamp] ✅ $message${NC}" ;;
        info)    echo -e "${ARK_INFO}[$timestamp] ℹ️ $message${NC}" ;;
        accent)  echo -e "${ARK_ACCENT}[$timestamp] 🛰️ $message${NC}" ;;
        warn)    echo -e "${ARK_WARN}[$timestamp] ⚠️ $message${NC}" ;;
        error)   echo -e "${ARK_ERROR}[$timestamp] ❌ $message${NC}" ;;
        *)       echo "[$timestamp] $message" ;;
    esac
}

###--- Module Registry ---###
declare -A ARK_MODULES=(
    [device_discovery]="$ARK_MODULES_DIR/ark-smart-device-discovery.sh"
    [repo_manager]="$ARK_MODULES_DIR/ark-repo-manager-enhanced.sh"
    [directory_manager]="$ARK_MODULES_DIR/ark-directory-manager.sh"
    [build_engine]="$ARK_MODULES_DIR/ark-build-engine.sh"
    [config_manager]="$ARK_MODULES_DIR/ark-config-manager.sh"
)

load_ark_module() {
    local module="$1"
    local path="${ARK_MODULES[$module]}"
    if [[ -f "$path" ]]; then
        # shellcheck disable=SC1090
        source "$path"
        ark_print success "Loaded module: $module"
        return 0
    else
        ark_print error "Module not found: $module ($path)"
        return 1
    fi
}

###--- Main Menu ---###
show_main_menu() {
    clear
    echo -e "${ARK_ACCENT}"
    echo "╭─────────────────────────────────────────────────────────────╮"
    echo "│                🛰️  ARKFORGE ECOSYSTEM v3.0                  │"
    echo "│                Modular Build Command Center                 │"
    echo "│  Commander: ${ARK_COMMANDER:-koobie777}                     │"
    echo "│  Status: Operational        Time: $(date -u '+%Y-%m-%d %H:%M:%S UTC') │"
    echo "╰─────────────────────────────────────────────────────────────╯"
    echo -e "${NC}"
    echo -e "${ARK_SUCCESS}Your ARK Fleet: OnePlus 12 \"waffle\" (primary), OnePlus 10 Pro \"op515dl1\" (secondary)${NC}"
    echo
    echo -e "${ARK_ACCENT}Primary Operations:${NC}"
    echo "  1) Smart Build      - Device discovery → repo selection → build"
    echo "  2) Recovery Build   - Build recovery image for a device"
    echo "  3) ROM Build        - Compile a full ROM for a device"
    echo
    echo -e "${ARK_ACCENT}Modules & System:${NC}"
    echo "  4) Device Manager         - Manage device database/configs"
    echo "  5) Repository Manager     - Manage ROM sources"
    echo "  6) Directory Manager      - Manage build/cache/output directories"
    echo "  7) Configuration Manager  - ARK/Forge settings and customization"
    echo
    echo -e "${ARK_ACCENT}Fleet & Documentation:${NC}"
    echo "  8) Show Fleet Status  - List all ARK Fleet devices"
    echo "  9) User Guide         - Read the ARKFORGE user guide"
    echo
    echo -e "${ARK_WARN}  0) Exit ARKFORGE${NC}"
    echo
}

###--- Menu Handlers ---###
handle_smart_build() {
    load_ark_module device_discovery || return
    load_ark_module repo_manager || return
    load_ark_module directory_manager || return
    load_ark_module build_engine || return

    read -p "$(echo -e "${ARK_ACCENT}Enter device name (e.g. OnePlus 12): ${NC}")" device_name
    [[ -z "$device_name" ]] && ark_print error "Device name required!" && return 1

    echo -e "${ARK_ACCENT}Choose build type:${NC}"
    echo "  1) Recovery"
    echo "  2) ROM"
    read -p "Select build type [1/2]: " build_type_choice
    [[ "$build_type_choice" == "2" ]] && build_type="rom" || build_type="recovery"

    # Device discovery (module must implement: ark_smart_device_discovery)
    if declare -f ark_smart_device_discovery >/dev/null; then
        ark_smart_device_discovery "$device_name" "$build_type"
    else
        ark_print warn "Device discovery function not implemented in module."
    fi

    load_ark_module build_engine
    case "$build_type" in
        recovery)
            if declare -f execute_recovery_build >/dev/null; then
                execute_recovery_build "$device_name"
            else
                ark_print warn "Recovery build function not found."
            fi
            ;;
        rom)
            if declare -f execute_rom_build >/dev/null; then
                execute_rom_build "$device_name"
            else
                ark_print warn "ROM build function not found."
            fi
            ;;
    esac
}

handle_recovery_build() {
    load_ark_module build_engine || return
    read -p "$(echo -e "${ARK_ACCENT}Enter device codename: ${NC}")" codename
    [[ -z "$codename" ]] && ark_print error "Device codename required!" && return 1
    if declare -f execute_recovery_build >/dev/null; then
        execute_recovery_build "$codename"
    else
        ark_print warn "Recovery build function not found."
    fi
}

handle_rom_build() {
    load_ark_module build_engine || return
    read -p "$(echo -e "${ARK_ACCENT}Enter device codename: ${NC}")" codename
    [[ -z "$codename" ]] && ark_print error "Device codename required!" && return 1
    if declare -f execute_rom_build >/dev/null; then
        execute_rom_build "$codename"
    else
        ark_print warn "ROM build function not found."
    fi
}

handle_device_manager() {
    load_ark_module device_discovery
    ark_print info "Launching Device Manager (edit configs in config/devices/)..."
    [[ -x "$(command -v nano)" ]] && nano "$ARK_CONFIG_DIR/devices/ark-device-database.conf"
}

handle_repo_manager() {
    load_ark_module repo_manager
    ark_print info "Launching Repository Manager (edit configs in config/repositories/)..."
    [[ -x "$(command -v nano)" ]] && nano "$ARK_CONFIG_DIR/repositories/yaap.conf"
}

handle_directory_manager() {
    load_ark_module directory_manager
    ark_print info "Launching Directory Manager (edit builds/cache/logs directories)..."
    [[ -x "$(command -v ls)" ]] && ls -al "$ARK_BASE_DIR/builds" "$ARK_BASE_DIR/cache" "$ARK_BASE_DIR/logs"
}

handle_config_manager() {
    load_ark_module config_manager
    if declare -f configuration_manager_interface >/dev/null; then
        configuration_manager_interface
    else
        ark_print warn "Configuration manager interface not found in module."
    fi
}

handle_show_fleet() {
    ark_print accent "The ARK Fleet Devices:"
    grep -E '^\[.*\]' "$ARK_CONFIG_DIR/devices/ark-fleet.conf" | sed -e 's/^\[\(.*\)\]$/- \1/'
}

handle_user_guide() {
    if [[ -f "$ARK_DOCS_DIR/arkforge-user-guide.md" ]]; then
        less "$ARK_DOCS_DIR/arkforge-user-guide.md"
    else
        ark_print warn "User guide not found. Please create docs/arkforge-user-guide.md"
    fi
}

###--- Main Loop ---###
while true; do
    show_main_menu
    read -p "$(echo -e "${ARK_ACCENT}Select ARKFORGE operation: ${NC}")" choice
    echo
    case "$choice" in
        1) handle_smart_build ;;
        2) handle_recovery_build ;;
        3) handle_rom_build ;;
        4) handle_device_manager ;;
        5) handle_repo_manager ;;
        6) handle_directory_manager ;;
        7) handle_config_manager ;;
        8) handle_show_fleet ;;
        9) handle_user_guide ;;
        0) ark_print accent "May The ARK be with you, Commander!"; exit 0 ;;
        *) ark_print warn "Invalid selection, try again." ;;
    esac
    echo
    read -p "Press Enter to return to the ARKFORGE main menu..."
done
