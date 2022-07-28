##offical uhttpr3p
# get source
git clone -b openwrt-21.02 https://github.com/openwrt/openwrt 
cd ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt

git checkout v21.02.3

./scripts/feeds update -a && ./scripts/feeds install -a

#ramips - immortalwrt uboot & target upstream
#rm -rf ./target/linux/ramips
#rm -rf ./package/boot/uboot-ramips
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/target/linux/ramips target/linux/ramips
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/boot/uboot-ramips package/boot/uboot-ramips

#curl -fL -o sdk.tar.xz https://downloads.openwrt.org/releases/21.02.1/targets/ramips/mt7621/openwrt-sdk-21.02.1-ramips-mt7621_gcc-8.4.0_musl.Linux-x86_64.tar.xz || wget -cO sdk.tar.xz https://downloads.openwrt.org/releases/21.02.1/targets/ramips/mt7621/openwrt-sdk-21.02.1-ramips-mt7621_gcc-8.4.0_musl.Linux-x86_64.tar.xz

# Max connection limite
sed -i 's/16384/65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

# 默认设置
#svn co https://github.com/YnSen/Actions-OpenWrt/trunk/default-settings package/default-settings
#pushd package/default-settings
#cp -r files ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/
#cd default/
#rm -rf zzz-default-settings
#rm -rf zzz-default-settingsnginx
#mv r3p zzz-default-settings
#popd

# 更换 golang 版本
rm -rf ./feeds/packages/lang/golang
svn export https://github.com/openwrt/packages/trunk/lang/golang feeds/packages/lang/golang

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

#softethervpn
rm -rf feeds/packages/net/softethervpn
rm -rf feeds/packages/net/softethervpn5
rm -rf feeds/luci/applications/luci-app-softether
rm -rf package/feeds/packages/softethervpn
rm -rf package/feeds/packages/softethervpn5
rm -rf package/feeds/luci/luci-app-softether
svn export https://github.com/immortalwrt/packages/branches/openwrt-21.02/net/softethervpn feeds/packages/net/softethervpn
svn export https://github.com/immortalwrt/packages/branches/openwrt-21.02/net/softethervpn5 feeds/packages/net/softethervpn5
svn export https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-softethervpn feeds/luci/applications/luci-app-softethervpn

pushd package/feeds/luci/
ln -sv ../../../feeds/luci/applications/luci-app-softethervpn ./
popd

pushd package/feeds/packages/
ln -sv ../../../feeds/packages/net/softethervpn ./
popd

pushd package/feeds/packages/
ln -sv ../../../feeds/packages/net/softethervpn5 ./
popd

#frp
rm -rf ./feeds/luci/applications/luci-app-frpc
rm -rf ./feeds/luci/applications/luci-app-frps
rm -rf ./feeds/packages/net/frp
rm -rf ./package/feeds/packages/frp
rm -rf ./package/feeds/luci/luci-app-frpc
rm -rf ./package/feeds/luci/luci-app-frps
svn export https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-frpc feeds/luci/applications/luci-app-frpc
pushd package/feeds/luci/
ln -sv ../../../feeds/luci/applications/luci-app-frpc ./
popd

svn export https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-frps feeds/luci/applications/luci-app-frps
pushd package/feeds/luci/
ln -sv ../../../feeds/luci/applications/luci-app-frps ./
popd

svn export https://github.com/immortalwrt/packages/branches/openwrt-21.02/net/frp feeds/packages/net/frp
pushd package/feeds/packages
ln -sv ../../../feeds/packages/net/frp ./
popd

#kodexplorer
#svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-kodexplorer feeds/luci/applications/luci-app-kodexplorer
#pushd package/feeds/luci
#ln -sv ../../../feeds/luci/applications/luci-app-kodexplorer ./
#popd


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
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-autoreboot feeds/luci/applications/luci-app-autoreboot
pushd package/feeds/luci/
ln -svln -sv ../../../feeds/luci/applications/luci-app-autoreboot ./
popd

