#!/usr/bin/env bash
# ╭──────────────────────────────────────╮
# │   ARK CONFIG MANAGER MODULE         │
# │   Configuration Management System   │
# │   Commander: koobie777               │
# │   Time: 2025-07-13 04:02:25 UTC      │
# ╰──────────────────────────────────────╯

# ARK Configuration Manager - Handle all ARK configurations
# This module manages device, repository, and build configurations

# Load ARK settings
ARK_BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
if [[ -f "$ARK_BASE_DIR/config/ark-settings.conf" ]]; then
    source "$ARK_BASE_DIR/config/ark-settings.conf"
fi

# ARK Colors
export ARK_SUCCESS="\033[32m"
export ARK_INFO="\033[36m"
export ARK_ACCENT="\033[35m"
export ARK_WARN="\033[33m"
export ARK_ERROR="\033[31m"
export NC="\033[0m"

# Enhanced print function
ark_print_enhanced() {
    local level="$1"
    local message="$2"
    local timestamp=$(date -u '+%H:%M:%S')
    
    case $level in
        "success") echo -e "${ARK_SUCCESS}[$timestamp] ✅ $message${NC}" ;;
        "info")    echo -e "${ARK_INFO}[$timestamp] ℹ️  $message${NC}" ;;
        "accent")  echo -e "${ARK_ACCENT}[$timestamp] 🛰️  $message${NC}" ;;
        "warn")    echo -e "${ARK_WARN}[$timestamp] ⚠️  $message${NC}" ;;
        "error")   echo -e "${ARK_ERROR}[$timestamp] ❌ $message${NC}" ;;
    esac
}

# Show header function
show_header() {
    local title="$1"
    local subtitle="$2"
    
    clear
    echo -e "${ARK_ACCENT}"
    echo "╭─────────────────────────────────────────────────────────────╮"
    echo "│                    🛰️  THE ARK ECOSYSTEM                    │"
    echo "│                   $title                   │"
    echo "│                                                             │"
    echo "│  $subtitle  │"
    echo "│  Commander: $ARK_COMMANDER                                       │"
    echo "│  Time: $(date -u '+%Y-%m-%d %H:%M:%S UTC')                              │"
    echo "╰─────────────────────────────────────────────────────────────╯"
    echo -e "${NC}"
    echo ""
}

# Configuration management interface
configuration_manager_interface() {
    show_header "ARK CONFIG MANAGER" "Configuration Management System"
    
    echo -e "${ARK_ACCENT}═══ ARK CONFIGURATION MANAGER ═══${NC}"
    echo -e "Manage all ARK ecosystem configurations"
    echo ""
    
    echo -e "${ARK_SUCCESS}Configuration Options:${NC}"
    echo -e "  1) View current ARK settings"
    echo -e "  2) Edit device database"
    echo -e "  3) Manage ARK Fleet configuration"
    echo -e "  4) Configure repository sources"
    echo -e "  5) Backup configurations"
    echo -e "  6) Restore configurations"
    echo -e "  7) Reset to defaults"
    echo ""
    
    read -p "$(echo -e "${ARK_ACCENT}🜁 Select configuration option: ${NC}")" config_choice
    
    case $config_choice in
        1) view_ark_settings ;;
        2) edit_device_database ;;
        3) manage_ark_fleet ;;
        4) configure_repositories ;;
        5) backup_configurations ;;
        6) restore_configurations ;;
        7) reset_to_defaults ;;
        *) ark_print_enhanced "error" "Invalid configuration option" ;;
    esac
}

