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
sed -i -e '/^#/d' feeds.conf.default
# Add a feed source
#sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default

#liuruan001 pasckages18.06
#sed -i '$a src-git liuran001_packages https://github.com/liuran001/openwrt-packages' feeds.conf.default


#Lienol packages18.06
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default

#openwrt常用软件包不定期更新kenzo
#sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default

#PassWall依赖
sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default

#Passwall
sed -i '$a src-git openwrt_passwall https://github.com/xiaorouji/openwrt-passwall' feeds.conf.default


#hjp521openwrt常用软件包
#sed -i '$a src-git OpenWrt_hjp521 https://github.com/hjp521/OpenWrt-packages' feeds.conf.default


#sirpdboy
#sed -i '$a src-git sirpdboy_package https://github.com/sirpdboy/sirpdboy-package' feeds.conf.default

# Add ServerChan-DINGDING
git clone https://github.com/zzsj0928/luci-app-serverchand package/luci-app-serverchand

#Add 关机
git clone https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff

#自动关机
git clone https://github.com/sirpdboy/luci-app-autopoweroff package/luci-app-autopoweroff

#Add FileBrowser
#git clone https://github.com/mitsukileung/luci-app-filebrowser package/luci-app-filebrowser

# Add Onliner
# git clone https://github.com/rufengsuixing/luci-app-onliner.git feeds/luci/applications/luci-app-onliner
git clone https://github.com/rufengsuixing/luci-app-onliner.git package/luci-app-onliner

#腾讯ddns
git clone https://github.com/Tencent-Cloud-Plugins/tencentcloud-openwrt-plugin-ddns package/luci-app-tencentddns

#dnspod
#git clone https://github.com/ntlf9t/luci-app-dnspod package/luci-app-dnspod

#helloworld
git clone https://github.com/jerrykuku/luci-app-vssr package/luci-app-vssr

# sed -i '$a src-git luciappwrtbwmon https://github.com/brvphoenix/luci-app-wrtbwmon' feeds.conf.default
# sed -i '$a src-git wrtbwmon https://github.com/brvphoenix/wrtbwmon' feeds.conf.default
# sed -i '$a src-git smartdns https://github.com/pymumu/smartdns' feeds.conf.default
# sed -i '$a src-git luci-app-smartdns https://github.com/pymumu/luci-app-smartdns' feeds.conf.default
# sed -i '$a src-git onliner https://github.com/rufengsuixing/luci-app-onliner' feeds.conf.default
# sed -i '$a src-git luci-app-serverchan https://github.com/tty228/luci-app-serverchan' feeds.conf.default

# echo 'src-git helloworld https://github.com/fw876/helloworld' >> feeds.conf.default
# echo 'src-git luciappwrtbwmon https://github.com/brvphoenix/luci-app-wrtbwmon' >> feeds.conf.default
# echo 'src-git wrtbwmon https://github.com/brvphoenix/wrtbwmon' >> feeds.conf.default
# echo 'src-git smartdns https://github.com/pymumu/smartdns' >> feeds.conf.default
# echo 'src-git luciappsmartdns https://github.com/pymumu/luci-app-smartdns' >> feeds.conf.default
# echo 'src-git onliner https://github.com/rufengsuixing/luci-app-onliner' >> feeds.conf.default
# echo 'src-git luciappserverchan https://github.com/tty228/luci-app-serverchan' >> feeds.conf.default
