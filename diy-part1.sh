#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
#Lienol packages
sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
#PassWall依赖
#sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
#openwrt常用软件包不定期更新kenzo
#sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
#liuruan001 pasckages
sed -i '$a src-git liuran001_packages https://github.com/liuran001/openwrt-packages' feeds.conf.default
#Passwall
sed -i '$a src-git openwrt_passwall https://github.com/xiaorouji/openwrt-passwall' feeds.conf.default
#ssrplus
#sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default
# KoolProxyR去广告插件
git clone https://github.com/jefferymvp/luci-app-koolproxyR package/luci-app-koolproxyR
# 微信推送插件
#git clone https://github.com/tty228/luci-app-serverchan package/luci-app-serverchan
# Add ServerChan-DINGDING钉钉推送插件
git clone https://github.com/zzsj0928/luci-app-serverchand package/luci-app-serverchand
# 京东签到插件
#git clone https://github.com/jerrykuku/luci-app-jd-dailybonus package/luci-app-jd-dailybonus
# adguardhome插件
git clone https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome
# Clash插件
#git clone https://github.com/frainzy1477/luci-app-clash package/luci-app-clash

# SmartDNS插件
#git clone https://github.com/pymumu/openwrt-smartdns package/openwrt-smartdns
#git clone -b lede https://github.com/pymumu/luci-app-smartdns package/luci-app-smartdns
#强制关机插件
git clone https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
#自动关机插件
git clone https://github.com/sirpdboy/luci-app-autopoweroff package/luci-app-autopoweroff
# Add Onliner
# git clone https://github.com/rufengsuixing/luci-app-onliner.git feeds/luci/applications/luci-app-onliner
git clone https://github.com/rufengsuixing/luci-app-onliner.git package/luci-app-onliner
#腾讯ddns
git clone https://github.com/Tencent-Cloud-Plugins/tencentcloud-openwrt-plugin-ddns package/luci-app-tencentddns
#Docker lib api
git clone https://github.com/lisaac/luci-lib-docker package/luci-lib-docker
#Docker
git clone https://github.com/lisaac/luci-app-dockerman package/luci-app-dockerman
#oaf
git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter

# argon主题
pushd package/lean
rm -rf luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon luci-theme-argon
popd
# Edge主题
git clone -b 18.06 https://github.com/garypang13/luci-theme-edge package/luci-theme-edge
