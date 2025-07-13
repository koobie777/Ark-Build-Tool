#!/usr/bin/env bash
# ╭─────────────────────────────────────────────╮
# │         ARK RESUME BUILD MODULE             │
# │      Intelligent Build Continuation         │
# │           Commander: koobie777              │
# ╰─────────────────────────────────────────────╯

source "$ARK_CONFIG_DIR/ark-settings.conf"

# Colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ark_detect_incomplete_builds() {
    local username=$(whoami)
    local base_dir="/home/${username}/android"
    local incomplete_builds=()

    if [[ -d "$base_dir" ]]; then
        for dir in "$base_dir"/*; do
            if [[ -d "$dir" && -d "$dir/.repo" ]]; then
                # Check if build was interrupted
                if [[ -f "$dir/out/build_in_progress" ]] || \
                   [[ -d "$dir/out" && ! -f "$dir/out/target/product/*/system.img" ]]; then
                    incomplete_builds+=("$dir")
                fi
            fi
        done
    fi

    printf '%s\n' "${incomplete_builds[@]}"
}

ark_analyze_build_state() {
    local build_dir=$1
    local build_info=""

    # Extract ROM and device from directory name
    local dirname=$(basename "$build_dir")
    local rom_name=$(echo "$dirname" | cut -d'-' -f1)
    local device=$(echo "$dirname" | cut -d'-' -f2)

    build_info+="ROM: $rom_name\n"
    build_info+="Device: $device\n"

    # Check build progress
    if [[ -f "$build_dir/out/build-${device}.ninja" ]]; then
        local ninja_log="$build_dir/out/.ninja_log"
        if [[ -f "$ninja_log" ]]; then
            local total_targets=$(grep -c "^[0-9]" "$ninja_log" 2>/dev/null || echo "0")
            build_info+="Progress: ~${total_targets} targets completed\n"
        fi
    fi

    # Check last build time
    if [[ -d "$build_dir/out" ]]; then
        local last_modified=$(find "$build_dir/out" -type f -printf '%T@\n' 2>/dev/null | sort -n | tail -1)
        if [[ -n "$last_modified" ]]; then
            local last_time=$(date -d "@${last_modified%.*}" '+%Y-%m-%d %H:%M')
            build_info+="Last activity: $last_time\n"
        fi
    fi

    echo -e "$build_info"
}

ark_resume_build_menu() {
    clear
    echo -e "${CYAN}"
    echo "╭─────────────────────────────────────────────╮"
    echo "│        🔄 ARK RESUME BUILD CENTER           │"
    echo "│      Continue Interrupted Builds            │"
    echo "╰─────────────────────────────────────────────╯"
    echo -e "${NC}"

    # Detect incomplete builds
    local incomplete_builds=($(ark_detect_incomplete_builds))

    if [[ ${#incomplete_builds[@]} -eq 0 ]]; then
        echo -e "${YELLOW}No incomplete builds detected.${NC}"
        read -p "Press Enter to return..."
        return
    fi

    echo -e "${GREEN}Detected incomplete builds:${NC}\n"

    local i=1
    for build in "${incomplete_builds[@]}"; do
        echo -e "${YELLOW}[$i] $(basename "$build")${NC}"
        ark_analyze_build_state "$build" | sed 's/^/    /'
        echo
        ((i++))
    done

    echo "  0) Return to Main Menu"
    echo

    read -p "Select build to resume: " choice

    if [[ $choice -eq 0 ]]; then
        return
    elif [[ $choice -gt 0 && $choice -le ${#incomplete_builds[@]} ]]; then
        ark_resume_selected_build "${incomplete_builds[$((choice-1))]}"
    else
        echo -e "${RED}Invalid selection${NC}"
        sleep 2
        ark_resume_build_menu
    fi
}

ark_resume_selected_build() {
    local build_dir=$1
    local dirname=$(basename "$build_dir")
    local device=$(echo "$dirname" | cut -d'-' -f2)

    echo -e "${CYAN}🔄 Resuming build in: $build_dir${NC}"

    # Enter tmux session or create one
    if tmux has-session -t arkforge 2>/dev/null; then
        tmux send-keys -t arkforge:0 C-c
        sleep 1
    else
        tmux new-session -d -s arkforge
    fi

    # Resume build commands
    local resume_commands="
cd $build_dir
source build/envsetup.sh
lunch lineage_${device}-userdebug
# Mark as in progress
touch out/build_in_progress
# Resume the build
m -j\$(nproc --all)
# Remove progress marker on completion
rm -f out/build_in_progress
"

    # Send commands to tmux
    tmux send-keys -t arkforge:0 "$resume_commands" Enter

    echo -e "${GREEN}✅ Build resumed in tmux session 'arkforge'${NC}"
    echo -e "${YELLOW}Attach with: tmux attach -t arkforge${NC}"

    read -p "Press Enter to continue..."
}

# Main function
ark_resume_build_menu