# View current ARK settings
view_ark_settings() {
    show_header "ARK SETTINGS" "Current Configuration"
    
    echo -e "${ARK_INFO}Current ARK Settings:${NC}"
    echo -e "  ARK Version: $ARK_VERSION"
    echo -e "  Commander: $ARK_COMMANDER"
    echo -e "  Ecosystem: $ARK_ECOSYSTEM_NAME"
    echo -e "  Primary Device: $ARK_PRIMARY_DEVICE ($ARK_PRIMARY_DEVICE_NAME)"
    echo -e "  Secondary Device: $ARK_SECONDARY_DEVICE ($ARK_SECONDARY_DEVICE_NAME)"
    echo -e "  Default Build Type: $ARK_DEFAULT_BUILD_TYPE"
    echo -e "  Build Jobs: $ARK_DEFAULT_JOBS"
    echo -e "  CCache Enabled: $ARK_CCACHE_ENABLED"
    echo -e "  CCache Size: $ARK_CCACHE_SIZE"
    echo ""
    echo -e "${ARK_ACCENT}Directory Configuration:${NC}"
    echo -e "  Builds: $ARK_BUILDS_DIR"
    echo -e "  Cache: $ARK_CACHE_DIR"
    echo -e "  Logs: $ARK_LOGS_DIR"
    echo -e "  Config: $ARK_CONFIG_DIR"
    echo -e "  Modules: $ARK_MODULES_DIR"
    echo ""
}

# Edit device database
edit_device_database() {
    ark_print_enhanced "info" "Opening device database for editing..."
    echo -e "${ARK_INFO}Device database location: $ARK_BASE_DIR/config/devices/ark-device-database.conf${NC}"
    
    if command -v nano >/dev/null 2>&1; then
        nano "$ARK_BASE_DIR/config/devices/ark-device-database.conf"
    elif command -v vim >/dev/null 2>&1; then
        vim "$ARK_BASE_DIR/config/devices/ark-device-database.conf"
    else
        ark_print_enhanced "warn" "No text editor found. Please edit manually:"
        echo "$ARK_BASE_DIR/config/devices/ark-device-database.conf"
    fi
}

# Manage ARK Fleet
manage_ark_fleet() {
    show_header "ARK FLEET MANAGER" "The ARK Fleet Configuration"
    
    echo -e "${ARK_SUCCESS}🛰️ THE ARK FLEET STATUS:${NC}"
    echo ""
    
    # Show primary unit
    echo -e "${ARK_ACCENT}PRIMARY UNIT:${NC}"
    echo -e "  📱 $ARK_PRIMARY_DEVICE_NAME ($ARK_PRIMARY_DEVICE)"
    echo -e "     Status: Active Development Unit"
    echo -e "     Role: Reference Implementation & Testing"
    echo ""
    
    # Show secondary unit
    echo -e "${ARK_INFO}SECONDARY UNIT:${NC}"
    echo -e "  📱 $ARK_SECONDARY_DEVICE_NAME ($ARK_SECONDARY_DEVICE)"
    echo -e "     Status: Awaiting Activation"
    echo -e "     Role: Universal Tool Validation"
    echo ""
    
    echo -e "${ARK_ACCENT}Fleet Management Options:${NC}"
    echo -e "  1) Edit fleet configuration"
    echo -e "  2) Add new fleet device"
    echo -e "  3) View detailed fleet status"
    echo -e "  4) Return to main menu"
    echo ""
    
    read -p "$(echo -e "${ARK_ACCENT}🜁 Select fleet option: ${NC}")" fleet_choice
    
    case $fleet_choice in
        1) edit_fleet_config ;;
        2) add_fleet_device ;;
        3) show_detailed_fleet_status ;;
        4) return ;;
    esac
}

# Edit fleet configuration
edit_fleet_config() {
    ark_print_enhanced "info" "Opening ARK Fleet configuration for editing..."
    
    if command -v nano >/dev/null 2>&1; then
        nano "$ARK_BASE_DIR/config/devices/ark-fleet.conf"
    else
        ark_print_enhanced "warn" "Please edit manually: $ARK_BASE_DIR/config/devices/ark-fleet.conf"
    fi
}

