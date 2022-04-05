##offical uhttpr3p
# get source
git clone https://github.com/openwrt/openwrt -b openwrt-21.02
cd ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt

git checkout v21.02.2

./scripts/feeds update -a && ./scripts/feeds install -a

# Rockchip - immortalwrt uboot & target upstream
#rm -rf ./target/linux/rockchip
#rm -rf ./package/boot/uboot-rockchip
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/target/linux/rockchip target/linux/rockchip
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/boot/uboot-rockchip package/boot/uboot-rockchip
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/boot/arm-trusted-firmware-rockchip-vendor package/boot/arm-trusted-firmware-rockchip-vendor
#rm -f package/kernel/linux/modules/video.mk
#curl -sL https://github.com/immortalwrt/immortalwrt/raw/openwrt-21.02/package/kernel/linux/modules/video.mk > package/kernel/linux/modules/video.mk

#ramips - immortalwrt uboot & target upstream
rm -rf ./target/linux/ramips
rm -rf ./package/boot/uboot-ramips
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/target/linux/ramips target/linux/ramips
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/boot/uboot-ramips package/boot/uboot-ramips

#curl -fL -o sdk.tar.xz https://downloads.openwrt.org/releases/21.02.1/targets/ramips/mt7621/openwrt-sdk-21.02.1-ramips-mt7621_gcc-8.4.0_musl.Linux-x86_64.tar.xz || wget -cO sdk.tar.xz https://downloads.openwrt.org/releases/21.02.1/targets/ramips/mt7621/openwrt-sdk-21.02.1-ramips-mt7621_gcc-8.4.0_musl.Linux-x86_64.tar.xz

# Max connection limite
sed -i 's/16384/65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

cp ~/work/Actions-OpenWrt/Actions-OpenWrt/patch/652-netfilter-flow_offload-add-check-ifindex.patch target/linux/generic/hack-5.4/

# 默认设置
svn co https://github.com/YnSen/Actions-OpenWrt/trunk/default-settings package/default-settings
pushd package/default-settings
cp -r files ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/
cd default/
rm -rf zzz-default-settings
rm -rf zzz-default-settingsnginx
mv r3p zzz-default-settings
popd


cp -r ~/work/Actions-OpenWrt/Actions-OpenWrt/default-settings/files ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/
cp ~/work/Actions-OpenWrt/Actions-OpenWrt/conf/wireless ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/files/etc/config/

#推送
git clone https://github.com/tty228/luci-app-serverchan package/luci-app-serverchan

# AdGuardHome
git clone https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome
rm -rf feeds/packages/net/adguardhome
svn co https://github.com/openwrt/packages/trunk/net/adguardhome feeds/packages/net/adguardhome
sed -i '/\t)/a\\t$(STAGING_DIR_HOST)/bin/upx --lzma --best $(GO_PKG_BUILD_BIN_DIR)/AdGuardHome' ./feeds/packages/net/adguardhome/Makefile
sed -i '/init/d' feeds/packages/net/adguardhome/Makefile


#管控
git clone https://github.com/Lienol/openwrt-package.git package/openwrt-package
rm -rf package/openwrt-package/luci-app-filebrowser

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

#openclash插件
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash

#强制关机插件
git clone https://github.com/esirplayground/luci-app-poweroff
#自动关机插件
  git clone https://github.com/sirpdboy/luci-app-autopoweroff

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

# qBittorrent
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-qbittorrent package/lean/luci-app-qbittorrent
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/qBittorrent-static package/lean/qBittorrent-static
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/qBittorrent package/lean/qBittorrent
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/rblibtorrent package/lean/rblibtorrent
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/qtbase package/lean/qtbase
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/qttools package/lean/qttools
#pushd package/lean/luci-app-qbittorrent
#sed -i 's/nas/services/g' luasrc/controller/qbittorrent.lua
#sed -i 's/nas/services/g' luasrc/view/qbittorrent/qbittorrent_status.htm
#popd
#git clone https://git.cooluc.com/sbwml/openwrt-qBittorrent.git

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


# wrt bw monitor
git clone -b master --single-branch https://github.com/brvphoenix/wrtbwmon --depth=1 package/new/wrtbwmon
git clone -b master --single-branch https://github.com/brvphoenix/luci-app-wrtbwmon --depth=1 package/new/luci-app-wrtbwmon

