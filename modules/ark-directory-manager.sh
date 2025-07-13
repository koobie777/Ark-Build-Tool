#!/usr/bin/env bash
# THE ARK ECOSYSTEM SIMPLE REORGANIZER
# Commander: koobie777
# Time: 2025-01-13 04:00:08 UTC

# Colors
RED='\033[31m'
GREEN='\033[32m'
BLUE='\033[36m'
PURPLE='\033[35m'
NC='\033[0m'

echo -e "${PURPLE}"
echo "╭─────────────────────────────────────────╮"
echo "│      🛰️  THE ARK ECOSYSTEM SETUP      │"
echo "│         Commander: koobie777            │"
echo "│    Time: 2025-01-13 04:00:08 UTC       │"
echo "╰─────────────────────────────────────────╯"
echo -e "${NC}"
echo ""

echo -e "${BLUE}🛰️  Setting up The ARK ecosystem...${NC}"
echo ""

# Create directories
echo -e "${GREEN}Creating ARK directories...${NC}"
mkdir -p modules config config/devices config/repositories docs scripts builds cache logs
echo "✅ Directories created"

# Move existing files
echo -e "${GREEN}Moving existing files to modules...${NC}"
if [ -f "ark-smart-device-discovery.sh" ]; then
    mv ark-smart-device-discovery.sh modules/
    echo "✅ Moved ark-smart-device-discovery.sh"
fi

if [ -f "ark-repo-manager-enhanced-v2.sh" ]; then
    mv ark-repo-manager-enhanced-v2.sh modules/ark-repo-manager-enhanced.sh
    echo "✅ Moved ark-repo-manager-enhanced-v2.sh"
fi

if [ -f "ark-directory-manager.sh" ]; then
    mv ark-directory-manager.sh modules/
    echo "✅ Moved ark-directory-manager.sh"
fi

# Create ARK settings
echo -e "${GREEN}Creating ARK settings...${NC}"
cat > config/ark-settings.conf << 'ARKEOF'
# THE ARK ECOSYSTEM SETTINGS
ARK_VERSION="3.0"
ARK_COMMANDER="koobie777"
ARK_ECOSYSTEM_NAME="The ARK"
ARK_PRIMARY_DEVICE="waffle"
ARK_PRIMARY_DEVICE_NAME="OnePlus 12"
ARK_DEFAULT_BUILD_TYPE="recovery"
ARK_CCACHE_ENABLED="true"
ARK_DEFAULT_JOBS="8"
ARKEOF
echo "✅ Created ARK settings"

# Create ARK Fleet config
echo -e "${GREEN}Creating ARK Fleet configuration...${NC}"
cat > config/devices/ark-fleet.conf << 'ARKEOF'
# THE ARK FLEET - Commander koobie777's Devices

[waffle]
device_name="OnePlus 12"
codename="waffle"
chipset="SM8650"
processor="Snapdragon 8 Gen 3"
manufacturer="oneplus"
ark_status="PRIMARY_UNIT"
ark_role="Reference Implementation & Active Development"
proven_roms="YAAP"
proven_branches="fifteen-waffle,sixteen"

[op515dl1]
device_name="OnePlus 10 Pro"
codename="op515dl1"
chipset="SM8450"
processor="Snapdragon 8 Gen 1"
manufacturer="oneplus"
ark_status="SECONDARY_UNIT"
ark_role="Universal Tool Validation"
proven_roms=""
proven_branches=""
ARKEOF
echo "✅ Created ARK Fleet configuration"

# Create YAAP config
echo -e "${GREEN}Creating YAAP repository configuration...${NC}"
cat > config/repositories/yaap.conf << 'ARKEOF'
# YAAP Repository Configuration - PROVEN for The ARK

[yaap_main]
name="YAAP"
description="Yet Another AOSP Project"
manifest_url="https://github.com/yaap/manifest"
default_branch="sixteen"
status="PROVEN_ARK_CONFIG"

[yaap_branches]
sixteen="YAAP 16 (Android 15) - Latest development - HEAD"
fifteen="YAAP 15 (Android 14) - Stable release"
fifteen-waffle="YAAP 15 OnePlus 12 'waffle' - DEVICE SPECIFIC! 🎯"
fifteen-sm8650="YAAP 15 SM8650 chipset - CHIPSET SPECIFIC! 🧠"
fifteen-staging="YAAP 15 Staging - Testing branch"
fourteen="YAAP 14 (Android 13) - Legacy stable"

[yaap_waffle_repos]
manifest="https://github.com/yaap/manifest"
device_tree="https://github.com/yaap/device_oneplus_waffle"
device_common="https://github.com/yaap/device_oneplus_sm8650-common"
vendor_device="https://github.com/yaap/proprietary_vendor_oneplus_waffle"
vendor_common="https://github.com/yaap/proprietary_vendor_oneplus_sm8650-common"
hardware="https://github.com/yaap/hardware_oplus"
kernel="https://github.com/yaap/kernel_oneplus_sm8650"
ARKEOF
echo "✅ Created YAAP configuration"

# Create basic documentation
echo -e "${GREEN}Creating ARK documentation...${NC}"
cat > docs/README.md << 'ARKEOF'
# THE ARK ECOSYSTEM DOCUMENTATION

## 🛰️ The ARK Fleet
- **OnePlus 12 "waffle"** - Primary Unit (Proven YAAP configuration)
- **OnePlus 10 Pro "op515dl1"** - Secondary Unit (Universal validation)

## 🛠️ ARK Modules
- **Device Discovery**: `modules/ark-smart-device-discovery.sh`
- **Repository Manager**: `modules/ark-repo-manager-enhanced.sh`
- **Directory Manager**: `modules/ark-directory-manager.sh`

## ⚙️ Configuration Files
- **ARK Settings**: `config/ark-settings.conf`
- **ARK Fleet**: `config/devices/ark-fleet.conf`
- **YAAP Repos**: `config/repositories/yaap.conf`

## 🚀 Quick Start
```bash
./ark-forge-enhanced.sh