# Configure repositories
configure_repositories() {
    show_header "REPOSITORY MANAGER" "ROM Source Configuration"
    
    echo -e "${ARK_ACCENT}Available Repository Configurations:${NC}"
    echo ""
    
    # List available repo configs
    if [[ -d "$ARK_BASE_DIR/config/repositories" ]]; then
        for repo_file in "$ARK_BASE_DIR/config/repositories"/*.conf; do
            if [[ -f "$repo_file" ]]; then
                local repo_name=$(basename "$repo_file" .conf)
                echo -e "  📂 $repo_name"
            fi
        done
    fi
    
    echo ""
    echo -e "${ARK_ACCENT}Repository Options:${NC}"
    echo -e "  1) Edit YAAP configuration"
    echo -e "  2) Edit LineageOS configuration"
    echo -e "  3) Add custom repository"
    echo -e "  4) List all repositories"
    echo -e "  5) Return to main menu"
    echo ""
    
    read -p "$(echo -e "${ARK_ACCENT}🜁 Select repository option: ${NC}")" repo_choice
    
    case $repo_choice in
        1) edit_yaap_config ;;
        2) edit_lineage_config ;;
        3) add_custom_repository ;;
        4) list_all_repositories ;;
        5) return ;;
    esac
}

# Edit YAAP configuration
edit_yaap_config() {
    ark_print_enhanced "info" "Opening YAAP configuration for editing..."
    
    if command -v nano >/dev/null 2>&1; then
        nano "$ARK_BASE_DIR/config/repositories/yaap.conf"
    else
        ark_print_enhanced "warn" "Please edit manually: $ARK_BASE_DIR/config/repositories/yaap.conf"
    fi
}

# Backup configurations
backup_configurations() {
    local backup_dir="$HOME/ark-backups"
    local backup_date=$(date +%Y%m%d_%H%M%S)
    
    ark_print_enhanced "info" "Backing up ARK configurations..."
    
    mkdir -p "$backup_dir"
    
    # Backup config directory
    tar -czf "$backup_dir/ark_config_backup_$backup_date.tar.gz" -C "$ARK_BASE_DIR" config/
    
    ark_print_enhanced "success" "Backup completed: $backup_dir/ark_config_backup_$backup_date.tar.gz"
}

# Restore configurations
restore_configurations() {
    local backup_dir="$HOME/ark-backups"
    
    ark_print_enhanced "info" "Available ARK configuration backups:"
    
    if [[ -d "$backup_dir" ]]; then
        ls -la "$backup_dir"/ark_config_backup_*.tar.gz 2>/dev/null || \
            ark_print_enhanced "warn" "No backup files found in $backup_dir"
    else
        ark_print_enhanced "warn" "Backup directory not found: $backup_dir"
    fi
}

# Reset to defaults
reset_to_defaults() {
    ark_print_enhanced "warn" "Reset to defaults will recreate all configuration files"
    read -p "$(echo -e "${ARK_WARN}Are you sure? This will overwrite current configs (y/N): ${NC}")" confirm
    
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        ark_print_enhanced "info" "Resetting ARK configurations to defaults..."
        ark_print_enhanced "warn" "Reset functionality coming in next ARK update!"
    else
        ark_print_enhanced "info" "Reset cancelled"
    fi
}

# Additional helper functions
add_fleet_device() {
    ark_print_enhanced "info" "Add fleet device functionality coming in next ARK update!"
}

show_detailed_fleet_status() {
    ark_print_enhanced "info" "Detailed fleet status coming in next ARK update!"
}

edit_lineage_config() {
    if command -v nano >/dev/null 2>&1; then
        nano "$ARK_BASE_DIR/config/repositories/lineage.conf"
    else
        ark_print_enhanced "warn" "Please edit manually: $ARK_BASE_DIR/config/repositories/lineage.conf"
    fi
}

add_custom_repository() {
    ark_print_enhanced "info" "Add custom repository functionality coming in next ARK update!"
}

list_all_repositories() {
    ark_print_enhanced "info" "List repositories functionality coming in next ARK update!"
}

ark_print_enhanced "info" "ARK Configuration Manager module loaded successfully"