# iputils
#svn co https://github.com/openwrt/openwrt/branches/openwrt-19.07/package/network/utils/iputils package/network/utils/iputils


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

# 定时重启
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-autoreboot package/lean/luci-app-autoreboot



# DDNS
svn co https://github.com/sbwml/openwrt-package/trunk/ddns-scripts-dnspod package/lean/ddns-scripts_dnspod
svn co https://github.com/sbwml/openwrt-package/trunk/ddns-scripts-aliyun package/lean/ddns-scripts_aliyun

# ShadowsocksR Plus+
svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus package/lean/helloworld/luci-app-ssr-plus
svn co https://github.com/fw876/helloworld/trunk/simple-obfs package/lean/helloworld/simple-obfs
svn co https://github.com/fw876/helloworld/trunk/naiveproxy package/lean/helloworld/naiveproxy
svn co https://github.com/fw876/helloworld/trunk/v2ray-core package/lean/helloworld/v2ray-core
svn co https://github.com/fw876/helloworld/trunk/v2ray-geodata package/lean/helloworld/v2ray-geodata
svn co https://github.com/fw876/helloworld/trunk/xray-core package/lean/helloworld/xray-core
svn co https://github.com/fw876/helloworld/trunk/v2ray-plugin package/lean/helloworld/v2ray-plugin
svn co https://github.com/fw876/helloworld/trunk/xray-plugin package/lean/helloworld/xray-plugin
svn co https://github.com/fw876/helloworld/trunk/shadowsocks-rust package/lean/helloworld/shadowsocks-rust
svn co https://github.com/fw876/helloworld/trunk/shadowsocksr-libev package/lean/helloworld/shadowsocksr-libev
svn co https://github.com/fw876/helloworld/trunk/tcping package/lean/helloworld/tcping
svn co https://github.com/fw876/helloworld/trunk/trojan package/lean/helloworld/trojan
rm -rf feeds/packages/net/xray-core
rm -rf package/feeds/packages/xray-core
cp -r package/lean/helloworld/xray-core feeds/packages/net/
pushd package/feeds/packages
ln -sv ../../../feeds/packages/net/xray-core
popd

# SSR Plus - deps
svn co https://github.com/coolsnowwolf/packages/trunk/net/redsocks2 package/lean/helloworld/redsocks2

# PASSWALL
git clone https://github.com/xiaorouji/openwrt-passwall -b luci package/passwall/luci-app-passwall
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/shadowsocksr-libev package/passwall/shadowsocksr-libev
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/microsocks package/passwall/microsocks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/dns2socks package/passwall/dns2socks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ipt2socks package/passwall/ipt2socks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan package/passwall/trojan
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/tcping package/passwall/tcping
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-go package/passwall/trojan-go
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/chinadns-ng package/passwall/chinadns-ng
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/brook package/passwall/brook
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/microsocks package/passwall/microsocks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/naiveproxy package/passwall/naiveproxy
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/pdnsd-alt package/passwall/pdnsd-alt
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/simple-obfs package/passwall/simple-obfs
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ssocks package/passwall/ssocks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/tcping package/passwall/tcping
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-plus package/passwall/trojan-plus
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-core package/passwall/v2ray-core
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-geodata package/passwall/v2ray-geodata
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-plugin package/passwall/v2ray-plugin
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-core package/passwall/xray-core
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-plugin package/passwall/xray-plugin
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/shadowsocks-rust package/passwall/shadowsocks-rust
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/hysteria package/passwall/hysteria
sed -i 's,一般般,通用,g' package/passwall/luci-app-passwall/po/zh-cn/passwall.po


#aliyundrive-webdav
svn co https://github.com/coolsnowwolf/packages/trunk/net/aliyundrive-webdav package/lean/aliyundrive-webdav
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-aliyundrive-webdav package/lean/luci-app-aliyundrive-webdav

#UnblockMusic163
git clone https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git feeds/luci/applications/luci-app-unblockneteasemusic
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-unblockneteasemusic ./
popd

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

#TurboAcc

