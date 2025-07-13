# ARKFORGE - Complete User Guide

## 🛰️ Welcome to ARKFORGE

**ARKFORGE (Android ROM Kompilation Forge)**  
*Commander koobie777's Advanced Android Build System for The ARK Ecosystem*

**Current Time**: 2025-07-13 04:15:27 UTC  
**Commander**: koobie777  
**Ecosystem**: The ARK  
**Status**: Operational  

---

## 🛰️ THE ARK FLEET

Commander koobie777’s personal device ecosystem—optimized, tested, and battle-ready.

### **Primary Unit – OnePlus 12 "waffle"**
```
Device: OnePlus 12
Codename: waffle
Chipset: SM8650 (Snapdragon 8 Gen 3)
Status: Active Development Unit
Role: Reference Implementation & Primary Testing
Proven ROM: YAAP
Proven Branches: fifteen-waffle, sixteen
Build Priority: 1
Recovery: TWRP (preferred)
```

### **Secondary Unit – OnePlus 10 Pro "op515dl1"**
```
Device: OnePlus 10 Pro
Codename: op515dl1
Chipset: SM8450 (Snapdragon 8 Gen 1)
Status: Awaiting Activation
Role: Universal Tool Validation
Build Priority: 2
Recovery: TWRP (preferred)
```

---

## 🚀 QUICK START GUIDE

### **Launch ARKFORGE**
```bash
# Navigate to ARK Forge directory
cd ark-forge

# Initialize ARKFORGE
./ark-forge-enhanced.sh
```

### **Smart Build (Recommended)**
1. Launch ARKFORGE: `./ark-forge-enhanced.sh`
2. Select **Option 1**: Smart Build
3. Enter device name: `OnePlus 12` or `OnePlus 10 Pro`
4. Select build type: Recovery or ROM
5. Let ARKFORGE handle device discovery, repository selection, and build execution

### **ARK Fleet Quick Build**
1. Launch ARKFORGE: `./ark-forge-enhanced.sh`
2. Select **Option 12**: Quick Fleet Build
3. Choose your ARK Fleet device:
   - OnePlus 12 "waffle" (YAAP proven)
   - OnePlus 10 Pro "op515dl1"
4. Optimized build execution for your fleet

---

## 🛠️ ARKFORGE MODULES

### **Device Discovery Module**
**Location**: `modules/ark-smart-device-discovery.sh`

**Features**:
- Intelligent device detection and disambiguation
- Auto-fills device specifications (chipset, processor, manufacturer)
- Handles device variants (OnePlus 12 vs OnePlus 12R precision)
- ARK Fleet device recognition and optimization
- Internet-based device discovery for unknown devices

**Usage**:
```bash
# Automatic via Smart Build
# OR manual module access via Device Manager (Option 4)
```

### **Repository Manager Module**
**Location**: `modules/ark-repo-manager-enhanced.sh`

**Features**:
- ROM source discovery and configuration
- Branch intelligence and recommendations
- Live repository reconnaissance
- Proven configurations for ARK Fleet devices
- YAAP, LineageOS, and custom ROM support

**Proven Configurations**:
- **YAAP for OnePlus 12 "waffle"**: fifteen-waffle branch (device-specific)
- **YAAP Alternative**: sixteen branch (latest Android 15)

### **Directory Manager Module**
**Location**: `modules/ark-directory-manager.sh`

**Features**:
- Build environment setup and management
- Cache and output directory organization
- Project structure creation
- Build artifact management

### **Build Engine Module**
**Location**: `modules/ark-build-engine.sh`

**Features**:
- Core compilation system
- Recovery build execution (TWRP, OrangeFox)
- ROM build execution (full Android compilation)
- Build environment preparation
- CCache integration (50GB default)
- Build status tracking and logging

### **Configuration Manager Module**
**Location**: `modules/ark-config-manager.sh`

**Features**:
- ARKFORGE settings management
- Device database editing
- ARK Fleet configuration
- Repository source configuration
- Backup and restore functionality
- Reset to defaults option

---

## ⚙️ ARKFORGE CONFIGURATION SYSTEM

### **Global Settings**
**Location**: `config/ark-settings.conf`

