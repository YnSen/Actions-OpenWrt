# get source
git clone https://github.com/openwrt/openwrt -b openwrt-21.02
cd ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt

git checkout v21.02.1

./scripts/feeds update -a && ./scripts/feeds install -a

# Drop uhttpd
pushd feeds/luci
curl -s https://api.cooluc.com/openwrt/patch/0002-feeds-luci-Drop-uhttpd-depends.patch > 0002-feeds-luci-Drop-uhttpd-depends.patch
git apply 0002-feeds-luci-Drop-uhttpd-depends.patch && rm 0002-feeds-luci-Drop-uhttpd-depends.patch
popd

# Update nginx-1.20.2
pushd feeds/packages
curl -s https://api.cooluc.com/openwrt/patch/0004-nginx-update-to-version-1.20.2.patch > 0004-nginx-update-to-version-1.20.2.patch
git apply 0004-nginx-update-to-version-1.20.2.patch && rm 0004-nginx-update-to-version-1.20.2.patch
popd

curl -s https://raw.githubusercontent.com/YnSen/OpenWrt_x86-r2s-r4s/master/devices/common/diy/feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/19_cpu.js feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/19_cpu.js

# UPX
if ! command -v upx >/dev/null 2>&1; then
    if [ ! "$(uname)" == "Darwin" ];then
        sed -i '/patchelf pkgconf/i\tools-y += ucl upx' ./tools/Makefile
        sed -i '\/autoconf\/compile :=/i\$(curdir)/upx/compile := $(curdir)/ucl/compile' ./tools/Makefile
        svn co https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
        svn co https://github.com/coolsnowwolf/lede/trunk/tools/ucl tools/ucl
    fi
else
    mkdir -p staging_dir/host/bin/
    ln -sf `which upx` staging_dir/host/bin/upx
fi

# Rockchip - immortalwrt uboot & target upstream
rm -rf ./target/linux/rockchip
rm -rf ./package/boot/uboot-rockchip
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/target/linux/rockchip target/linux/rockchip
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/boot/uboot-rockchip package/boot/uboot-rockchip
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/boot/arm-trusted-firmware-rockchip-vendor package/boot/arm-trusted-firmware-rockchip-vendor
rm -f package/kernel/linux/modules/video.mk
curl -sL https://github.com/immortalwrt/immortalwrt/raw/openwrt-21.02/package/kernel/linux/modules/video.mk > package/kernel/linux/modules/video.mk

#ramips - immortalwrt uboot & target upstream
rm -rf ./target/linux/ramips
rm -rf ./package/boot/uboot-ramips
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/target/linux/ramips target/linux/ramips
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/boot/uboot-ramips package/boot/uboot-ramips

curl -fL -o sdk.tar.xz https://downloads.openwrt.org/releases/21.02.1/targets/x86/64/openwrt-sdk-21.02.1-x86-64_gcc-8.4.0_musl.Linux-x86_64.tar.xz || wget -cO sdk.tar.xz https://downloads.openwrt.org/releases/21.02.1/targets/x86/64/openwrt-sdk-21.02.1-x86-64_gcc-8.4.0_musl.Linux-x86_64.tar.xz

# AdGuard - Luci
git clone https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome

# AdGuardHome Beta - Fix build with go17.x
pushd feeds/packages
adguardhome_version=`curl -s "https://api.github.com/repos/AdguardTeam/AdGuardHome/releases" | grep "tag_name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g' | awk -F "v" '{print $2}'`
sed -ri "s/(PKG_VERSION:=)[^\"]*/\1$adguardhome_version/" net/adguardhome/Makefile
sed -i 's/release/beta/g' net/adguardhome/Makefile
sed -i 's/.*PKG_MIRROR_HASH.*/#&/' net/adguardhome/Makefile
sed -i '/init/d' net/adguardhome/Makefile
popd

# 文件浏览器
git clone https://git.cooluc.com/sbwml/luci-app-filebrowser package/new/luci-app-filebrowser
git clone https://git.cooluc.com/sbwml/filebrowser package/new/filebrowser

