#!/usr/bin/env bash
# ╭─────────────────────────────────────────────╮
# │         ARK TMUX MANAGER MODULE             │
# │      Manage ARK Build Sessions              │
# │           Commander: koobie777              │
# ╰─────────────────────────────────────────────╯

source "$ARK_CONFIG_DIR/ark-settings.conf"

# Colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ark_tmux_menu() {
    clear
    echo -e "${CYAN}"
    echo "╭─────────────────────────────────────────────╮"
    echo "│         🖥️  ARK TMUX MANAGER               │"
    echo "│         Build Session Control               │"
    echo "╰─────────────────────────────────────────────╯"
    echo -e "${NC}"
    
    if tmux has-session -t arkforge 2>/dev/null; then
        echo -e "${GREEN}ARK Session Status: ACTIVE${NC}"
        echo -e "\n${YELLOW}Active Windows:${NC}"
        tmux list-windows -t arkforge -F "  [#I] #W - #T"
    else
        echo -e "${RED}ARK Session Status: NOT RUNNING${NC}"
    fi
    
    echo -e "\n${GREEN}Options:${NC}"
    echo "  1) Attach to ARK session"
    echo "  2) List all windows"
    echo "  3) Create new window"
    echo "  4) Kill specific window"
    echo "  5) Kill all build windows"
    echo "  0) Return to Main Menu"
    echo
    
    read -p "Select option: " choice
    
    case $choice in
        1) ark_tmux_attach ;;
        2) ark_tmux_list ;;
        3) ark_tmux_new_window ;;
        4) ark_tmux_kill_window ;;
        5) ark_tmux_kill_builds ;;
        0) return ;;
        *) echo -e "${RED}Invalid selection${NC}"; sleep 2; ark_tmux_menu ;;
    esac
}

ark_tmux_attach() {
    if tmux has-session -t arkforge 2>/dev/null; then
        echo -e "${GREEN}Attaching to ARK session...${NC}"
        echo -e "${YELLOW}Detach with: Ctrl-B, then D${NC}"
        sleep 2
        tmux attach -t arkforge
    else
        echo -e "${RED}No ARK session found${NC}"
        read -p "Create new session? (y/N): " create
        if [[ "$create" == "y" ]]; then
            tmux new-session -s arkforge -n "ark-main"
        fi
    fi
}

ark_tmux_list() {
    echo -e "${CYAN}📋 ARK Tmux Windows:${NC}\n"
    if tmux has-session -t arkforge 2>/dev/null; then
        tmux list-windows -t arkforge -F "[#I] #W (#T) - Created: #{t:window_activity}"
    else
        echo -e "${RED}No active session${NC}"
    fi
    read -p "Press Enter to continue..."
}

# Main
ark_tmux_menu
