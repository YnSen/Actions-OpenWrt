module("luci.controller.tencentddns",package.seeall)
function index()
entry({"admin", "services", "tencentcloud"}, firstchild(), "腾讯云设置", 30).dependent=false
entry({"admin", "services", "tencentcloud", "tencentddns"},cbi("tencentddns"),_("TencentDDNS"),2)
end
