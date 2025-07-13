#!/usr/bin/env bash
# ╭─────────────────────────────────────────────╮
# │      ARK DIRECTORY MANAGER (FIXED)          │
# │    Proper User Path Implementation          │
# │           Commander: koobie777              │
# ╰─────────────────────────────────────────────╯

source "$ARK_CONFIG_DIR/ark-settings.conf"

# Get actual system username
ARK_USERNAME=$(whoami)
ARK_BUILD_BASE="/home/${ARK_USERNAME}/android"

# Colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ark_create_build_directory() {
    local rom_name=$1
    local device=$2
    local build_dir="${ARK_BUILD_BASE}/${rom_name}-${device}"

    echo -e "${CYAN}🛰️ Creating build directory structure...${NC}"
    echo -e "Base: ${ARK_BUILD_BASE}"
    echo -e "Build: ${build_dir}"

    # Create base directory if it doesn't exist
    if [[ ! -d "$ARK_BUILD_BASE" ]]; then
        echo -e "${YELLOW}Creating base directory...${NC}"
        mkdir -p "$ARK_BUILD_BASE"
    fi

    # Create build directory
    if [[ ! -d "$build_dir" ]]; then
        echo -e "${GREEN}Creating ${rom_name}-${device} directory...${NC}"
        mkdir -p "$build_dir"
    else
        echo -e "${YELLOW}Directory already exists: ${build_dir}${NC}"
    fi

    echo "$build_dir"
}

ark_list_build_directories() {
    echo -e "${CYAN}📁 Current Build Directories:${NC}"

    if [[ -d "$ARK_BUILD_BASE" ]]; then
        echo -e "${GREEN}Base: $ARK_BUILD_BASE${NC}\n"

        for dir in "$ARK_BUILD_BASE"/*; do
            if [[ -d "$dir" ]]; then
                local dirname=$(basename "$dir")
                local size=$(du -sh "$dir" 2>/dev/null | cut -f1)
                echo -e "  ${YELLOW}$dirname${NC} (${size})"

                # Check for key indicators
                [[ -d "$dir/.repo" ]] && echo -e "    ✅ Repo initialized"
                [[ -d "$dir/out" ]] && echo -e "    📦 Has build output"
                [[ -f "$dir/out/build_in_progress" ]] && echo -e "    🔄 Build in progress"
            fi
        done
    else
        echo -e "${RED}No build directory found at $ARK_BUILD_BASE${NC}"
        echo -e "${YELLOW}Will be created on first build${NC}"
    fi
}

ark_clean_build_directory() {
    local dirs=($(find "$ARK_BUILD_BASE" -maxdepth 1 -type d -name "*-*" 2>/dev/null | sort))

    if [[ ${#dirs[@]} -eq 0 ]]; then
        echo -e "${YELLOW}No build directories found${NC}"
        return
    fi

    echo -e "${RED}⚠️  Select directory to clean:${NC}"
    select dir in "${dirs[@]}" "Cancel"; do
        case $dir in
            "Cancel")
                return
                ;;
            *)
                if [[ -n "$dir" ]]; then
                    echo -e "${RED}This will delete: $dir${NC}"
                    read -p "Are you sure? (yes/N): " confirm
                    if [[ "$confirm" == "yes" ]]; then
                        echo -e "${YELLOW}Cleaning $dir...${NC}"
                        rm -rf "$dir/out"
                        echo -e "${GREEN}✅ Clean complete${NC}"
                    fi
                    break
                fi
                ;;
        esac
    done
}

# Export for use in other modules
export ARK_USERNAME
export ARK_BUILD_BASE
