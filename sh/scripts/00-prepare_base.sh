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
#curl -s  https://$mirror/openwrt/patch/R4S/files/etc/board.d/01_leds > target/linux/rockchip/armv8/base-files/etc/board.d/01_leds
#curl -s  https://$mirror/openwrt/patch/R4S/files/etc/board.d/02_network > target/linux/rockchip/armv8/base-files/etc/board.d/02_network
#chmod 0755 target/linux/rockchip/armv8/base-files/etc/board.d/*

# 使用特定的优化 - 404
sed -i 's,-mcpu=generic,-mcpu=cortex-a72.cortex-a53+crypto,g' include/target.mk
curl -s  https://$mirror/openwrt/patch/mbedtls/100-Implements-AES-and-GCM-with-ARMv8-Crypto-Extensions.patch >./package/libs/mbedtls/patches/100-Implements-AES-and-GCM-with-ARMv8-Crypto-Extensions.patch
sed -i 's,kmod-r8169,kmod-r8168,g' target/linux/rockchip/image/armv8.mk

# R8168
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/kernel/r8168 package/new/r8168
git clone -b master --depth 1 https://github.com/BROBIRD/openwrt-r8168.git package/new/r8168
curl -s https://$mirror/openwrt/patch/r8168/r8168-fix_LAN_led-for_r4s-from_TL.patch | patch -p1

# ipv6-helper
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ipv6-helper package/lean/ipv6-helper

# fixes IPv6 packet drop when using software flow offload
curl -s https://$mirror/openwrt/patch/kernel/652-netfilter-flow_offload-add-check-ifindex.patch > target/linux/generic/hack-5.4/652-netfilter-flow_offload-add-check-ifindex.patch

#################################################################

# O3
sed -i 's/Os/O3 -funsafe-math-optimizations -funroll-loops -ffunction-sections -fdata-sections -Wl,--gc-sections/g' include/target.mk

# Enable Irqbalance
sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config

# config /etc..
svn co https://github.com/sbwml/default-settings/trunk/files ./files

# Patch arm64 model name
curl -s https://raw.githubusercontent.com/immortalwrt/immortalwrt/openwrt-21.02/target/linux/generic/hack-5.4/312-arm64-cpuinfo-Add-model-name-in-proc-cpuinfo-for-64bit-ta.patch > target/linux/generic/pending-5.4/312-arm64-cpuinfo-Add-model-name-in-proc-cpuinfo-for-64bit-ta.patch

# Patch jsonc
curl -s https://$mirror/openwrt/patch/jsonc/use_json_object_new_int64.patch | patch -p1

# Patch dnsmasq
curl -s https://$mirror/openwrt/patch/dnsmasq/dnsmasq-add-filter-aaaa-option.patch | patch -p1
curl -s https://$mirror/openwrt/patch/dnsmasq/luci-add-filter-aaaa-option.patch | patch -p1
curl -s https://$mirror/openwrt/patch/dnsmasq/900-add-filter-aaaa-option.patch > package/network/services/dnsmasq/patches/900-add-filter-aaaa-option.patch

# Patch Kernel - FullCone
curl -s https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/generic/hack-5.4/952-net-conntrack-events-support-multiple-registrant.patch > target/linux/generic/hack-5.4/952-net-conntrack-events-support-multiple-registrant.patch

# Patch FireWall - FullCone
mkdir package/network/config/firewall/patches
curl -s https://raw.githubusercontent.com/immortalwrt/immortalwrt/openwrt-21.02/package/network/config/firewall/patches/fullconenat.patch > package/network/config/firewall/patches/fullconenat.patch
# fuck firewall do some unlock
curl -s https://raw.githubusercontent.com/msylgj/R2S-R4S-OpenWrt/21.02/PATCHES/001-fix-firewall-flock.patch | patch -p1

# Patch LuCI 以增添 FullCone 开关
curl -s https://$mirror/openwrt/patch/firewall/luci-app-firewall_add_fullcone.patch | patch -p1

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

# IRQ - 404
sed -i '/set_interface_core 20 "eth1"/a\set_interface_core 8 "ff3c0000" "ff3c0000.i2c"' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity
sed -i '/set_interface_core 20 "eth1"/a\ethtool -C eth0 rx-usecs 1000 rx-frames 25 tx-usecs 100 tx-frames 25' target/linux/rockchip/armv8/base-files/etc/hotplug.d/net/40-net-smp-affinity

# 对齐内核 Vermagic - 404
curl -O -4 https://mirror.sjtu.edu.cn/openwrt/releases/21.02-SNAPSHOT/targets/rockchip/armv8/packages/Packages.gz
zgrep -m 1 "Depends: kernel (=.*)$" Packages.gz | sed -e 's/.*-\(.*\))/\1/' > .vermagic
sed -i -e 's/^\(.\).*vermagic$/\1cp $(TOPDIR)\/.vermagic $(LINUX_DIR)\/.vermagic/' include/kernel-defaults.mk
rm -f Packages.gz

# Max connection limite
sed -i 's/16384/65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

# profile -PS1
sed -i 's#\\u@\\h:\\w\\\$#\\[\\e[32;1m\\][\\u@\\h \\W]\\[\\e[0m\\]\\\$#g' package/base-files/files/etc/profile