```bash
ARK_VERSION="3.0"
ARK_COMMANDER="koobie777"
ARK_ECOSYSTEM_NAME="The ARK"
ARK_PRIMARY_DEVICE="waffle"
ARK_PRIMARY_DEVICE_NAME="OnePlus 12"
ARK_SECONDARY_DEVICE="op515dl1"
ARK_SECONDARY_DEVICE_NAME="OnePlus 10 Pro"
ARK_DEFAULT_BUILD_TYPE="recovery"
ARK_CCACHE_ENABLED="true"
ARK_CCACHE_SIZE="50G"
```

### **ARK Fleet Configuration**
**Location**: `config/devices/ark-fleet.conf`

Contains detailed configurations for:
- Device specifications and capabilities
- Proven ROM sources and branches
- Build priorities and preferences
- Recovery preferences
- Last successful build tracking

### **Device Database**
**Location**: `config/devices/ark-device-database.conf`

Comprehensive device intelligence including:
- ARK Fleet devices (priority support)
- OnePlus family (extended support)
- Pixel family (universal support)
- Samsung Galaxy S series
- Search patterns for device discovery

### **Repository Configurations**
**Location**: `config/repositories/`

- `yaap.conf` - YAAP repository intelligence (proven for ARK Fleet)
- `lineage.conf` - LineageOS repository configuration
- `user-repos.conf` - Custom ROM sources (user-editable)

---

## 📱 SUPPORTED DEVICES

### **The ARK Fleet (Priority Support)**
✅ **OnePlus 12 "waffle"** – Primary Unit (Proven YAAP)  
✅ **OnePlus 10 Pro "op515dl1"** – Secondary Unit  

### **OnePlus Family (Extended Support)**
- OnePlus 12R "aston"
- OnePlus 11 "salami"
- OnePlus 10T "ovaltine"
- OnePlus 9 Pro "lemonadep"
- OnePlus 9 "lemonade"

### **Pixel Family (Universal Support)**
- Pixel 8 Pro "husky"
- Pixel 8 "shiba"
- Pixel 7 Pro "cheetah"

### **Samsung Galaxy S Series**
- Galaxy S24 Ultra "e3q"
- Galaxy S23 Ultra "dm3q"

### **Universal Android Device Support**
The ARK ecosystem supports any Android device through:
- Manual device entry
- Internet-based device discovery
- Community device configurations

---

## 📂 PROVEN ROM SOURCES

### **YAAP – Yet Another AOSP Project (ARK Fleet Proven)**
**Status**: Proven and tested for The ARK Fleet

**Branches**:
- `fifteen-waffle` – OnePlus 12 device-specific (RECOMMENDED for waffle)
- `sixteen` – Latest Android 15 development
- `fifteen` – Stable Android 14 release
- `fifteen-sm8650` – SM8650 chipset-specific

**Repository Structure**:
```
Manifest: https://github.com/yaap/manifest
Device Tree: https://github.com/yaap/device_oneplus_waffle
Kernel: https://github.com/yaap/kernel_oneplus_sm8650
Vendor: https://github.com/yaap/proprietary_vendor_oneplus_waffle
```

### **LineageOS (Alternative Configuration)**
**Status**: Alternative to YAAP

**Branches**:
- `lineage-21.0` – Android 14 (current stable)
- `lineage-20.0` – Android 13 (legacy stable)

---

## 🛠️ CUSTOMIZATION GUIDES

### **Adding New Devices**
1. **Via Device Manager**: Launch ARKFORGE → Option 4 → Add Device
2. **Manual Configuration**: Edit `config/devices/ark-device-database.conf`

**Format**:
```bash
[device_key]="Device Name|Codename|Chipset|Processor|Manufacturer|Category|Year|ARK_Status"
```

### **Adding New ROM Sources**
1. **Via Repository Manager**: Launch ARKFORGE → Option 5 → Add Repository
2. **Manual Configuration**: Create `config/repositories/[rom_name].conf`

### **ARK Fleet Management**
1. Launch ARKFORGE → Option 7 (Configuration Manager)
2. Select "Manage ARK Fleet configuration"
3. Edit fleet priorities, proven configurations, build preferences

