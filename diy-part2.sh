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

#删除后面重复插件
pushd feeds/liuran001_packages
rm -rf luci-app-koolproxyR
rm -rf luci-app-adguardhome
rm -rf luci-app-oaf
rm -rf luci-app-ssr-plus
rm -rf luci-app-passwall-plus
rm -rf luci-app-vssr-plus
rm -rf open-app-filter
rm -rf oaf
popd
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
