#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.3.1/g' package/base-files/files/bin/config_generate
sed -i 's/bootstrap/argon/g' feeds/luci/collections/luci/Makefile

#Docker lib api
git clone https://github.com/lisaac/luci-lib-docker package/luci-lib-docker
 
#Docker
git clone https://github.com/lisaac/luci-app-dockerman package/luci-app-dockerman

#amule
#git clone https://github.com/garypang13/luci-app-amule package/luci-app-amule

#lucitheme Argon
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

#luci-app-argon-config
#git clone https://github.com/jerrykuku/luci-app-argon-config/tree/92d63919cace3f934f06513b6f530e9201d03c78 package/luci-app-argon-config