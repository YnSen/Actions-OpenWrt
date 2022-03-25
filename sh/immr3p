#get source
git clone https://github.com/immortalwrt/immortalwrt.git openwrt
cd ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt
./scripts/feeds update -a && ./scripts/feeds install -a

# Modify default IP
sed -i 's/192.168.1.1/192.168.2.1/g' package/base-files/files/bin/config_generate
sed -i 's/bootstrap/argon/g' feeds/luci/collections/luci/Makefile
cd ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt
cp ~/work/Actions-OpenWrt/Actions-OpenWrt/conf/immr3p.config ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/
mv immr3p.config .config
make defconfig
