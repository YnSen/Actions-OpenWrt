##lede
##get source
git clone https://github.com/coolsnowwolf/lede.git openwrt
cd ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt
./scripts/feeds update -a && ./scripts/feeds install -a

#get myfiles
svn export https://github.com/YnSen/Actions-OpenWrt/trunk/default-settings/files ./files

pushd package
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

# Clash插件
#git clone https://github.com/frainzy1477/luci-app-clash
#openclash插件
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash

# SmartDNS插件
#git clone https://github.com/pymumu/openwrt-smartdns
#git clone -b lede https://github.com/pymumu/luci-app-smartdns
#强制关机插件
git clone https://github.com/esirplayground/luci-app-poweroff
#自动关机插件
git clone https://github.com/sirpdboy/luci-app-autopoweroff
# Add Onliner
# git clone https://github.com/rufengsuixing/luci-app-onliner.git feeds/luci/applications/luci-app-onliner
git clone https://github.com/rufengsuixing/luci-app-onliner.git

# ShadowsocksR Plus+
git clone https://github.com/fw876/helloworld.git

#Docker lib api
#git clone https://github.com/lisaac/luci-lib-docker
#Docker
#git clone https://github.com/lisaac/luci-app-dockerman
# 应用过滤
git clone https://github.com/sbwml/OpenAppFilter
# Edge主题
git clone -b 18.06 https://github.com/garypang13/luci-theme-edge
#argon主题设置
#git clone https://github.com/jerrykuku/luci-app-argon-config
#liuran001软件包
#git clone https://github.com/liuran001/openwrt-packages.git
popd

#删除liuran001软件包重复插件
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

#unblockneteasemusic
# 网易云音乐解锁 immortal
#rm -rf feeds/luci/applications/package/luci-app-unblockmusic
#rm -rf package/feeds/luci/luci-app-unblockmusic
#rm -rf feeds/packages/multimedia/UnblockNeteaseMusic-Go
#rm -rf feeds/packages/multimedia/UnblockNeteaseMusic
#rm -rf package/feeds/packages/UnblockNeteaseMusic-Go
#rm -rf package/feeds/packages/UnblockNeteaseMusic
#git clone --depth 1 https://github.com/immortalwrt/luci-app-unblockneteasemusic.git feeds/luci/applications/luci-app-unblockneteasemusic
#pushd package/feeds/luci
#ln -sv ../../../feeds/luci/applications/luci-app-unblockneteasemusic ./
#popd

#删除管控中多余的可道云,filebrowser
pushd package/openwrt-package
rm -rf luci-app-kodexplorer
rm -rf luci-app-filebrowser
popd

# AdGuardHome
git clone https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome
rm -rf feeds/packages/net/adguardhome
svn co https://github.com/openwrt/packages/trunk/net/adguardhome feeds/packages/net/adguardhome

#filebrowser
svn export https://github.com/immortalwrt/luci/trunk/applications/luci-app-filebrowser feeds/luci/applications/luci-app-filebrowser
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-filebrowser ./
popd

#filebrowser db
svn export https://github.com/immortalwrt/packages/trunk/utils/filebrowser feeds/packages/utils/filebrowser
pushd package/feeds/packages/
ln -sv ../../../feeds/packages/utils/filebrowser ./
popd

# ShadowsocksR Plus+
rm -rf feeds/packages/net/xray-core
rm -rf package/feeds/packages/xray-core
cp -r package/lean/helloworld/xray-core feeds/packages/net/
pushd package/feeds/packages
ln -sv ../../../feeds/packages/net/xray-core
popd


#speedtest cli
svn export https://github.com/immortalwrt/packages/trunk/net/speedtest-cli feeds/packages/net/speedtest-cli
pushd package/feeds/packages/
ln -sv ../../../feeds/packages/net/speedtest-cli ./
popd

# argon主题
rm -rf ./feeds/luci/themes/luci-theme-argon
rm -rf package/feeds/luci/luci-theme-argon
pushd package
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git
#vssr
git clone https://github.com/jerrykuku/lua-maxminddb.git  #git lua-maxminddb 依赖
git clone https://github.com/jerrykuku/luci-app-vssr.git 
popd

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.1/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.5.1/g' package/base-files/files/bin/config_generate
sed -i 's/bootstrap/argon/g' feeds/luci/collections/luci/Makefile
# Modify default PassWord
#sed -i 's/root::0:0:99999:7:::/root:$1$ScQIGKsX$q0qEf\/tAQ2wpTR6zIUIjo.:0:0:99999:7:::/g' package/base-files/files/etc/shadow
#删除默认密码
sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings

cd ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt
cp ~/work/Actions-OpenWrt/Actions-OpenWrt/conf/lede/ledex86.config ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/
cp ~/work/Actions-OpenWrt/Actions-OpenWrt/conf/lede/custom ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/
sed -i '/uci commit fstab/r custom' ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/package/lean/default-settings/files/zzz-default-settings

mv ledex86.config .config
make defconfig
