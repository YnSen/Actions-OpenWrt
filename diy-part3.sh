  
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
#Lienol packages
sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
#PassWall依赖
#sed -i '$a src-git small https://github.com/kenzok8/small' feeds.conf.default
#openwrt常用软件包不定期更新kenzo
#sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
#liuruan001 pasckages
#sed -i '$a src-git liuran001_packages https://github.com/liuran001/openwrt-packages' feeds.conf.default
#Passwall
sed -i '$a src-git openwrt_passwall https://github.com/xiaorouji/openwrt-passwall' feeds.conf.default
#ssrplus
#sed -i '$a src-git helloworld https://github.com/fw876/helloworld' feeds.conf.default
