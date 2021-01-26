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

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.1/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.3.1/g' package/base-files/files/bin/config_generate
sed -i 's/bootstrap/argon/g' feeds/luci/collections/luci/Makefile
# Modify default PassWord
#sed -i 's/root::0:0:99999:7:::/root:$1$ScQIGKsX$q0qEf\/tAQ2wpTR6zIUIjo.:0:0:99999:7:::/g' package/base-files/files/etc/shadow
#删除默认密码
sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings
