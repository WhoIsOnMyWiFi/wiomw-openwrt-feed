module("luci.controller.wiomw", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/wiomw") then
		return
	end

	entry({"admin", "wiomw"}, firstchild(), _("Who Is On My WiFi"), 90).index=true
	entry({"admin", "wiomw", "login"}, template("wiomw/login"), _("Who Is On My WiFi Login"), 10)
--	entry({"admin", "wiomw", "advanced"}, cbi("wiomw/advanced"), _("WIOMW Advanced Settings"), 20)
--	entry({"admin", "wiomw", "logtail"}, template("wiomw/logtail"), _("WIOMW Agent Log"), 30)
	entry({"wiomw", "basic"}, cbi("wiomw/basic"), _("WIOMW Basic Settings"), 91).dependent=false

end
