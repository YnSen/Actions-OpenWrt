##offical uhttpx86
# get source
git clone https://github.com/openwrt/openwrt -b openwrt-21.02
cd ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt

git checkout v21.02.2

./scripts/feeds update -a && ./scripts/feeds install -a

#cp ~/work/Actions-OpenWrt/Actions-OpenWrt/19_cpu.js ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/

#curl -fL -o sdk.tar.xz https://downloads.openwrt.org/releases/21.02.1/targets/x86/64/openwrt-sdk-21.02.1-x86-64_gcc-8.4.0_musl.Linux-x86_64.tar.xz || wget -cO sdk.tar.xz https://downloads.openwrt.org/releases/21.02.1/targets/x86/64/openwrt-sdk-21.02.1-x86-64_gcc-8.4.0_musl.Linux-x86_64.tar.xz

cp ~/work/Actions-OpenWrt/Actions-OpenWrt/patch/652-netfilter-flow_offload-add-check-ifindex.patch target/linux/generic/hack-5.4/

# 默认设置
svn co https://github.com/YnSen/Actions-OpenWrt/trunk/default-settings package/default-settings
pushd package/default-settings
cp -r files ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/
popd

# Max connection limite
sed -i 's/16384/65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

# AdGuardHome
git clone https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome
rm -rf feeds/packages/net/adguardhome
svn co https://github.com/openwrt/packages/trunk/net/adguardhome feeds/packages/net/adguardhome
sed -i '/\t)/a\\t$(STAGING_DIR_HOST)/bin/upx --lzma --best $(GO_PKG_BUILD_BIN_DIR)/AdGuardHome' ./feeds/packages/net/adguardhome/Makefile
sed -i '/init/d' feeds/packages/net/adguardhome/Makefile

#docker
rm -rf feeds/luci/applications/luci-app-dockerman
svn co https://github.com/lisaac/luci-app-dockerman/trunk/applications/luci-app-dockerman feeds/luci/applications/luci-app-dockerman
rm -rf feeds/luci/collections/luci-lib-docker
svn co https://github.com/lisaac/luci-lib-docker/trunk/collections/luci-lib-docker feeds/luci/collections/luci-lib-docker

# 文件浏览器
git clone https://github.com/xiaozhuai/luci-app-filebrowser package/luci-app-filebrowser

#管控
git clone https://github.com/Lienol/openwrt-package.git package/openwrt-package

#openclash插件
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash

#强制关机插件
git clone https://github.com/esirplayground/luci-app-poweroff package/luci-app-poweroff
#自动关机插件
git clone https://github.com/sirpdboy/luci-app-autopoweroff package/luci-app-autopoweroff

# argon主题
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-theme-argon-config

# 易有云
#svn co https://github.com/linkease/nas-packages/trunk/network/services/linkease package/network/services/linkease
#svn co https://github.com/linkease/nas-packages-luci/trunk/luci/luci-app-linkease package/new/luci-app-linkease
#pushd package/new/luci-app-linkease
#sed -i 's/services/nas/g' luasrc/controller/linkease.lua
#sed -i 's/services/nas/g' luasrc/view/linkease_status.htm
#rm -rf luasrc/view/admin_status
#popd

#kodexplorer
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-kodexplorer feeds/luci/applications/luci-app-kodexplorer
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-kodexplorer ./
popd

# alist
git clone https://github.com/sbwml/openwrt-alist package/alist-openwrt

# qBittorrent
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-qbittorrent feeds/luci/applications/luci-app-qbittorrent
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-qbittorrent ./
popd

svn co https://github.com/coolsnowwolf/packages/trunk/net/qBittorrent-static feeds/packages/net/qBittorrent-static
pushd package/feeds/packages
ln -sv ../../../feeds/packages/net/qBittorrent-static ./
popd

svn co https://github.com/coolsnowwolf/packages/trunk/net/qBittorrent feeds/packages/net/qBittorrent
pushd package/feeds/packages
ln -sv ../../../feeds/packages/net/qBittorrent ./
popd


svn co https://github.com/coolsnowwolf/packages/trunk/libs/qtbase feeds/packages/libs/qtbase
pushd package/feeds/packages
ln -sv ../../../feeds/packages/libs/qtbase ./
popd


svn co https://github.com/coolsnowwolf/packages/trunk/libs/qttools feeds/packages/libs/qttools
pushd package/feeds/packages
ln -sv ../../../feeds/packages/libs/qttools ./
popd

svn co https://github.com/coolsnowwolf/packages/trunk/libs/rblibtorrent feeds/packages/libs/rblibtorrent
pushd package/feeds/packages
ln -sv ../../../feeds/packages/libs/rblibtorrent ./
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
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-diskman feeds/luci/applications/luci-app-diskman
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-diskman ./
popd

svn co https://github.com/coolsnowwolf/packages/trunk/utils/parted feeds/packages/utils/parted
pushd package/feeds/packages
ln -sv ../../../feeds/luci/packages/parted ./
popd

# 迅雷快鸟
git clone --depth 1 https://github.com/garypang13/luci-app-xlnetacc.git package/lean/luci-app-xlnetacc

# 清理内存
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-ramfree feeds/luci/applications/luci-app-ramfree
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-ramfree ./
popd

