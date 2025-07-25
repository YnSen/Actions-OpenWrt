##lede
##get source
git clone https://github.com/coolsnowwolf/lede.git openwrt
cd ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt
./scripts/feeds update -a && ./scripts/feeds install -a

pushd package
#passwall
#git clone https://github.com/xiaorouji/openwrt-passwall.git
#lienol(管控)
git clone https://github.com/Lienol/openwrt-package.git
# KoolProxyR去广告插件
#git clone https://github.com/jefferymvp/luci-app-koolproxyR
# 微信推送插件
git clone https://github.com/tty228/luci-app-serverchan
# Add Pushbot-原钉钉推送插件
git clone https://github.com/zzsj0928/luci-app-pushbot
# 京东签到插件
#git clone https://github.com/jerrykuku/luci-app-jd-dailybonus 
# adguardhome插件


# Clash插件
#git clone https://github.com/frainzy1477/luci-app-clash
#openclash插件
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash
#ssrplus
git clone https://github.com/fw876/helloworld.git
# SmartDNS插件
#git clone https://github.com/pymumu/openwrt-smartdns
#git clone -b lede https://github.com/pymumu/luci-app-smartdns
#强制关机插件
#git clone https://github.com/esirplayground/luci-app-poweroff
#自动关机插件
#git clone https://github.com/sirpdboy/luci-app-autopoweroff
# Add Onliner
#git clone https://github.com/rufengsuixing/luci-app-onliner.git feeds/luci/applications/luci-app-onliner
#git clone https://github.com/rufengsuixing/luci-app-onliner.git
git clone https://github.com/ue365/luci-app-onliner-1
#腾讯ddns
git clone https://github.com/Tencent-Cloud-Plugins/tencentcloud-openwrt-plugin-ddns
#oaf
git clone https://github.com/destan19/OpenAppFilter.git
# Edge主题
git clone -b 18.06 https://github.com/garypang13/luci-theme-edge
#argon主题设置
git clone https://github.com/jerrykuku/luci-app-argon-config
#liuran001软件包
#git clone https://github.com/liuran001/openwrt-packages.git
popd

# AdGuardHome
git clone https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome
rm -rf feeds/packages/net/adguardhome
svn co https://github.com/openwrt/packages/trunk/net/adguardhome feeds/packages/net/adguardhome

#unblockneteasemusic
#git clone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git package/luci-app-unblockneteasemusic
#cp -r package/luci-app-unblockneteasemusic feeds/luci/applications/
#rm -rf feeds/luci/applications/package/luci-app-unblockmusic
#rm -rf package/feeds/luci/luci-app-unblockmusic
#rm -rf feeds/packages/multimedia/UnblockNeteaseMusic-Go
#rm -rf feeds/packages/multimedia/UnblockNeteaseMusic
#rm -rf package/feeds/packages/UnblockNeteaseMusic-Go
#rm -rf package/feeds/packages/UnblockNeteaseMusic
#pushd package/feeds/luci
#ln -sv ../../../feeds/luci/applications/luci-app-unblockneteasemusic ./
#popd

#删除后面重复插件
#pushd package/openwrt-packages
#rm -rf luci-app-koolproxyR
#rm -rf luci-app-ssr-plus
#rm -rf luci-app-jd-dailybonus
#rm -rf luci-app-adguardhome
#rm -rf luci-app-oaf
#rm -rf luci-lib-docker
#rm -rf luci-app-dockerman
#rm -rf luci-app-passwall-plus
#rm -rf luci-app-vssr-plus
#rm -rf open-app-filter
#rm -rf oaf
#popd
#删除管控中多余的可道云
pushd package/openwrt-package
rm -rf luci-app-kodexplorer
popd

# argon主题
pushd feeds/luci/themes
rm -rf luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon luci-theme-argon
popd

pushd package/tencentcloud-openwrt-plugin-ddns/tencentcloud_ddns/files/luci/controller
sed -i 's/"admin", "tencentcloud"/"admin", "services", "tencentcloud"/g' tencentddns.lua
popd

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.1/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
sed -i 's/bootstrap/argon/g' feeds/luci/collections/luci/Makefile
# Modify default PassWord
#sed -i 's/root::0:0:99999:7:::/root:$1$ScQIGKsX$q0qEf\/tAQ2wpTR6zIUIjo.:0:0:99999:7:::/g' package/base-files/files/etc/shadow
#删除默认密码
sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings

cd ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt
#cp -r ~/work/Actions-OpenWrt/Actions-OpenWrt/default-settings/files ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/
#cp ~/work/Actions-OpenWrt/Actions-OpenWrt/conf/wireless ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/
#cp ~/work/Actions-OpenWrt/Actions-OpenWrt/conf/leder3p.config ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/
#mv leder3p.config .config
#make defconfig
