#!/usr/bin/env bash
# ╭─────────────────────────────────────────────╮
# │      ARK BOOT/RECOVERY IMAGE BUILDER        │
# │         For Custom ROM Images               │
# │           Commander: koobie777              │
# ╰─────────────────────────────────────────────╯

source "$ARK_CONFIG_DIR/ark-settings.conf"

# Colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ark_boot_recovery_menu() {
    clear
    echo -e "${CYAN}"
    echo "╭─────────────────────────────────────────────╮"
    echo "│     🛰️  ARK BOOT/RECOVERY BUILDER          │"
    echo "│         Custom ROM Image Creation           │"
    echo "╰─────────────────────────────────────────────╯"
    echo -e "${NC}"

    echo -e "${GREEN}Available Operations:${NC}"
    echo "  1) Build Both (Boot + Recovery)"
    echo "  2) Build Boot Image Only"
    echo "  3) Build Recovery Image Only"
    echo "  4) Check Build Status"
    echo "  0) Return to Main Menu"
    echo

    read -p "Select operation: " choice

    case $choice in
        1) ark_build_both_images ;;
        2) ark_build_boot_image ;;
        3) ark_build_recovery_image ;;
        4) ark_check_build_status ;;
        0) return ;;
        *) echo -e "${RED}Invalid selection${NC}"; sleep 2; ark_boot_recovery_menu ;;
    esac
}

ark_detect_rom_directory() {
    local device=$1
    echo -e "${YELLOW}🔍 Detecting ROM directories for ${device}...${NC}"

    # Get actual username
    local username=$(whoami)
    local base_dir="/home/${username}/android"

    # Find directories matching pattern
    if [[ -d "$base_dir" ]]; then
        local rom_dirs=($(find "$base_dir" -maxdepth 1 -type d -name "*-${device}" 2>/dev/null | sort))

        if [[ ${#rom_dirs[@]} -eq 0 ]]; then
            echo -e "${RED}No ROM directories found for ${device}${NC}"
            return 1
        elif [[ ${#rom_dirs[@]} -eq 1 ]]; then
            echo "${rom_dirs[0]}"
            return 0
        else
            echo -e "${CYAN}Multiple ROM directories found:${NC}"
            select dir in "${rom_dirs[@]}"; do
                if [[ -n "$dir" ]]; then
                    echo "$dir"
                    return 0
                fi
            done
        fi
    else
        echo -e "${RED}Base directory $base_dir not found${NC}"
        return 1
    fi
}

ark_build_both_images() {
    echo -e "${CYAN}🛰️ Building Both Boot & Recovery Images${NC}"

    # Get device
    read -p "Enter device codename: " device

    # Detect ROM directory
    local rom_dir=$(ark_detect_rom_directory "$device")
    if [[ -z "$rom_dir" ]]; then
        echo -e "${RED}Failed to find ROM directory${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${GREEN}Using ROM directory: $rom_dir${NC}"
    cd "$rom_dir"

    # Build commands
    echo -e "${YELLOW}Starting build process...${NC}"

    # Set up environment
    source build/envsetup.sh
    lunch lineage_${device}-userdebug  # Adjust based on ROM

    # Build both
    echo -e "${CYAN}Building boot image...${NC}"
    mka bootimage

    echo -e "${CYAN}Building recovery image...${NC}"
    mka recoveryimage

    echo -e "${GREEN}✅ Build complete!${NC}"
    echo -e "Boot image: ${rom_dir}/out/target/product/${device}/boot.img"
    echo -e "Recovery image: ${rom_dir}/out/target/product/${device}/recovery.img"

    read -p "Press Enter to continue..."
}

ark_build_boot_image() {
    echo -e "${CYAN}🛰️ Building Boot Image Only${NC}"

    # Get device
    read -p "Enter device codename: " device

    # Detect ROM directory
    local rom_dir=$(ark_detect_rom_directory "$device")
    if [[ -z "$rom_dir" ]]; then
        echo -e "${RED}Failed to find ROM directory${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${GREEN}Using ROM directory: $rom_dir${NC}"
    cd "$rom_dir"

    # Build boot image
    source build/envsetup.sh
    lunch lineage_${device}-userdebug

    echo -e "${CYAN}Building boot image...${NC}"
    mka bootimage

    echo -e "${GREEN}✅ Boot image built!${NC}"
    echo -e "Location: ${rom_dir}/out/target/product/${device}/boot.img"

    read -p "Press Enter to continue..."
}

ark_build_recovery_image() {
    echo -e "${CYAN}🛰️ Building Recovery Image Only${NC}"

    # Get device
    read -p "Enter device codename: " device

    # Detect ROM directory
    local rom_dir=$(ark_detect_rom_directory "$device")
    if [[ -z "$rom_dir" ]]; then
        echo -e "${RED}Failed to find ROM directory${NC}"
        read -p "Press Enter to continue..."
        return
    fi

    echo -e "${GREEN}Using ROM directory: $rom_dir${NC}"
    cd "$rom_dir"

    # Build recovery image
    source build/envsetup.sh
    lunch lineage_${device}-userdebug

    echo -e "${CYAN}Building recovery image...${NC}"
    mka recoveryimage

    echo -e "${GREEN}✅ Recovery image built!${NC}"
    echo -e "Location: ${rom_dir}/out/target/product/${device}/recovery.img"

    read -p "Press Enter to continue..."
}

ark_check_build_status() {
    echo -e "${CYAN}🔍 Checking Build Status...${NC}"

    local username=$(whoami)
    local base_dir="/home/${username}/android"

    if [[ -d "$base_dir" ]]; then
        echo -e "${GREEN}Found build directories:${NC}"

        for dir in "$base_dir"/*; do
            if [[ -d "$dir" && -d "$dir/out" ]]; then
                local dirname=$(basename "$dir")
                echo -e "\n${YELLOW}📁 $dirname${NC}"

                # Check for images
                local device=$(echo "$dirname" | awk -F'-' '{print $NF}')
                local boot_img="$dir/out/target/product/$device/boot.img"
                local recovery_img="$dir/out/target/product/$device/recovery.img"

                if [[ -f "$boot_img" ]]; then
                    echo -e "  ✅ Boot image: $(date -r "$boot_img" '+%Y-%m-%d %H:%M')"
                else
                    echo -e "  ❌ Boot image: Not found"
                fi

                if [[ -f "$recovery_img" ]]; then
                    echo -e "  ✅ Recovery image: $(date -r "$recovery_img" '+%Y-%m-%d %H:%M')"
                else
                    echo -e "  ❌ Recovery image: Not found"
                fi
            fi
        done
    else
        echo -e "${RED}No build directory found at $base_dir${NC}"
    fi

    read -p "Press Enter to continue..."
}

# Main function
ark_boot_recovery_menu