---

## 🚀 BUILD WORKFLOWS

### **Recovery Build Workflow**
1. Launch ARKFORGE → Option 2 (Recovery Build)
2. Enter device codename (e.g., `waffle`, `op515dl1`)
3. Build execution with optimized settings
4. Output: Recovery image ready for flashing

### **ROM Build Workflow**
1. Launch ARKFORGE → Option 3 (ROM Build)
2. Enter device codename
3. Full ROM compilation with CCache acceleration
4. Output: Flashable ROM package

### **Smart Build Workflow (Recommended)**
1. Launch ARKFORGE → Option 1 (Smart Build)
2. Enter device name (human-readable)
3. Automatic device discovery and disambiguation
4. Repository selection based on device intelligence
5. Optimized build execution

---

## 📊 ARKFORGE ECOSYSTEM STRUCTURE

```
ark-forge/
├── ark-forge-enhanced.sh           # 🛠️ Main ARKFORGE orchestrator
├── modules/                        # 🧩 Modular components
│   ├── ark-smart-device-discovery.sh
│   ├── ark-repo-manager-enhanced.sh
│   ├── ark-directory-manager.sh
│   ├── ark-build-engine.sh
│   └── ark-config-manager.sh
├── config/                         # ⚙️ Configuration system
│   ├── ark-settings.conf           # Global settings
│   ├── devices/                    # Device configurations
│   │   ├── ark-device-database.conf
│   │   ├── ark-fleet.conf
│   │   └── user-devices.conf
│   └── repositories/               # ROM configurations
│       ├── yaap.conf               # YAAP (proven)
│       ├── lineage.conf            # LineageOS
│       └── user-repos.conf         # Custom
├── docs/                           # 📚 Documentation
├── scripts/                        # 🔧 Utility scripts
├── builds/                         # 🏗️ Build outputs
├── cache/                          # 💾 Build cache
└── logs/                           # 📝 Build logs
```

---

## 🛰️ ARKFORGE PHILOSOPHY

*"Efficient, modular, and intelligent Android building for the modern developer"*

### **Core Principles**
- **Intelligence**: Smart device discovery and repository selection
- **Modularity**: Each component works independently or as part of the ecosystem
- **Efficiency**: Optimized build processes with CCache and parallel execution
- **Customization**: Easy to modify, extend, and personalize
- **Proven Configurations**: Battle-tested setups for reliable builds

### **The ARK Fleet Advantage**
- **Proven Configurations**: YAAP fifteen-waffle branch tested and working
- **Optimized Workflows**: Streamlined processes for your specific devices
- **Priority Support**: ARK Fleet devices get enhanced features and optimizations
- **Continuous Evolution**: The ARK ecosystem grows with your needs

---

## 🆘 TROUBLESHOOTING

### **Common Issues**

**Module Not Found**
```bash
# Ensure modules are in correct location
ls -la modules/
```

**Configuration Issues**
```bash
# Reset configurations to defaults
./ark-forge-enhanced.sh → Option 7 → Reset to defaults
```

**Build Failures**
```bash
# Check build logs
cat logs/build-history.log
```

**Device Not Recognized**
```bash
# Use manual device input or add to database
# Edit: config/devices/user-devices.conf
```

---

## 📞 SUPPORT & RESOURCES

### **Documentation**
- **Device Customization**: `docs/device-customization.md`
- **Repository Customization**: `docs/repository-customization.md`

### **Configuration Backup**
```bash
# Backup ARKFORGE configurations
scripts/ark-backup.sh
```

### **ARKFORGE Updates**
```bash
# Check for ARK ecosystem updates
scripts/ark-update.sh
```

---

## 🛰️ ARKFORGE v3.0

**Commander**: koobie777  
**Time**: 2025-07-13 04:15:27 UTC  
**Status**: Operational and Ready  
**Fleet**: OnePlus 12 "waffle" + OnePlus 10 Pro "op515dl1"  

**ARKFORGE – Where efficiency meets intelligence in Android ROM building.**

**May The ARK be with you!** 🛰️

---

*End of ARKFORGE User Guide*