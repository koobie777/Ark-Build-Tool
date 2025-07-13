# 🛰️ ARKFORGE User Guide v1.0
## The ARK Ecosystem Android Development Module

<div align="center">

```
╭─────────────────────────────────────────────╮
│       🛰️ THE ARK ECOSYSTEM SUPREME         │
│        ARKFORGE User Guide v1.0             │
│          Commander: koobie777               │
│            2025-07-13                       │
╰─────────────────────────────────────────────╯
```

**Welcome to The ARK, Commander!**

</div>

## 📖 Table of Contents

1. [Introduction](#introduction)
2. [Getting Started](#getting-started)
3. [The ARK Philosophy](#the-ark-philosophy)
4. [Using ARKFORGE](#using-arkforge)
5. [Module Guide](#module-guide)
6. [tmux Mastery](#tmux-mastery)
7. [Building Your First ROM](#building-your-first-rom)
8. [Fleet Management](#fleet-management)
9. [Troubleshooting](#troubleshooting)
10. [Advanced Operations](#advanced-operations)

---

## 🌌 Introduction

Welcome to ARKFORGE, the Android development module of The ARK Ecosystem. This guide will help you navigate The ARK and master Android ROM building with our space-themed command center.

### What is The ARK Ecosystem?

The ARK Ecosystem is a comprehensive homelab management system consisting of:
- **ARKFORGE** - Android ROM/Recovery building (This module)
- **Orbital Command** - System monitoring and management (Coming Soon)
- Additional modules for complete homelab control

### Your Fleet Status
As Commander koobie777, your current ARK Fleet includes:
- 📱 **OnePlus 12 "waffle"** - Primary device
- 📱 **OnePlus 10 Pro "op515dl1"** - Secondary device

---

## 🚀 Getting Started

### First Launch

1. **Launch with tmux** (Recommended):
   ```bash
   cd ~/the-ark-ecosystem/ark-forge/
   ./arkforge-launcher
   ```
   This creates a persistent tmux session for your builds.

2. **Direct launch** (Without tmux):
   ```bash
   ./arkforge.sh
   ```

### The Main Menu

Upon launch, you'll see:
```
╭─────────────────────────────────────────────────────────────╮
│                🛰️  ARKFORGE ECOSYSTEM v1.1.4                │
│                Modular Build Command Center                 │
│  Commander: koobie777                     │
│  Status: Operational        Time: 2025-07-13 06:17:16 UTC │
╰─────────────────────────────────────────────────────────────╯
```

---

## 🛰️ The ARK Philosophy

### Core Principles

1. **Modular Design** - Each function is a self-contained module
2. **Persistent Operations** - Builds continue even if disconnected
3. **Space Theme** - Consistent ARK theming throughout
4. **Commander-Centric** - Built for your specific needs

### Directory Structure
```
the-ark-ecosystem/
└── ark-forge/
    ├── arkforge-launcher      # tmux session manager
    ├── arkforge.sh           # Main orchestrator
    ├── modules/              # All ARK modules
    ├── config/               # Configuration files
    └── docs/                 # Documentation
```

---

## 🎮 Using ARKFORGE

### Basic Navigation

- **Number Keys (0-13)**: Select menu options
- **Enter**: Confirm selections
- **Ctrl+C**: Cancel current operation (use carefully)

### Essential Operations

#### 1. Smart Build (Option 1)
The intelligent build system that:
- Detects connected devices via ADB
- Matches devices to your fleet
- Suggests compatible ROMs
- Automates the entire build process

#### 2. ROM Build (Option 3)
Direct ROM compilation:
```
Select: 3
Choose ROM: LineageOS, Evolution X, Pixel Experience
Enter device codename: waffle
Confirm build directory: /home/koobie777/android/lineageos-waffle
```

#### 3. Repo Sync Only (Option 6)
Sync repositories without building:
- Detects existing build directories
- Creates tmux windows for each sync
- Monitors sync progress

---

## 📚 Module Guide

### Active Modules

| Module | Function | Status |
|--------|----------|---------|
| Smart Build | Automated device → ROM → build | ✅ Active |
| ROM Build | Manual ROM compilation | ✅ Active |
| Boot/Recovery Images | Kernel image extraction | ✅ Active |
| Resume Build | Continue interrupted builds | ✅ Active |
| Repo Sync Only | Repository synchronization | ✅ Active |
| Repository Manager | Manage ROM sources | ✅ Active |
| Directory Manager | Build directory organization | ✅ Active |
| Configuration Manager | ARK settings | ✅ Active |
| Fleet Status | View ARK devices | ✅ Active |
| Tmux Manager | Session management | ✅ Active |

### Modules in Development

- **Recovery Build** - TWRP/OrangeFox builder
- **Device Manager** - Advanced fleet management
- **Cadet Mode** - Guided experience for newcomers

---

## 🖥️ tmux Mastery

### Why tmux?

tmux allows your builds to continue even if you disconnect from SSH or close your terminal.

### Essential tmux Commands

| Command | Action |
|---------|--------|
| `Ctrl-B, D` | Detach from session |
| `Ctrl-B, W` | List all windows |
| `Ctrl-B, [0-9]` | Switch to window number |
| `Ctrl-B, C` | Create new window |
| `Ctrl-B, N` | Next window |
| `Ctrl-B, P` | Previous window |

### ARK tmux Management

When launching builds, ARKFORGE creates dedicated windows:
- `build-lineageos-waffle` - ROM build window
- `sync-evolution-op515dl1` - Repo sync window
- `ark-main` - Main ARKFORGE interface

### Reattaching to Sessions
```bash
# Using arkforge-launcher
./arkforge-launcher
Select: 1 (Attach to existing session)

# Or directly with tmux
tmux attach -t arkforge
```

---

## 🔨 Building Your First ROM

### Step-by-Step Guide

1. **Launch ARKFORGE**:
   ```bash
   ./arkforge-launcher
   ```

2. **Select Smart Build** (Option 1)

3. **Connect Your Device**:
   - Enable USB debugging
   - Connect via USB
   - Authorize ADB on device

4. **Follow Prompts**:
   ```
   🔍 Detecting connected devices...
   ✅ Found: OnePlus 12 (waffle)
   
   Select ROM:
   1) LineageOS 21
   2) Evolution X
   3) Pixel Experience
   ```

5. **Monitor Build**:
   - Build starts in tmux window
   - Detach with `Ctrl-B, D`
   - Check progress anytime

### Build Times (Approximate)
- **First Build**: 2-4 hours
- **Subsequent Builds**: 30-60 minutes
- **Kernel Only**: 10-20 minutes

---

## 🚢 Fleet Management

### Your ARK Fleet

Current devices in your ecosystem:
```
Primary Device:   OnePlus 12 "waffle"
Secondary Device: OnePlus 10 Pro "op515dl1"
```

### Adding New Devices

1. Enable USB debugging on device
2. Connect to your build system
3. Run Smart Build to auto-detect
4. Device will be added to your fleet

### Managing Multiple Builds

ARKFORGE handles multiple simultaneous builds:
```
tmux windows:
[0] ark-main                    # Main interface
[1] build-lineageos-waffle      # Building for OnePlus 12
[2] sync-evolution-op515dl1     # Syncing for OnePlus 10 Pro
```

---

## 🔧 Troubleshooting

### Common Issues

#### "Module load failed"
```bash
# Fix permissions
chmod +x modules/*.sh
```

#### Build Stuck or Failed
```bash
# Attach to build window
tmux attach -t arkforge

# Check specific window
Ctrl-B, W (select build window)
```

#### Out of Space
```bash
# Check disk usage
df -h /home/koobie777/android/

# Clean build directory
cd /home/koobie777/android/lineageos-waffle
make clean
```

#### tmux Session Issues
```bash
# List all sessions
tmux ls

# Kill stuck session
tmux kill-session -t arkforge
```

### Getting Help

1. Check build logs in tmux window
2. Review `/home/koobie777/android/*/out/error.log`
3. Use Directory Manager to check paths
4. Ensure all dependencies are installed

---

## 🚀 Advanced Operations

### Custom Build Commands

For advanced users who need specific build options:

1. Use tmux Manager (Option 13)
2. Create new window
3. Navigate to build directory
4. Run custom commands

### Environment Variables
```bash
# Set in your build window
export USE_CCACHE=1
export CCACHE_DIR=/home/koobie777/.ccache
export JACK_SERVER_VM_ARGUMENTS="-Xmx8g"
```

### Parallel Builds

Manage multiple device builds:
```bash
# Window 1: OnePlus 12
cd /home/koobie777/android/lineageos-waffle
mka bacon

# Window 2: OnePlus 10 Pro
cd /home/koobie777/android/evolution-op515dl1
mka bacon
```

### Build Output Locations
```
ROM: out/target/product/<device>/*.zip
Recovery: out/target/product/<device>/recovery.img
Boot: out/target/product/<device>/boot.img
```

---

## 📝 Quick Reference Card

### Menu Options
```
1  - Smart Build          7  - Device Manager
2  - Recovery Build       8  - Repository Manager
3  - ROM Build           9  - Directory Manager
4  - Boot/Recovery       10 - Configuration
5  - Resume Build        11 - Fleet Status
6  - Repo Sync Only      12 - User Guide
0  - Exit                13 - Tmux Manager
```

### Key Paths
```
ARKFORGE: ~/the-ark-ecosystem/ark-forge/
Builds:   /home/koobie777/android/
Modules:  ~/the-ark-ecosystem/ark-forge/modules/
Config:   ~/the-ark-ecosystem/ark-forge/config/
```

### Emergency Commands
```bash
# Kill all builds
tmux kill-session -t arkforge

# Reset ARKFORGE
cd ~/the-ark-ecosystem/ark-forge/
git pull
chmod +x arkforge-launcher arkforge.sh modules/*.sh
```

---

## 🌟 Tips from The Commander

1. **Always use arkforge-launcher** for persistent builds
2. **Name your tmux windows** clearly for easy identification
3. **Check available space** before starting builds
4. **Keep multiple terminal tabs** open for monitoring
5. **Document your successful builds** for future reference

---

<div align="center">

**🛰️ Welcome to The ARK Ecosystem, Commander! 🛰️**

*May your builds be swift and your boots successful!*

**Time**: 2025-07-13 06:17:16 UTC  
**System**: arksupreme-mk1  
**Commander**: koobie777

</div>