svn co https://github.com/coolsnowwolf/packages/trunk/net/dnsforwarder feeds/packages/net/dnsforwarder
pushd package/feeds/packages
ln -sv ../../../feeds/packages/net/dnsforwarder ./
popd

svn co https://github.com/coolsnowwolf/packages/trunk/net/dnsproxy feeds/packages/net/dnsproxy
pushd package/feeds/packages
ln -sv ../../../feeds/packages/net/dnsproxy ./
popd

svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/shortcut-fe package/lean/shortcut-fe

svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-turboacc feeds/luci/applications/luci-app-turboacc
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-turboacc ./
popd


#Zerotier
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-zerotier feeds/luci/applications/luci-app-zerotier
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-zerotier ./
popd

# 自动挂载
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/automount package/lean/automount
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ntfs3-mount package/lean/ntfs3-mount
#svn co https://github.com/coolsnowwolf/lede/tree/master/package/lean/ntfs3-oot package/lean/ntfs3-oot

#luci socat
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-socat package/new/luci-app-socat



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

# 更换 Nodejs 版本
rm -rf ./feeds/packages/lang/node
svn export https://github.com/nxhack/openwrt-node-packages/trunk/node feeds/packages/lang/node
sed -i '\/bin\/node/a\\t$(STAGING_DIR_HOST)/bin/upx --lzma --best $(1)/usr/bin/node' feeds/packages/lang/node/Makefile
rm -rf ./feeds/packages/lang/node-arduino-firmata
svn export https://github.com/nxhack/openwrt-node-packages/trunk/node-arduino-firmata feeds/packages/lang/node-arduino-firmata
rm -rf ./feeds/packages/lang/node-cylon
svn export https://github.com/nxhack/openwrt-node-packages/trunk/node-cylon feeds/packages/lang/node-cylon
rm -rf ./feeds/packages/lang/node-hid
svn export https://github.com/nxhack/openwrt-node-packages/trunk/node-hid feeds/packages/lang/node-hid
rm -rf ./feeds/packages/lang/node-homebridge
svn export https://github.com/nxhack/openwrt-node-packages/trunk/node-homebridge feeds/packages/lang/node-homebridge
rm -rf ./feeds/packages/lang/node-serialport
svn export https://github.com/nxhack/openwrt-node-packages/trunk/node-serialport feeds/packages/lang/node-serialport
rm -rf ./feeds/packages/lang/node-serialport-bindings
svn export https://github.com/nxhack/openwrt-node-packages/trunk/node-serialport-bindings feeds/packages/lang/node-serialport-bindings
rm -rf ./feeds/packages/lang/node-yarn
svn export https://github.com/nxhack/openwrt-node-packages/trunk/node-yarn feeds/packages/lang/node-yarn
ln -sf ../../../feeds/packages/lang/node-yarn ./package/feeds/packages/node-yarn
svn export https://github.com/nxhack/openwrt-node-packages/trunk/node-serialport-bindings-cpp feeds/packages/lang/node-serialport-bindings-cpp
ln -sf ../../../feeds/packages/lang/node-serialport-bindings-cpp ./package/feeds/packages/node-serialport-bindings-cpp

curl -O https://raw.githubusercontent.com/YnSen/Actions-OpenWrt/main/sh/scripts/02-remove_upx.sh
curl -O https://raw.githubusercontent.com/YnSen/Actions-OpenWrt/main/sh/scripts/03-convert_translation.sh
curl -O https://raw.githubusercontent.com/YnSen/Actions-OpenWrt/main/sh/scripts/04-create_acl_for_luci.sh
chmod 0755 *sh
./02-remove_upx.sh
./03-convert_translation.sh
./04-create_acl_for_luci.sh -a

cd ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt
cp ~/work/Actions-OpenWrt/Actions-OpenWrt/conf/uhttpr3p.config ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/
mv uhttpr3p.config .config

./scripts/feeds install -a

#添加kmod-inet-diag支持
cp ~/work/Actions-OpenWrt/Actions-OpenWrt/conf/inet-diag ./
sed -i '/\$(call KernelPackage,netlink-diag))/r inet-diag' package/kernel/linux/modules/netsupport.mk
rm -rf inet-diag

make defconfig