#openclash插件
git clone https://github.com/vernesong/OpenClash.git package/OpenClash

# argon主题
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-theme-argon-config

# 易有云
svn co https://github.com/linkease/nas-packages/trunk/network/services/linkease package/network/services/linkease
svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-linkease package/new/luci-app-linkease
pushd package/new/luci-app-linkease
sed -i 's/services/nas/g' luasrc/controller/linkease.lua
sed -i 's/services/nas/g' luasrc/view/linkease_status.htm
rm -rf luasrc/view/admin_status
popd

# alist
git clone https://git.cooluc.com/sbwml/alist-openwrt package/alist-openwrt

# qBittorrent
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-qbittorrent package/lean/luci-app-qbittorrent
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/qBittorrent-static package/lean/qBittorrent-static
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/qBittorrent package/lean/qBittorrent
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/rblibtorrent package/lean/rblibtorrent
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/qtbase package/lean/qtbase
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/qttools package/lean/qttools
pushd package/lean/luci-app-qbittorrent
sed -i 's/nas/services/g' luasrc/controller/qbittorrent.lua
sed -i 's/nas/services/g' luasrc/view/qbittorrent/qbittorrent_status.htm
popd

# 应用过滤
git clone https://github.com/sbwml/OpenAppFilter --depth=1 package/new/OpenAppFilter

# UPnP
#sed -i 's/services/network/g' feeds/luci/applications/luci-app-upnp/root/usr/share/luci/menu.d/luci-app-upnp.json

# luci-app-freq
#svn co https://github.com/immortalwrt/luci/trunk/applications/luci-app-cpufreq feeds/luci/applications/luci-app-cpufreq
#ln -sf ../../../feeds/luci/applications/luci-app-cpufreq ./package/feeds/luci/luci-app-cpufreq
#sed -i "s/900/90/g" feeds/luci/applications/luci-app-cpufreq/luasrc/controller/cpufreq.lua
#sed -i 's,1608,1800,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/cpufreq
#sed -i 's,2016,2208,g' feeds/luci/applications/luci-app-cpufreq/root/etc/uci-defaults/cpufreq

# AutoCore
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/emortal/autocore package/lean/autocore
rm -rf ./feeds/packages/utils/coremark
svn co https://github.com/immortalwrt/packages/trunk/utils/coremark feeds/packages/utils/coremark

# wrt bw monitor
git clone -b master --single-branch https://github.com/brvphoenix/wrtbwmon --depth=1 package/new/wrtbwmon
git clone -b master --single-branch https://github.com/brvphoenix/luci-app-wrtbwmon --depth=1 package/new/luci-app-wrtbwmon

# iputils
svn co https://github.com/openwrt/openwrt/branches/openwrt-19.07/package/network/utils/iputils package/network/utils/iputils

# 磁盘分区
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-diskman package/lean/luci-app-diskman
svn co https://github.com/coolsnowwolf/packages/trunk/utils/parted package/lean/parted

# 迅雷快鸟
git clone --depth 1 https://github.com/garypang13/luci-app-xlnetacc.git package/lean/luci-app-xlnetacc

# 清理内存
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-ramfree package/lean/luci-app-ramfree

# 打印机
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-usb-printer package/lean/luci-app-usb-printer

# 定时重启
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-autoreboot package/lean/luci-app-autoreboot

# 流量监管
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-netdata package/lean/luci-app-netdata

# KMS
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-vlmcsd package/lean/luci-app-vlmcsd
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/vlmcsd package/lean/vlmcsd

# DDNS
svn co https://github.com/sbwml/openwrt-package/trunk/ddns-scripts-dnspod package/lean/ddns-scripts_dnspod
svn co https://github.com/sbwml/openwrt-package/trunk/ddns-scripts-aliyun package/lean/ddns-scripts_aliyun

