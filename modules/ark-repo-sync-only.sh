#!/usr/bin/env bash
# ╭─────────────────────────────────────────────╮
# │         ARK REPO SYNC ONLY MODULE           │
# │      Smart Repository Synchronization       │
# │           Commander: koobie777              │
# ╰─────────────────────────────────────────────╯

source "$ARK_CONFIG_DIR/ark-settings.conf"

# Colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
PURPLE='\033[0;35m'
NC='\033[0m'

ark_repo_sync_menu() {
    clear
    echo -e "${CYAN}"
    echo "╭─────────────────────────────────────────────╮"
    echo "│        🔄 ARK REPO SYNC CENTER              │"
    echo "│         Smart Repository Sync               │"
    echo "╰─────────────────────────────────────────────╯"
    echo -e "${NC}"
    
    echo -e "${GREEN}Sync Options:${NC}"
    echo "  1) Sync Existing Build Directory"
    echo "  2) Sync All Build Directories"
    echo "  3) Create New Sync (ROM + Device)"
    echo "  4) Check Sync Status"
    echo "  0) Return to Main Menu"
    echo
    
    read -p "Select option: " choice
    
    case $choice in
        1) ark_sync_existing ;;
        2) ark_sync_all ;;
        3) ark_sync_new ;;
        4) ark_check_sync_status ;;
        0) return ;;
        *) 
            ark_error_handler "Invalid selection"
            sleep 2
            ark_repo_sync_menu
            ;;
    esac
}

ark_sync_existing() {
    echo -e "${CYAN}🔍 Detecting existing build directories...${NC}"
    
    local username=$(whoami)
    local base_dir="/home/${username}/android"
    
    if [[ ! -d "$base_dir" ]]; then
        echo -e "${RED}No build directory found at $base_dir${NC}"
        read -p "Press Enter to continue..."
        return
    fi
    
    # Find all directories with .repo
    local repo_dirs=($(find "$base_dir" -maxdepth 2 -name ".repo" -type d 2>/dev/null | sed 's|/.repo||' | sort))
    
    if [[ ${#repo_dirs[@]} -eq 0 ]]; then
        echo -e "${YELLOW}No repositories found to sync${NC}"
        read -p "Press Enter to continue..."
        return
    fi
    
    echo -e "${GREEN}Found repositories:${NC}"
    select dir in "${repo_dirs[@]}" "Cancel"; do
        case $dir in
            "Cancel")
                return
                ;;
            *)
                if [[ -n "$dir" ]]; then
                    ark_sync_repository "$dir"
                    break
                fi
                ;;
        esac
    done
}

ark_sync_repository() {
    local repo_dir="$1"
    local dirname=$(basename "$repo_dir")
    
    echo -e "${CYAN}🔄 Syncing: $dirname${NC}"
    echo -e "Path: $repo_dir"
    
    # Create tmux window for sync
    local window_name="sync-${dirname}"
    
    if tmux has-session -t "arkforge" 2>/dev/null; then
        tmux new-window -t "arkforge" -n "$window_name"
    else
        tmux new-session -d -s "arkforge" -n "$window_name"
    fi
    
    # Sync commands
    local sync_cmd="cd $repo_dir && echo '🛰️ Starting repo sync for $dirname' && repo sync -j\$(nproc --all) --current-branch --no-clone-bundle"
    
    # Send to tmux
    tmux send-keys -t "arkforge:$window_name" "$sync_cmd" C-m
    
    echo -e "${GREEN}✅ Sync started in tmux window: $window_name${NC}"
    echo -e "${YELLOW}Attach with: tmux attach -t arkforge${NC}"
    echo -e "${YELLOW}Switch to window: Ctrl-B, then select window${NC}"
    
    read -p "Press Enter to continue..."
}

ark_sync_all() {
    echo -e "${CYAN}🔄 Syncing ALL repositories...${NC}"
    
    local username=$(whoami)
    local base_dir="/home/${username}/android"
    local repo_dirs=($(find "$base_dir" -maxdepth 2 -name ".repo" -type d 2>/dev/null | sed 's|/.repo||' | sort))
    
    if [[ ${#repo_dirs[@]} -eq 0 ]]; then
        echo -e "${YELLOW}No repositories found${NC}"
        read -p "Press Enter to continue..."
        return
    fi
    
    echo -e "${YELLOW}Found ${#repo_dirs[@]} repositories${NC}"
    read -p "Sync all? (y/N): " confirm
    
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
        for dir in "${repo_dirs[@]}"; do
            local dirname=$(basename "$dir")
            echo -e "${GREEN}Starting sync: $dirname${NC}"
            
            # Create tmux window
            tmux new-window -t "arkforge" -n "sync-${dirname}" 2>/dev/null
            tmux send-keys -t "arkforge:sync-${dirname}" "cd $dir && repo sync -j\$(nproc --all) --current-branch" C-m
        done
        
        echo -e "${GREEN}✅ All syncs started!${NC}"
        echo -e "${YELLOW}Monitor with: tmux attach -t arkforge${NC}"
    fi
    
    read -p "Press Enter to continue..."
}

ark_check_sync_status() {
    echo -e "${CYAN}📊 ARK Repository Status${NC}"
    
    local username=$(whoami)
    local base_dir="/home/${username}/android"
    
    if [[ -d "$base_dir" ]]; then
        for dir in "$base_dir"/*; do
            if [[ -d "$dir/.repo" ]]; then
                local dirname=$(basename "$dir")
                echo -e "\n${YELLOW}📁 $dirname${NC}"
                
                # Check last sync time
                if [[ -f "$dir/.repo/repo/main.py" ]]; then
                    local last_mod=$(stat -c %Y "$dir/.repo/manifests/.git/FETCH_HEAD" 2>/dev/null || echo 0)
                    if [[ $last_mod -gt 0 ]]; then
                        local last_sync=$(date -d "@$last_mod" '+%Y-%m-%d %H:%M')
                        echo -e "  Last sync: $last_sync"
                    fi
                fi
                
                # Check if sync in progress
                if pgrep -f "repo sync.*$dirname" > /dev/null; then
                    echo -e "  Status: ${GREEN}🔄 Syncing...${NC}"
                else
                    echo -e "  Status: ${CYAN}Idle${NC}"
                fi
            fi
        done
    else
        echo -e "${RED}No build directory found${NC}"
    fi
    
    read -p "Press Enter to continue..."
}

# Main
ark_repo_sync_menu
