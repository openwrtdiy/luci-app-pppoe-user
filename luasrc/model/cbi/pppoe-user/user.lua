m = Map("pppoe-user", translate(""), translate(""))

local count = luci.sys.exec("grep -c 'config user' /etc/config/pppoe-user")
s = m:section(TypedSection, "user", translate("User number [ " .. count .. "]"), translate(""))
s.addremove = true
s.anonymous = true
s.nodescriptions = true
s.sortable  = false
s.template = "cbi/tblsection"

o = s:option(Flag, "enabled", translate("Enabled"))
o.rmempty = false

o = s:option(Value, "username", translate("User Name"))
o.placeholder = translate("Username")
o.rmempty = true

o = s:option(Value, "password", translate("Password"))
o.placeholder = translate("Password")
o.default = os.date("%Y%m%d")
o.password = true
o.rmempty = false

o = s:option(Value, "servicename", translate("Service Name"))
o.placeholder = translate("Automatically")
o.default = "*"
o.rmempty = true
function o.cfgvalue(e, t)
    value = e.map:get(t, "servicename")
    return value == "*" and "" or value
end
function o.remove(e, t) Value.write(e, t, "*") end

o = s:option(Value, "ipaddress", translate("IP address"))
o.placeholder = translate("Automatically")
o.datatype = "ipaddr"
o.rmempty = true
function o.cfgvalue(e, t)
    value = e.map:get(t, "ipaddress")
    return value == "*" and "" or value
end
function o.remove(e, t) Value.write(e, t, "*") end

return m