# 打印机
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-usb-printer feeds/luci/applications/luci-app-usb-printer
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-usb-printer ./
popd

# 流量监管
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-netdata feeds/luci/applications/luci-app-netdata
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-netdata ./
popd

# KMS
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-vlmcsd feeds/luci/applications/luci-app-vlmcsd
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-vlmcsd ./
popd

svn co https://github.com/coolsnowwolf/packages/trunk/net/vlmcsd feeds/packages/net/vlmcsd
pushd package/feeds/packages
ln -sv ../../../feeds/packages/net/vlmcsd ./
popd

# DDNS
svn co https://github.com/sbwml/openwrt-package/trunk/ddns-scripts-dnspod package/lean/ddns-scripts_dnspod
svn co https://github.com/sbwml/openwrt-package/trunk/ddns-scripts-aliyun package/lean/ddns-scripts_aliyun

# ShadowsocksR Plus+
git clone https://github.com/fw876/helloworld.git package/lean/helloworld
rm -rf feeds/packages/net/xray-core
rm -rf package/feeds/packages/xray-core
cp -r package/lean/helloworld/xray-core feeds/packages/net/
pushd package/feeds/packages
ln -sv ../../../feeds/packages/net/xray-core
popd

# SSR Plus - deps
svn co https://github.com/coolsnowwolf/packages/trunk/net/redsocks2 package/lean/

# PASSWALL
git clone https://github.com/xiaorouji/openwrt-passwall.git package/passwall/
sed -i 's,一般般,通用,g' package/passwall/luci-app-passwall/po/zh-cn/passwall.po

#aliyundrive-webdav
svn co https://github.com/coolsnowwolf/packages/trunk/net/aliyundrive-webdav feeds/packages/net/aliyundrive-webdav
pushd package/feeds/packages
ln -sv ../../../feeds/packages/net/aliyundrive-webdav ./
popd

svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-aliyundrive-webdav feeds/luci/applications/luci-app-aliyundrive-webdav
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-aliyundrive-webdav ./
popd

# 网易云音乐解锁
git clone --depth 1 https://github.com/immortalwrt/luci-app-unblockneteasemusic.git package/new/UnblockNeteaseMusic

#UnblockMusic163 lean
#svn co https://github.com/coolsnowwolf/packages/trunk/multimedia/UnblockNeteaseMusic feeds/packages/multimedia/UnblockNeteaseMusic
#pushd package/feeds/packages
#ln -sv ../../../feeds/packages/multimedia/UnblockNeteaseMusic ./
#popd

#svn co https://github.com/coolsnowwolf/packages/trunk/multimedia/UnblockNeteaseMusic-Go feeds/packages/multimedia/UnblockNeteaseMusic-Go
#pushd package/feeds/packages
#ln -sv ../../../feeds/packages/multimedia/UnblockNeteaseMusic-Go ./
#popd

#svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-unblockmusic feeds/luci/applications/luci-app-unblockmusic
#pushd package/feeds/luci
#ln -sv ../../../feeds/luci/applications/luci-app-unblockmusic ./
#popd

#OpenVpnServer
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-openvpn-server feeds/luci/applications/luci-app-openvpn-server
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-openvpn-server ./
popd

#rclone
svn co https://github.com/coolsnowwolf/packages/trunk/net/rclone feeds/packages/net/rclone
pushd package/feeds/packages
ln -sv ../../../feeds/packages/net/rclone ./
popd

svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-rclone feeds/luci/applications/luci-app-rclone
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-rclone ./
popd

svn co https://github.com/coolsnowwolf/packages/trunk/net/rclone-ng feeds/packages/net/rclone-ng
pushd package/feeds/packages
ln -sv ../../../feeds/packages/net/rclone-ng ./
popd

#cifsmount
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-cifs-mount feeds/luci/applications/luci-app-cifs-mount
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-cifs-mount ./
popd

#nfs
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-nfs feeds/luci/applications/luci-app-nfs
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-nfs ./
popd

#luci socat
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-socat package/new/luci-app-socat

#Zerotier
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-zerotier feeds/luci/applications/luci-app-zerotier
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-zerotier ./
popd

# 自动挂载 不适合官方
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/automount package/lean/automount
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ntfs3-mount package/lean/ntfs3-mount
#svn co https://github.com/coolsnowwolf/lede/tree/master/package/lean/ntfs3-oot package/lean/ntfs3-oot

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

curl -O https://raw.githubusercontent.com/YnSen/Actions-OpenWrt/main/sh/scripts/02-remove_upx.sh
curl -O https://raw.githubusercontent.com/YnSen/Actions-OpenWrt/main/sh/scripts/03-convert_translation.sh
#curl -O https://raw.githubusercontent.com/YnSen/Actions-OpenWrt/main/sh/scripts/04-create_acl_for_luci.sh
chmod 0755 *sh
./02-remove_upx.sh
./03-convert_translation.sh
./04-create_acl_for_luci.sh -a

cd ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt
cp ~/work/Actions-OpenWrt/Actions-OpenWrt/conf/uhttpx86.config ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/
mv ~/work/Actions-OpenWrt/Actions-OpenWrt/conf/config-5.4 ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/target/linux/x86/
mv uhttpx86.config .config
make defconfig
