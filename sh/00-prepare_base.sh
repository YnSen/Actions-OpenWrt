#!/bin/bash

#################################################################

# Rockchip - immortalwrt uboot & target upstream
rm -rf ./target/linux/rockchip
rm -rf ./package/boot/uboot-rockchip
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/target/linux/rockchip target/linux/rockchip
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/boot/uboot-rockchip package/boot/uboot-rockchip
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/boot/arm-trusted-firmware-rockchip-vendor package/boot/arm-trusted-firmware-rockchip-vendor
rm -f package/kernel/linux/modules/video.mk
curl -sL https://github.com/immortalwrt/immortalwrt/raw/openwrt-21.02/package/kernel/linux/modules/video.mk > package/kernel/linux/modules/video.mk

# R4S LED & Network
curl -s  https://$mirror/openwrt/patch/R4S/files/etc/board.d/01_leds > target/linux/rockchip/armv8/base-files/etc/board.d/01_leds
curl -s  https://$mirror/openwrt/patch/R4S/files/etc/board.d/02_network > target/linux/rockchip/armv8/base-files/etc/board.d/02_network
chmod 0755 target/linux/rockchip/armv8/base-files/etc/board.d/*

# R8168
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/kernel/r8168 package/new/r8168

# ipv6-helper
# svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ipv6-helper package/lean/ipv6-helper

# freq 2.2/1.8 GHz
rm -rf ./target/linux/rockchip/patches-5.4/992-rockchip-rk3399-overclock-to-2.2-1.8-GHz-for-NanoPi4.patch
curl -s  https://$mirror/openwrt/patch/new/main/991-rockchip-rk3399-overclock-to-2.2-1.8-GHz-for-NanoPi4.patch >./target/linux/rockchip/patches-5.4/991-rockchip-rk3399-overclock-to-2.2-1.8-GHz-for-NanoPi4.patch
curl -s  https://$mirror/openwrt/patch/new/main/213-RK3399-set-critical-CPU-temperature-for-thermal-throttling.patch >./target/linux/rockchip/patches-5.4/213-RK3399-set-critical-CPU-temperature-for-thermal-throttling.patch

#################################################################

# O3
sed -i 's/Os/O3/g' include/target.mk

# Enable Irqbalance
sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config

# config /etc..
svn co https://github.com/sbwml/default-settings/trunk/files ./files

# Patch arm64 model name
curl -s https://raw.githubusercontent.com/immortalwrt/immortalwrt/openwrt-21.02/target/linux/generic/hack-5.4/312-arm64-cpuinfo-Add-model-name-in-proc-cpuinfo-for-64bit-ta.patch > target/linux/generic/pending-5.4/312-arm64-cpuinfo-Add-model-name-in-proc-cpuinfo-for-64bit-ta.patch

# Patch jsonc
curl -s https://$mirror/openwrt/patch/new/package/use_json_object_new_int64.patch | patch -p1

# Patch dnsmasq
curl -s https://$mirror/openwrt/patch/new/package/dnsmasq-add-filter-aaaa-option.patch | patch -p1
curl -s https://$mirror/openwrt/patch/new/package/luci-add-filter-aaaa-option.patch | patch -p1
curl -s https://$mirror/openwrt/patch/new/package/900-add-filter-aaaa-option.patch > package/network/services/dnsmasq/patches/900-add-filter-aaaa-option.patch

# Patch Kernel - FullCone
curl -s https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/generic/hack-5.4/952-net-conntrack-events-support-multiple-registrant.patch > target/linux/generic/hack-5.4/952-net-conntrack-events-support-multiple-registrant.patch

# Patch FireWall - FullCone
mkdir package/network/config/firewall/patches
curl -s https://raw.githubusercontent.com/immortalwrt/immortalwrt/openwrt-21.02/package/network/config/firewall/patches/fullconenat.patch > package/network/config/firewall/patches/fullconenat.patch

# Patch LuCI 以增添 FullCone 开关
curl -s https://$mirror/openwrt/patch/new/package/luci-app-firewall_add_fullcone.patch | patch -p1

# FullCone 相关组件
svn co https://github.com/Lienol/openwrt/trunk/package/network/fullconenat package/network/fullconenat

# SQM Translation
mkdir -p feeds/packages/net/sqm-scripts/patches
curl -s https://$mirror/openwrt/patch/sqm/001-help-translation.patch > feeds/packages/net/sqm-scripts/patches/001-help-translation.patch

# 控制网速
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-eqos package/new/luci-app-eqos

# BBRv2
curl -s https://$mirror/openwrt/patch/BBRv2/openwrt-kmod-bbr2.patch | patch -p1
curl -s https://$mirror/openwrt/patch/BBRv2/693-Add_BBRv2_congestion_control_for_Linux_TCP.patch > target/linux/generic/hack-5.4/693-Add_BBRv2_congestion_control_for_Linux_TCP.patch
curl -s https://$mirror/openwrt/patch/BBRv2/cfaf039.patch | patch -p1

# Docker
pushd feeds/luci
curl -s https://$mirror/openwrt/patch/dockerman.diff > dockerman.diff
git apply dockerman.diff
popd
sed -i 's/+docker/+docker \\\n\t+dockerd/g' feeds/luci/applications/luci-app-dockerman/Makefile
sed -i '/sysctl.d/d' feeds/packages/utils/dockerd/Makefile

# 使用特定的优化 - 404
sed -i 's,-mcpu=generic,-mcpu=cortex-a72.cortex-a53+crypto,g' include/target.mk
curl -s  https://$mirror/openwrt/patch/new/main/100-Implements-AES-and-GCM-with-ARMv8-Crypto-Extensions.patch >./package/libs/mbedtls/patches/100-Implements-AES-and-GCM-with-ARMv8-Crypto-Extensions.patch
sed -i 's,kmod-r8169,kmod-r8168,g' target/linux/rockchip/image/armv8.mk

# 测试性功能 - 404
sed -i '/CRYPTO_DEV_ROCKCHIP/d' target/linux/rockchip/armv8/config-5.4
sed -i '/HW_RANDOM_ROCKCHIP/d' target/linux/rockchip/armv8/config-5.4
echo '
CONFIG_CRYPTO_DEV_ROCKCHIP=y
CONFIG_HW_RANDOM_ROCKCHIP=y
' >> ./target/linux/rockchip/armv8/config-5.4

# IRQ - 404
sed -i '/set_interface_core 20 "eth1"/a\set_interface_core 8 "ff3c0000" "ff3c0000.i2c"' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity
sed -i '/set_interface_core 20 "eth1"/a\ethtool -C eth0 rx-usecs 1000 rx-frames 25 tx-usecs 100 tx-frames 25' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity

# crypto modules - 404
cat >> ./target/linux/rockchip/armv8/config-5.4 <<EOF
CONFIG_ARM64_CRYPTO=y
CONFIG_CRYPTO_SHA256_ARM64=y
CONFIG_CRYPTO_SHA512_ARM64=y
CONFIG_CRYPTO_SHA1_ARM64_CE=y
CONFIG_CRYPTO_SHA2_ARM64_CE=y
# CONFIG_CRYPTO_SHA512_ARM64_CE is not set
CONFIG_CRYPTO_SHA3_ARM64=y
CONFIG_CRYPTO_SM3_ARM64_CE=y
CONFIG_CRYPTO_SM4_ARM64_CE=y
CONFIG_CRYPTO_GHASH_ARM64_CE=y
# CONFIG_CRYPTO_CRCT10DIF_ARM64_CE is not set
CONFIG_CRYPTO_AES_ARM64=y
CONFIG_CRYPTO_AES_ARM64_CE=y
CONFIG_CRYPTO_AES_ARM64_CE_CCM=y
CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
CONFIG_CRYPTO_AES_ARM64_NEON_BLK=y
CONFIG_CRYPTO_CHACHA20_NEON=y
CONFIG_CRYPTO_POLY1305_NEON=y
CONFIG_CRYPTO_NHPOLY1305_NEON=y
CONFIG_CRYPTO_AES_ARM64_BS=y
EOF

# 对齐内核 Vermagic - 404
# https://downloads.openwrt.org/releases/21.02-SNAPSHOT/targets/rockchip/armv8/packages/Packages.gz
curl -O -4 https://mirror.sjtu.edu.cn/openwrt/releases/21.02-SNAPSHOT/targets/rockchip/armv8/packages/Packages.gz
zgrep -m 1 "Depends: kernel (=.*)$" Packages.gz | sed -e 's/.*-\(.*\))/\1/' > .vermagic
sed -i -e 's/^\(.\).*vermagic$/\1cp $(TOPDIR)\/.vermagic $(LINUX_DIR)\/.vermagic/' include/kernel-defaults.mk
rm -f Packages.gz

# Max connection limite
sed -i 's/16384/65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

# profile -PS1
sed -i 's#\\u@\\h:\\w\\\$#\\[\\e[32;1m\\][\\u@\\h \\W]\\[\\e[0m\\]\\\$#g' package/base-files/files/etc/profile

# remove annoying snapshot tag
#sed -i 's,-SNAPSHOT,,g' include/version.mk
#sed -i 's,-SNAPSHOT,,g' package/base-files/image-config.in
