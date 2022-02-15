#!/bin/bash
RED_COLOR='\e[1;31m'
GREEN_COLOR='\e[1;32m'
YELLOW_COLOR='\e[1;33m'
BLUE_COLOR='\e[1;34m'
PINK_COLOR='\e[1;35m'
SHAN='\e[1;33;5m'
RES='\e[0m'

# Start time
starttime=`date +'%Y-%m-%d %H:%M:%S'`
# Cpus
cores=`expr $(nproc --all) + 1`

# Adguardhome
export adguardhome_version="0.107.3"

# kenrel vermagic - rockchip https://downloads.openwrt.org/releases/21.02.1/targets/rockchip/armv8/kmods/
kenrel_vermagic=fb881fbbae69f30da18e7c6eb01310c1

# mirror
export mirror=api.cooluc.com

# Source branch
if [ "$1" = "dev" ];then
    branch=openwrt-21.02
    export version=snapshots
elif [ "$1" = "stable" ];then
    latest_release="$(curl -s "https://api.github.com/repos/openwrt/openwrt/tags" | grep "name" | head -n 1 | awk -F ":" '{print $2}' | sed 's/\"//g;s/,//g;s/ //g')"
    branch=$latest_release
    export version=releases
elif [ -z "$1" ];then
    branch=openwrt-21.02
    export version=snapshots
fi

echo -e "\r\n${GREEN_COLOR}Build $version ...${RES}\r\n"

# get source
git clone https://github.com/openwrt/openwrt -b $branch
cd openwrt

# tags
git describe --abbrev=0 --tags > version.txt
cat version.txt
echo

# sync vermagic
echo $kenrel_vermagic > .vermagic
sed -ie 's/^\(.\).*vermagic$/\1cp $(TOPDIR)\/.vermagic $(LINUX_DIR)\/.vermagic/' include/kernel-defaults.mk

# feeds mirror
ip_info=`curl -s https://ip.cooluc.com`;
export isCN=`echo $ip_info | grep -Po 'country_code\":"\K[^"]+'`;
if [ "$isCN" = "CN" ];then
    if [ "$1" = "stable" ];then
        packages="^$(cat feeds.conf.default | grep packages | awk -F^ '{print $2}')"
        luci="^$(cat feeds.conf.default | grep luci | awk -F^ '{print $2}')"
        routing="^$(cat feeds.conf.default | grep routing | awk -F^ '{print $2}')"
        telephony="^$(cat feeds.conf.default | grep telephony | awk -F^ '{print $2}')"
    else
        packages=";$branch"
        luci=";$branch"
        routing=";$branch"
        telephony=";$branch"
    fi
    cat > feeds.conf <<EOF
src-git packages https://github.com/openwrt/packages.git$packages
src-git luci https://github.com/openwrt/luci.git$luci
src-git routing https://github.com/openwrt/routing.git$routing
src-git telephony https://github.com/openwrt/telephony.git$telephony
EOF
fi

# Init feeds
./scripts/feeds update -a
./scripts/feeds install -a

# loader dl
if [ -f ../dl.gz ];then
    tar xf ../dl.gz -C .
fi

# Restart DDNS Service
sed -i "/exit 0/i\/etc/init.d/ddns restart\r\n" package/base-files/files/etc/rc.local

# default LAN IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# Drop uhttpd
pushd feeds/luci
curl -s https://api.cooluc.com/openwrt/patch/0002-feeds-luci-Drop-uhttpd-depends.patch > 0002-feeds-luci-Drop-uhttpd-depends.patch
git apply 0002-feeds-luci-Drop-uhttpd-depends.patch && rm 0002-feeds-luci-Drop-uhttpd-depends.patch
popd

# Update nginx to latest version
if [ "$1" = "stable" ];then
    nginx_tag=nginx-1.20
else
    nginx_tag=nginx-1.21
fi
mkdir -p dl
if [ "$isCN" = "CN" ];then
    nginx_version=`curl -s https://mirrors.huaweicloud.com/nginx/ | grep $nginx_tag | sed -e '/onclick/d' | sed -n '$p'|awk -F\" '{print $2}' | awk -F".zip.asc" '{print $1}' | awk -F- '{print $2}'`
    curl -o dl/nginx-$nginx_version.tar.gz https://mirrors.huaweicloud.com/nginx/nginx-$nginx_version.tar.gz
else
    nginx_version=`curl -s https://nginx.org/download/ | grep $nginx_tag | sed -n '$p'|awk -F\" '{print $2}' | awk -F".zip.asc" '{print $1}' | awk -F- '{print $2}'`
    curl -o dl/nginx-$nginx_version.tar.gz https://nginx.org/download/nginx-$nginx_version.tar.gz
fi
if [ -f "dl/nginx-$nginx_version.tar.gz" ];then
    nginx_hash=`sha256sum dl/nginx-$nginx_version.tar.gz | awk -F" " '{print $1}'`
    sed -ri "s/(PKG_VERSION:=)[^\"]*/\1$nginx_version/" feeds/packages/net/nginx/Makefile
    sed -ri "s/(PKG_HASH:=)[^\"]*/\1$nginx_hash/" feeds/packages/net/nginx/Makefile
fi

# UPX
if ! command -v upx >/dev/null 2>&1; then
    if [ ! "$(uname)" == "Darwin" ];then
        sed -i '/patchelf pkgconf/i\tools-y += ucl upx' ./tools/Makefile
        sed -i '\/autoconf\/compile :=/i\$(curdir)/upx/compile := $(curdir)/ucl/compile' ./tools/Makefile
        svn co https://github.com/immortalwrt/immortalwrt/branches/master/tools/upx tools/upx
        svn co https://github.com/immortalwrt/immortalwrt/branches/master/tools/ucl tools/ucl
    fi
else
    mkdir -p staging_dir/host/bin/
    ln -sf `which upx` staging_dir/host/bin/upx
fi

# scripts
curl -O https://api.cooluc.com/openwrt/scripts/00-prepare_base.sh
curl -O https://api.cooluc.com/openwrt/scripts/01-prepare_package.sh
#curl -O https://api.cooluc.com/openwrt/scripts/02-remove_upx.sh
curl -O https://api.cooluc.com/openwrt/scripts/03-convert_translation.sh
curl -O https://api.cooluc.com/openwrt/scripts/04-create_acl_for_luci.sh
curl -O https://api.cooluc.com/openwrt/scripts/99_clean_build_cache.sh
chmod 0755 *sh
./00-prepare_base.sh
./01-prepare_package.sh
#./02-remove_upx.sh
./04-create_acl_for_luci.sh -a
./03-convert_translation.sh

# Load Multiple devices Config
curl -s https://api.cooluc.com/openwrt/config-musl > .config
make defconfig

# Compile
make -j$cores

# Compile time
endtime=`date +'%Y-%m-%d %H:%M:%S'`
start_seconds=$(date --date="$starttime" +%s);
end_seconds=$(date --date="$endtime" +%s);
SEC=$((end_seconds-start_seconds));
if [ -f bin/targets/rockchip/armv8/openwrt-rockchip-armv8-friendlyarm_nanopi-r4s-ext4-sysupgrade.img.gz ];then
    echo -e " ${GREEN_COLOR}Build success! ${RES}"
    echo -e " Build time: $(( SEC / 3600 ))h,$(( (SEC % 3600) / 60 ))m,$(( (SEC % 3600) % 60 ))s"
    # Backup download cache
    if [ "$isCN" = "CN" ];then
        rm -rf dl/xray* dl/trojan* dl/v2ray* dl/adguardhome* dl/alist*
        tar cf ../dl.gz dl
    fi
    exit 0
else
    #make -j1 V=s
    echo -e " ${RED_COLOR}Build error... ${RES}"
    echo -e " Build time: $(( SEC / 3600 ))h,$(( (SEC % 3600) / 60 ))m,$(( (SEC % 3600) % 60 ))s"
fi
