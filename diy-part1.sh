git checkout v21.02.0
#Add immortal appsource
sed -i '$a src-git luciim https://github.com/immortalwrt/luci.git^6f24422' feeds.conf.default
#src-git passwall https://github.com/xiaorouji/openwrt-passwall.git
