#get source
git clone -b openwrt-21.02 https://github.com/immortalwrt/immortalwrt.git openwrt
cd ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt
git checkout v21.02.1
./scripts/feeds update -a && ./scripts/feeds install -a

# AdGuardHome
git clone https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome
rm -rf ./feeds/packages/net/adguardhome
svn export https://github.com/openwrt/packages/trunk/net/adguardhome feeds/packages/net/adguardhome

# alist
git clone https://github.com/sbwml/openwrt-alist package/alist-openwrt

#argon theme
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf package/feeds/luci/luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

# 应用过滤
rm -rf feeds/packages/net/open-app-filter
rm -rf feeds/luci/applications/luci-app-appfilter
rm -rf package/feeds/luci/luci-app-appfilter
rm -rf package/feeds/packages/open-app-filter
git clone https://github.com/sbwml/OpenAppFilter --depth=1 package/new/OpenAppFilter

# FRP 内网穿透
rm -rf ./feeds/luci/applications/luci-app-frpc
rm -rf ./feeds/luci/applications/luci-app-frps
rm -rf ./feeds/packages/net/frp
rm -rf ./package/feeds/packages/frp
rm -rf ./package/feeds/luci/luci-app-frpc
rm -rf ./package/feeds/luci/luci-app-frps
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-frpc feeds/luci/applications/luci-app-frpc
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-frps feeds/luci/applications/luci-app-frps
pushd package/feeds/luci/
ln -sv ../../../feeds/luci/applications/luci-app-frpc ./
ln -sv ../../../feeds/luci/applications/luci-app-frps ./
popd

svn export https://github.com/coolsnowwolf/packages/trunk/net/frp feeds/packages/net/frp
pushd package/feeds/packages
ln -sv ../../../feeds/packages/net/frp ./
popd

#softethervpn
rm -rf feeds/packages/net/softethervpn
rm -rf feeds/packages/net/softethervpn5
rm -rf feeds/luci/applications/luci-app-softether
rm -rf package/feeds/packages/softethervpn
rm -rf package/feeds/packages/softethervpn5
rm -rf package/feeds/luci/luci-app-softether
svn export https://github.com/coolsnowwolf/packages/trunk/net/softethervpn feeds/packages/net/softethervpn
svn export https://github.com/coolsnowwolf/packages/trunk/net/softethervpn5 feeds/packages/net/softethervpn5
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-softethervpn feeds/luci/applications/luci-app-softethervpn

pushd package/feeds/luci/
ln -sv ../../../feeds/luci/applications/luci-app-softethervpn ./
popd

pushd package/feeds/packages/
ln -sv ../../../feeds/packages/net/softethervpn ./
ln -sv ../../../feeds/packages/net/softethervpn5 ./
popd

pushd package
#强制关机插件
git clone https://github.com/esirplayground/luci-app-poweroff
#自动关机插件
git clone https://github.com/sirpdboy/luci-app-autopoweroff
#腾讯ddns
git clone https://github.com/Tencent-Cloud-Plugins/tencentcloud-openwrt-plugin-ddns
pushd tencentcloud-openwrt-plugin-ddns/tencentcloud_ddns/files/luci/controller
sed -i 's/"admin", "tencentcloud"/"admin", "services", "tencentcloud"/g' tencentddns.lua
popd
popd
# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
sed -i 's/bootstrap/argon/g' feeds/luci/collections/luci/Makefile
cd ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt
cp ~/work/Actions-OpenWrt/Actions-OpenWrt/conf/imm/nginx.config ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/
cp ~/work/Actions-OpenWrt/Actions-OpenWrt/conf/imm/config-5.4 ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/target/linux/x86/
mv nginx.config .config
make defconfig