# SSR Plus
git clone --depth=1 https://github.com/fw876/helloworld package/helloworld
pushd package/helloworld
sed -i 's,ispip.clang.cn/all_cn,cdn.jsdelivr.net/gh/QiuSimons/Chnroute@master/dist/chnroute/chnroute,' luci-app-ssr-plus/root/etc/init.d/shadowsocksr
sed -i '/Clang.CN.CIDR/a\o:value("https://cdn.jsdelivr.net/gh/QiuSimons/Chnroute@master/dist/chnroute/chnroute.txt", translate("QiuSimons/Chnroute"))' luci-app-ssr-plus/luasrc/model/cbi/shadowsocksr/advanced.lua
popd
if [ "$isCN" = "CN" ];then
    sed -i "s/commondatastorage.googleapis.com/proxy.cooluc.com/g" package/helloworld/naiveproxy/Makefile
    sed -i "s/chrome-infra-packages.appspot.com/proxy2.cooluc.com/g" package/helloworld/naiveproxy/Makefile
fi

# SSR Plus - deps
rm -rf feeds/packages/net/xray-core
svn co https://github.com/immortalwrt/packages/trunk/net/dns2socks package/helloworld-deps/dns2socks
svn co https://github.com/immortalwrt/packages/trunk/net/microsocks package/helloworld-deps/microsocks
svn co https://github.com/immortalwrt/packages/trunk/net/ipt2socks package/helloworld-deps/ipt2socks
svn co https://github.com/immortalwrt/packages/trunk/net/pdnsd-alt package/helloworld-deps/pdnsd
svn co https://github.com/immortalwrt/packages/trunk/net/redsocks2 package/helloworld-deps/redsocks2

# PASSWALL
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/luci-app-passwall package/passwall/luci-app-passwall
sed -i 's,一般般,通用,g' package/passwall/luci-app-passwall/po/zh-cn/passwall.po

# PASSWALL - deps
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/brook package/passwall-deps/brook
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/hysteria package/passwall-deps/hysteria
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-go package/passwall-deps/trojan-go
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-plus package/passwall-deps/trojan-plus
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/chinadns-ng package/passwall-deps/chinadns-ng

# 自动挂载
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/automount package/lean/automount

# 翻译
sed -i 's,发送,Transmission,g' feeds/luci/applications/luci-app-transmission/po/zh_Hans/transmission.po
sed -i 's,frp 服务器,FRP 服务器,g' feeds/luci/applications/luci-app-frps/po/zh_Hans/frps.po
sed -i 's,frp 客户端,FRP 客户端,g' feeds/luci/applications/luci-app-frpc/po/zh_Hans/frpc.po

# mjpg-streamer init
#sed -i "s,option port '8080',option port '1024',g" feeds/packages/multimedia/mjpg-streamer/files/mjpg-streamer.config
#sed -i "s,option fps '5',option fps '25',g" feeds/packages/multimedia/mjpg-streamer/files/mjpg-streamer.config
#sed -i "s,option www '/www/webcam',option www '/opt/webcam',g" feeds/packages/multimedia/mjpg-streamer/files/mjpg-streamer.config
# luci-app-mjpg-streamer
#rm -rf feeds/luci/applications/luci-app-mjpg-streamer
#git clone https://github.com/sbwml/luci-app-mjpg-streamer feeds/luci/applications/luci-app-mjpg-streamer

curl -O https://api.cooluc.com/openwrt/scripts/02-remove_upx.sh
curl -O https://api.cooluc.com/openwrt/scripts/03-convert_translation.sh
curl -O https://api.cooluc.com/openwrt/scripts/04-create_acl_for_luci.sh
curl -O https://api.cooluc.com/openwrt/scripts/99_clean_build_cache.sh
chmod 0755 *sh
./02-remove_upx.sh
./04-create_acl_for_luci.sh -a
./03-convert_translation.sh

curl -s https://raw.githubusercontent.com/YnSen/Actions-OpenWrt/main/off.config > .config
make defconfig
