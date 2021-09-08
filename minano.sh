#ssrplus
git clone https://github.com/fw876/helloworld.git
#自动关机插件
git clone https://github.com/sirpdboy/luci-app-autopoweroff

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.1/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/192.168.3.1/g' package/base-files/files/bin/config_generate
# Modify default PassWord
#sed -i 's/root::0:0:99999:7:::/root:$1$ScQIGKsX$q0qEf\/tAQ2wpTR6zIUIjo.:0:0:99999:7:::/g' package/base-files/files/etc/shadow
#删除默认密码
sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings
