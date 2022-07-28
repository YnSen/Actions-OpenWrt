#!/bin/bash

# 内核加解密组件
echo '
CONFIG_CRYPTO_AES_NI_INTEL=y
' >>./target/linux/x86/64/config-5.4

#Vermagic
wget https://downloads.openwrt.org/releases/21.02.3/targets/x86/64/packages/Packages.gz
zgrep -m 1 "Depends: kernel (=.*)$" Packages.gz | sed -e 's/.*-\(.*\))/\1/' >.vermagic
sed -i -e 's/^\(.\).*vermagic$/\1cp $(TOPDIR)\/.vermagic $(LINUX_DIR)\/.vermagic/' include/kernel-defaults.mk

chmod -R 755 ./
find ./ -name *.orig | xargs rm -f
find ./ -name *.rej | xargs rm -f

exit 0