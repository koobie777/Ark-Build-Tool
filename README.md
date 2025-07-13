# 🛰️ The ARK Forge v1.1.0
**Enhanced Device Source Management & ARK Ecosystem Directory Structure**

[![ARK Ecosystem](https://img.shields.io/badge/ARK-Ecosystem-blue?style=for-the-badge&logo=android)](https://github.com/koobie777/Ark-Build-Tool)
[![Commander](https://img.shields.io/badge/Commander-koobie777-green?style=for-the-badge)](https://github.com/koobie777)
[![System](https://img.shields.io/badge/System-arksupreme--mk1-purple?style=for-the-badge)](.)

> **"May The ARK be with you!"** - The ultimate Android ROM/Recovery build toolkit for The ARK ecosystem

## 🌌 The ARK Ecosystem

The ARK is a comprehensive Android development ecosystem designed by Commander koobie777, running on the arksupreme-mk1 system. It provides automated, beginner-friendly yet expert-capable tools for building Android ROMs and recoveries across The ARK fleet of devices.

### 🚀 The ARK Fleet Devices
- **🍃 waffle** - OnePlus 12 (Primary ARK Unit - Active)
- **🔒 device2** - [CLASSIFIED] (Secondary ARK Unit - Standby)  
- **🔬 device3** - [REDACTED] (Experimental ARK Unit - Development)

## 📁 ARK Ecosystem Directory Structure

The ARK Forge automatically organizes your builds using a standardized directory structure:

```
~/android/                          # The ARK Base Directory
├── yaap-waffle/                    # YAAP ROM for OnePlus 12
├── lineageos-waffle/               # LineageOS ROM for OnePlus 12
├── twrp-waffle/                    # TWRP Recovery for OnePlus 12
├── orangefox-waffle/               # OrangeFox Recovery for OnePlus 12
├── builds/                         # Compiled outputs
│   ├── yaap-waffle/
│   ├── twrp-waffle/
│   └── ...
├── logs/                           # Build logs and debugging
│   ├── yaap-waffle/
│   └── ...
├── cache/                          # Build cache and downloads
└── manifests/                      # ROM manifest configurations
```

**Directory Naming Convention**: `{rom_type}-{device_codename}`

## ⚡ Features

### 🎯 Enhanced Device Management
- **ARK Fleet Integration** - Automatic device detection and configuration
- **Universal ROM Support** - LineageOS, YAAP, AOSP, and custom ROMs
- **Recovery Building** - TWRP, OrangeFox, and custom recoveries
- **Source Management** - Automatic repository discovery and cloning

### 🔧 Beginner + Expert Friendly
- **Guided Setup** - Step-by-step instructions for newcomers
- **Expert Mode** - Skip guidance for experienced developers
- **Error Recovery** - Helpful suggestions when builds fail
- **TMUX Integration** - Persistent session management

### 🛠️ Technical Features
- **Automatic Directory Creation** - No manual setup required
- **Metadata Tracking** - Build information and ecosystem status
- **Parallel Builds** - Efficient multi-core utilization
- **Clean Build Management** - Easy cleanup and maintenance

## 🚀 Quick Start

### Prerequisites
- Linux environment (Ubuntu 20.04+ recommended)
- 16GB+ RAM, 200GB+ storage
- Git, Python 3, and build tools

### Installation
```bash
# Clone The ARK Build Tool
git clone https://github.com/koobie777/Ark-Build-Tool.git
cd Ark-Build-Tool/ark-forge

# Make scripts executable
chmod +x *.sh

# Test ARK Directory Manager
./ark-directory-manager.sh
```

### Basic Usage
```bash
# Launch The ARK Forge
./ark-forge-v1.1.0.sh

# Select your ARK device (waffle, device2, device3)
# Choose ROM type (YAAP, LineageOS, AOSP, etc.)
# The ARK Forge handles the rest!
```

## 📱 Supported Configurations

### ROMs
- **YAAP** (Yet Another AOSP Project) - Primary for OnePlus 12
- **LineageOS** - Universal Android ROM
- **AOSP** (Android Open Source Project) - Stock Android
- **Custom ROMs** - User-defined configurations

### Recoveries
- **TWRP** (Team Win Recovery Project)
- **OrangeFox Recovery**
- **Custom Recoveries** - User-defined builds

### Devices
- **OnePlus 12 "Waffle"** - Full support with YAAP integration
- **[CLASSIFIED]** - Secondary ARK unit support
- **[REDACTED]** - Experimental ARK unit support
- **Custom Devices** - Expandable for any Android device

## 🗂️ ARK Ecosystem Components

### Core Tools
- **ARK Forge** - Main ROM/Recovery builder
- **ARK Directory Manager** - Ecosystem organization
- **Orbital Command** - Admin suite (coming soon)

### Directory Management
```bash
# Create new build environment
create_ark_directories "yaap" "waffle"

# Validate ARK ecosystem
validate_ark_structure

# List all ARK builds
list_ark_builds
```

### TMUX Integration
The ARK Forge automatically starts in a TMUX session for persistence:
```bash
# Auto-started session
tmux attach -t ark-forge-[timestamp]

# Manual session management
tmux new-session -s ark-custom
```

## 🔧 Configuration

### ARK Metadata
Each build environment includes ARK metadata:
```json
{
  "ark_ecosystem": {
    "commander": "koobie777",
    "system": "arksupreme-mk1",
    "created": "2025-07-13 02:52:01 UTC",
    "rom_type": "yaap",
    "device": "waffle",
    "version": "1.1.0"
  }
}
```

### Environment Variables
```bash
export ARK_BUILD_DIR="/home/koobie777/android/yaap-waffle"
export ARK_OUTPUT_DIR="/home/koobie777/android/builds/yaap-waffle"
export ARK_LOG_DIR="/home/koobie777/android/logs/yaap-waffle"
export ARK_CACHE_DIR="/home/koobie777/android/cache/yaap-waffle"
```

## 🎯 Roadmap

- [x] **v1.0.0** - Basic ROM/Recovery builder
- [x] **v1.1.0** - Enhanced directory management & ARK ecosystem
- [ ] **v1.2.0** - Device database and automatic source discovery
- [ ] **v1.3.0** - Orbital Command integration
- [ ] **v2.0.0** - Full ARK ecosystem with CI/CD

## 🤝 Contributing

The ARK ecosystem welcomes contributions! Please see our [contribution guidelines](CONTRIBUTING.md) and check out [Issue #4](https://github.com/koobie777/Ark-Build-Tool/issues/4) for the v1.1.0 enhancement roadmap.

### Development Setup
```bash
# Fork and clone
git clone https://github.com/yourusername/Ark-Build-Tool.git
cd Ark-Build-Tool

# Create feature branch
git checkout -b feature/your-enhancement

# Test your changes
./ark-forge/ark-directory-manager.sh
```

## 📊 ARK Ecosystem Status

```
╭──────────────────────────────────────╮
│  The ARK Fleet Status                │
│  System: arksupreme-mk1              │
│  Commander: koobie777                │
│  Status: 2025-07-13 02:52:01 UTC     │
╰──────────────────────────────────────╯

✅ OnePlus 12 (waffle): Active
⚠️ [CLASSIFIED] (device2): Standby  
⚠️ [REDACTED] (device3): Development
```

## 🛡️ License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **YAAP Developers** - OnePlus 12 device support
- **LineageOS Team** - Universal Android ROM framework
- **TWRP Team** - Recovery development tools
- **The ARK Community** - Testing and feedback

---

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/koobie777/Ark-Build-Tool/issues)
- **Discussions**: [GitHub Discussions](https://github.com/koobie777/Ark-Build-Tool/discussions)
- **Commander**: [@koobie777](https://github.com/koobie777)

---

**🜁 "May The ARK be with you!" - Commander koobie777**

*The ARK Forge v1.1.0 - Built for The ARK ecosystem on arksupreme-mk1*
