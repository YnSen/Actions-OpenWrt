uci set mosdns.config.redirect='0'
uci commit mosdns
/etc/init.d/mosdns start
sleep 3
uci set mosdns.config.redirect='1'
uci commit mosdns
/etc/init.d/mosdns restart
