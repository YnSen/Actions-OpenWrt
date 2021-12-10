git checkout v21.02.1
svn co https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
svn co https://github.com/coolsnowwolf/lede/trunk/tools/ucl tools/ucl
# x86/64- immortalwrt uboot & target upstream
rm -rf ./target/linux/x86
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/target/linux/x86 target/linux/86
curl -sL https://github.com/immortalwrt/immortalwrt/raw/openwrt-21.02/package/kernel/linux/modules/video.mk > package/kernel/linux/modules/video.mk
