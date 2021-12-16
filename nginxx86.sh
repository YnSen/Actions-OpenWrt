##offical nginx x86

# get source

git clone https://github.com/openwrt/openwrt -b openwrt-21.02

cd ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt

git checkout v21.02.1

./scripts/feeds update -a && ./scripts/feeds install -a

cp ~/work/Actions-OpenWrt/Actions-OpenWrt/patch/652-netfilter-flow_offload-add-check-ifindex.patch ~/work/Actions-OpenWrt/Actions-OpenWrt/openwrt/target/linux/generic/hack-5.4/652-netfilter-flow_offload-add-check-ifindex.patch

pushd target/linux/generic/hack-5.4

chmod +x 652-netfilter-flow_offload-add-check-ifindex.patch

git appply 652-netfilter-flow_offload-add-check-ifindex.patch

popd

# Drop uhttpd

#pushd feeds/luci

#curl -s https://raw.githubusercontent.com/YnSen/Actions-OpenWrt/main/patch/0002-feeds-luci-Drop-uhttpd-depends.patch > 0002-feeds-luci-Drop-uhttpd-depends.patch

#git apply 0002-feeds-luci-Drop-uhttpd-depends.patch && rm 0002-feeds-luci-Drop-uhttpd-depends.patch

#popd

# Update nginx-1.20.2

#pushd feeds/packages

#curl -s https://raw.githubuserconten
