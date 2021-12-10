git checkout v21.02.1
svn co https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
svn co https://github.com/coolsnowwolf/lede/trunk/tools/ucl tools/ucl


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
