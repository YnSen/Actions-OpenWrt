pushd package
#passwall
#git clone https://github.com/xiaorouji/openwrt-passwall.git
#lienol(管控)
git clone https://github.com/Lienol/openwrt-package.git
# KoolProxyR去广告插件
#git clone https://github.com/jefferymvp/luci-app-koolproxyR
# 微信推送插件
#git clone https://github.com/tty228/luci-app-serverchan
# Add Pushbot-原钉钉推送插件
#git clone https://github.com/zzsj0928/luci-app-pushbot
# 京东签到插件
#git clone https://github.com/jerrykuku/luci-app-jd-dailybonus 
# adguardhome插件
#git clone https://github.com/rufengsuixing/luci-app-adguardhome
# Clash插件
#git clone https://github.com/frainzy1477/luci-app-clash
#openclash插件
#git clone https://github.com/vernesong/OpenClash.git
#ssrplus
#git clone https://github.com/fw876/helloworld.git
# SmartDNS插件
#git clone https://github.com/pymumu/openwrt-smartdns
#git clone -b lede https://github.com/pymumu/luci-app-smartdns
#强制关机插件
git clone https://github.com/esirplayground/luci-app-poweroff
#自动关机插件
git clone https://github.com/sirpdboy/luci-app-autopoweroff
# Add Onliner
# git clone https://github.com/rufengsuixing/luci-app-onliner.git feeds/luci/applications/luci-app-onliner
#git clone https://github.com/rufengsuixing/luci-app-onliner.git
#腾讯ddns
git clone https://github.com/Tencent-Cloud-Plugins/tencentcloud-openwrt-plugin-ddns
#Docker lib api
git clone https://github.com/lisaac/luci-lib-docker
#Docker
git clone https://github.com/lisaac/luci-app-dockerman
#diskman
#git clone https://github.com/lisaac/luci-app-diskman.git

#kenzok8 
git clone -b 19.07 https://github.com/kenzok8/small-package.git
#git clone https://github.com/kenzok8/small.git

#pushd  small-package
#rm -rf xray-core
#rm -rf luci-theme-edge
#popd

#rclone 
git clone https://github.com/ElonH/Rclone-OpenWrt.git
# argon主题
#git clone https://github.com/jerrykuku/luci-theme-argon luci-theme-argon
#git clone https://github.com/jerrykuku/luci-app-argon-config.git
#vssr
#git clone https://github.com/jerrykuku/lua-maxminddb.git  #git lua-maxminddb 依赖
#git clone https://github.com/jerrykuku/luci-app-vssr.git
#zerotier
git clone https://github.com/rufengsuixing/luci-app-zerotier.git
#OpenAppFilter
#git clone https://github.com/destan19/OpenAppFilter.git
#unblockneteasemusic
#git clone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git


popd

pushd package/tencentcloud-openwrt-plugin-ddns/tencentcloud_ddns/files/luci/controller
sed -i 's/"admin", "tencentcloud"/"admin", "services", "tencentcloud"/g' tencentddns.lua
popd

# Modify default IP
sed -i 's/192.168.1.1/192.168.3.1/g' package/base-files/files/bin/config_generate
make defconfig