svn export https://github.com/coolsnowwolf/packages/trunk/net/frp feeds/packages/net/frp
pushd package/feeds/packages/
ln -sv ../../../feeds/packages/net/frp ./
popd

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
svn export https://github.com/fw876/helloworld/trunk/dns2tcp package/lean/helloworld/dns2tcp
svn export https://github.com/fw876/helloworld/trunk/hysteria package/lean/helloworld/hysteria
svn export https://github.com/fw876/helloworld/trunk/sagernet-core package/lean/helloworld/sagernet-core
svn export https://github.com/immortalwrt/packages/branches/openwrt-21.02/net/dns2socks package/lean/helloworld/dns2socks
svn export https://github.com/immortalwrt/packages/branches/openwrt-21.02/net/microsocks package/lean/helloworld/microsocks
svn export https://github.com/fw876/helloworld/trunk/sagernet-core package/lean/helloworld/sagernet-core
rm -rf feeds/packages/net/xray-core
rm -rf package/feeds/packages/xray-core
cp -r package/lean/helloworld/xray-core feeds/packages/net/
pushd package/feeds/packages
ln -sv ../../../feeds/packages/net/xray-core
popd

# SSR Plus - deps
svn co https://github.com/coolsnowwolf/packages/trunk/net/redsocks2 package/lean/helloworld/redsocks2

#aliyundrive-webdav
svn co https://github.com/coolsnowwolf/packages/trunk/multimedia/aliyundrive-webdav feeds/packages/multimedia/aliyundrive-webdav
pushd package/feeds/packages
ln -sv ../../../feeds/packages/multimedia/aliyundrive-webdav ./
popd

svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-aliyundrive-webdav feeds/luci/applications/luci-app-aliyundrive-webdav
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-aliyundrive-webdav ./
popd


#OpenVpnServer
svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-openvpn-server feeds/luci/applications/luci-app-openvpn-server
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-openvpn-server ./
popd

#rclone
#svn co https://github.com/coolsnowwolf/packages/trunk/net/rclone feeds/packages/net/rclone
#pushd package/feeds/packages
#ln -sv ../../../feeds/packages/net/rclone ./
#popd

svn co https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-rclone feeds/luci/applications/luci-app-rclone
pushd package/feeds/luci
ln -sv ../../../feeds/luci/applications/luci-app-rclone ./
popd

#svn co https://github.com/coolsnowwolf/packages/trunk/net/rclone-ng feeds/packages/net/rclone-ng
#pushd package/feeds/packages
#ln -sv ../../../feeds/packages/net/rclone-ng ./
#popd

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

svn export https://github.com/coolsnowwolf/packages/trunk/net/pdnsd-alt feeds/packages/net/pdnsd-alt
pushd package/feeds/packages
ln -sv ../../../feeds/packages/net/pdnsd-alt ./
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

# FRP 内网穿透
rm -rf ./feeds/luci/applications/luci-app-frps
rm -rf ./feeds/luci/applications/luci-app-frpc
rm -rf ./feeds/packages/net/frp
rm -f ./package/feeds/packages/frp
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-frps package/lean/luci-app-frps
svn export https://github.com/coolsnowwolf/luci/trunk/applications/luci-app-frpc package/lean/luci-app-frpc
svn export https://github.com/coolsnowwolf/packages/trunk/net/frp package/lean/frp

# mjpg-streamer init
#sed -i "s,option port '8080',option port '1024',g" feeds/packages/multimedia/mjpg-streamer/files/mjpg-streamer.config
#sed -i "s,option fps '5',option fps '25',g" feeds/packages/multimedia/mjpg-streamer/files/mjpg-streamer.config
#sed -i "s,option www '/www/webcam',option www '/opt/webcam',g" feeds/packages/multimedia/mjpg-streamer/files/mjpg-streamer.config
# luci-app-mjpg-streamer
#rm -rf feeds/luci/applications/luci-app-mjpg-streamer
#git clone https://github.com/sbwml/luci-app-mjpg-streamer feeds/luci/applications/luci-app-mjpg-streamer


cd ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt
cp ~/work/Actions-OpenWrt/Actions-OpenWrt/conf/uhttpr3p.config ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/
mv uhttpr3p.config .config

#添加kmod-inet-diag支持
cp ~/work/Actions-OpenWrt/Actions-OpenWrt/conf/inet-diag ./
sed -i '/\$(call KernelPackage,netlink-diag))/r inet-diag' package/kernel/linux/modules/netsupport.mk
rm -rf inet-diag

make defconfig
