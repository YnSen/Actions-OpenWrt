git checkout v21.02.0
#Add immortal appsource
#sed -i '$a src-git luciim https://github.com/immortalwrt/luci.git^6f24422' feeds.conf.default
#src-git passwall https://github.com/xiaorouji/openwrt-passwall.git
#change luci
sed -i 's/https://git.openwrt.org/project/luci.git^3b3c2e5f9f82372df8ff01ac65668be47690dcd5/https://github.com/immortalwrt/luci.git^6f24422/g' feeds.conf.default
