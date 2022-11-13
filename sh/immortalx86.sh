#get source
git clone -b openwrt-21.02 https://github.com/immortalwrt/immortalwrt.git openwrt
cd ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt
git checkout v21.02.3
./scripts/feeds update -a && ./scripts/feeds install -a

# AdGuardHome
git clone https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome
rm -rf ./feeds/packages/net/adguardhome
svn export https://github.com/openwrt/packages/trunk/net/adguardhome feeds/packages/net/adguardhome

echo '================================================================'
#sbwml mosdns
git clone https://github.com/sbwml/luci-app-mosdns package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/v2ray-geodata
cp -r package/v2ray-geodata ./feeds/packages/net/
cp -r package/mosdns/mosdns ./feeds/packages/net/

#404 mosdns
#git clone https://github.com/QiuSimons/openwrt-mos.git package/mosdns
#cp -rf package/mosdns/mosdns ./feeds/packages/net/
#cp -rf package/mosdns/v2ray-geodata ./feeds/packages/net/
echo '================================================================'

#管控
rm -rf package/feeds/luci/luci-app-webrestriction
rm -rf package/feeds/luci/luci-app-timewol
rm -rf package/feeds/luci/luci-app-weburl
rm -rf package/feeds/luci/luci-app-timecontrol
rm -rf feeds/luci/applications/luci-app-timecontrol
rm -rf feeds/luci/applications/luci-app-weburl
rm -rf feeds/luci/applications/luci-app-timewol
rm -rf feeds/luci/applications/luci-app-webrestriction
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-control-timewol package/openwrt-package/luci-app-control-timewol
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-control-webrestriction package/openwrt-package/luci-app-control-webrestriction
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-control-weburl package/openwrt-package/luci-app-control-weburl
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-timecontrol package/openwrt-package/luci-app-timecontrol

cp -r package/openwrt-package/luci-app-timecontrol/po/zh-cn package/openwrt-package/luci-app-timecontrol/po/zh_Hans
cp -r package/openwrt-package/luci-app-control-timewol/po/zh-cn package/openwrt-package/luci-app-control-timewol/po/zh_Hans
cp -r package/openwrt-package/luci-app-control-webrestriction/po/zh-cn package/openwrt-package/luci-app-control-webrestriction/po/zh_Hans
cp -r package/openwrt-package/luci-app-control-weburl/po/zh-cn package/openwrt-package/luci-app-control-weburl/po/zh_Hans

#argon theme
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf package/feeds/luci/luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
pushd package/feeds/luci/
ln -sv ../../../feeds/luci/themes/luci-theme-argon ./
popd

#aliyundrive-webdav
svn co https://github.com/coolsnowwolf/packages/trunk/multimedia/aliyundrive-webdav feeds/packages/multimedia/aliyundrive-webdav
pushd package/feeds/packages
ln -sv ../../../feeds/packages/multimedia/aliyundrive-webdav ./
popd

svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-aliyundrive-webdav feeds/luci/applications/luci-app-aliyundrive-webdav
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-aliyundrive-webdav ./
popd

# 应用过滤
rm -rf feeds/packages/net/open-app-filter
rm -rf feeds/luci/applications/luci-app-appfilter
rm -rf package/feeds/luci/luci-app-appfilter
rm -rf package/feeds/packages/open-app-filter
git clone https://github.com/sbwml/OpenAppFilter --depth=1 package/new/OpenAppFilter

#softethervpn
rm -rf feeds/packages/net/softethervpn
rm -rf feeds/packages/net/softethervpn5
rm -rf feeds/luci/applications/luci-app-softether
rm -rf package/feeds/packages/softethervpn
rm -rf package/feeds/packages/softethervpn5
rm -rf package/feeds/luci/luci-app-softethervpn
rm -rf package/feeds/luci/luci-app-softethervpn5
svn co https://github.com/coolsnowwolf/packages/trunk/net/softethervpn feeds/packages/net/softethervpn
svn co https://github.com/coolsnowwolf/packages/trunk/net/softethervpn5 feeds/packages/net/softethervpn5
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-softethervpn feeds/luci/applications/luci-app-softethervpn
cp -r feeds/luci/applications/luci-app-softethervpn/po/zh-cn feeds/luci/applications/luci-app-softethervpn/po/zh_Hans

pushd package/feeds/luci/
ln -sv ../../../feeds/luci/applications/luci-app-softethervpn ./
popd

pushd package/feeds/packages/
ln -sv ../../../feeds/packages/net/softethervpn ./
ln -sv ../../../feeds/packages/net/softethervpn5 ./
popd

#openclash插件
rm -rf ./feeds/luci/applications/luci-app-openclash
rm -rf ./package/feeds/luci/luci-app-openclash
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
rm -rf package/luci-app-openclash/Makefile
cp ~/work/Actions-OpenWrt/Actions-OpenWrt/conf/imm/Makefile package/luci-app-openclash/Makefile

cp -r ~/work/Actions-OpenWrt/Actions-OpenWrt/default-settings/files ./files

# 流量监视
git clone -b master --depth 1 https://github.com/brvphoenix/wrtbwmon.git package/new/wrtbwmon
git clone -b master --depth 1 https://github.com/brvphoenix/luci-app-wrtbwmon.git package/new/luci-app-wrtbwmon

pushd package
#强制关机插件
git clone https://github.com/esirplayground/luci-app-poweroff.git
#自动关机插件
git clone https://github.com/sirpdboy/luci-app-autopoweroff

#腾讯ddns
#git clone https://github.com/Tencent-Cloud-Plugins/tencentcloud-openwrt-plugin-ddns
#pushd tencentcloud-openwrt-plugin-ddns/tencentcloud_ddns/files/luci/controller
#sed -i 's/"admin", "tencentcloud"/"admin", "services", "tencentcloud"/g' tencentddns.lua
#popd
popd

#add zh-cn translate
cp -r package/new/luci-app-wrtbwmon/luci-app-wrtbwmon/po/zh_Hans package/new/luci-app-wrtbwmon/luci-app-wrtbwmon/po/zh-cn
cp -r package/luci-app-poweroff/po/zh-cn package/luci-app-poweroff/po/zh_Hans

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate

#添加intel AES支持
echo 'CONFIG_CRYPTO_AES_NI_INTEL=y' >>./target/linux/x86/64/config-5.4

#删除默认密码
sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/emortal/default-settings/files/99-default-settings

cd ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt
cp ~/work/Actions-OpenWrt/Actions-OpenWrt/conf/imm/immx86.config ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/
cp ~/work/Actions-OpenWrt/Actions-OpenWrt/conf/imm/config-5.4 ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/target/linux/x86/
cp ~/work/Actions-OpenWrt/Actions-OpenWrt/conf/imm/custom ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/
sed -i '/uci commit fstab/r custom' ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/package/emortal/default-settings/files/99-default-settings
mv immx86.config .config
make defconfig
