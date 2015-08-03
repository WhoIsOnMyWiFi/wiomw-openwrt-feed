m = Map("wiomw", translate("Who Is On My WiFi"))
s = m:section(NamedSection, "agent", "wiomw-agent", translate("Basic Settings"))
s:option(Value, "pubtoken", translate("Public Token"))
s:option(Value, "privtoken", translate("Private Token"))
s:option(Value, "agentkey", translate("Agent Key"))
return m
