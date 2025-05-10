local ts = vim.treesitter

-- Define the Cisco IOS syntax highlighting rules
local cisco_syntax = {
  keywords = {
    "speed", "duplex", "negotiation", "delay", "bandwidth",
    "preempt", "priority", "timers", "logging", "log", "login",
    "password", "username", "user", "license", "host", "hostname",
    "system", "address", "network", "route", "neighbor", "redistribute",
    "default-gateway", "community", "version", "class", "switchport",
    "clock", "name", "minimum", "maximum", "level", "size",
    "established", "source", "destination", "allowed", "timeout",
    "threshold", "frequency", "keepalive", "average", "weights",
    "mtu", "tunnel", "privilege", "secret"
  },
  protocols = {
    "ipv4", "ipv6", "tcp", "udp", "icmp", "echo", "http", "https", "www",
    "dhcp", "domain", "nameserver", "ssh", "telnet", "ftp", "ftp-data",
    "ntp", "snmp", "snmptrap", "syslog", "smtp", "pop2", "pop3",
    "klogin", "kshell", "login", "rlogin", "sunrpc", "mpls", "rip",
    "isis", "ospf", "ospfv3", "eigrp", "bgp", "hsrp", "vrrp",
    "ipsla", "isdn", "dial", "hdlc", "frame-relay", "atm",
    "igmp", "multicast", "broadcast", "rsa", "pki", "isakmp",
    "ipsec", "ike", "esp", "gre", "vpn", "mvpn", "pppoe",
    "qos", "cef", "pim", "ahp", "tacacs", "cdp", "lldp", "vtp",
    "spanning-tree", "lacp", "dot1Q", "l2tun", "ethernet", "aaa",
    "aaa-server"
  },
  configure = {
    "activate", "set", "default", "redundancy", "prefer", "ron",
    "tag", "inside", "outside", "input", "output", "static",
    "export", "import"
  },
  functions = {
    "service", "crypto", "encapsulation", "standby", "mode",
    "in", "out", "storm-control", "snmp-server", "group",
    "nat", "banner", "mask", "seq", "metric", "add-route",
    "shape", "rd", "route-target", "as-path", "remote-as",
    "access-list", "access-class", "access-group", "prefix-list",
    "passive-interface", "distribute-list", "permit", "subnet-zero"
  },
  comments = { "!", "no ", "description", "remark", "#" },
  strings = { "\"[^\"]*\"" },
  interfaces = {
    "^interface", "^vlan", "^line", "^router", "^track", "^ip sla",
    "^ip vrf", "^monitor session", "^class-map", "^policy-map",
    "^route-map", "^ip access-list", "^vrf definition", "^vrf context",
    "^address-family ipv"
  },
  actions = { "disable", "deny", "shutdown", "down", "none" },
  variables = { "trunk", "access", "full", "full-duplex", "auto",
    "active", "monitor", "any", "enable", "disable",
    "pvst", "mst", "rapid-pvst", "transparent", "server", "client" },
  ipv4 = [[\b(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(?:\/[0-9]{1,2})?\b]],
  ipv6 = [[\b(?:[a-fA-F0-9]{1,4}:){7,7}[a-fA-F0-9]{1,4}|\b(?:[a-fA-F0-9]{1,4}:){1,7}:|\b(?:[a-fA-F0-9]{1,4}:){1,6}:[a-fA-F0-9]{1,4}|\b(?:[a-fA-F0-9]{1,4}:){1,5}(?::[a-fA-F0-9]{1,4}){1,2}|\b(?:[a-fA-F0-9]{1,4}:){1,4}(?::[a-fA-F0-9]{1,4}){1,3}|\b(?:[a-fA-F0-9]{1,4}:){1,3}(?::[a-fA-F0-9]{1,4}){1,4}|\b(?:[a-fA-F0-9]{1,4}:){1,2}(?::[a-fA-F0-9]{1,4}){1,5}|\b[a-fA-F0-9]{1,4}:(?::[a-fA-F0-9]{1,4}){1,6}|\b::(?:[a-fA-F0-9]{1,4}){1,7}\b]]
}

-- Define highlighting
vim.api.nvim_set_hl(0, "CiscoKeyword", { link = "Statement" })
vim.api.nvim_set_hl(0, "CiscoProtocol", { link = "Type" })
vim.api.nvim_set_hl(0, "CiscoAction", { link = "Error" })
vim.api.nvim_set_hl(0, "CiscoFunction", { link = "Function" })
vim.api.nvim_set_hl(0, "CiscoLabel", { link = "Identifier" })
vim.api.nvim_set_hl(0, "CiscoComment", { link = "Comment" })
vim.api.nvim_set_hl(0, "CiscoString", { link = "String" })
vim.api.nvim_set_hl(0, "CiscoVar", { link = "String" })
vim.api.nvim_set_hl(0, "CiscoConfigure", { link = "Identifier" })
vim.api.nvim_set_hl(0, "CiscoInterface", { link = "Underlined" })
vim.api.nvim_set_hl(0, "CiscoIpv4", { link = "Underlined" })
vim.api.nvim_set_hl(0, "CiscoIpv6", { link = "Underlined" })

-- Register Cisco Treesitter parser
ts.language.register("cisco", "cisco")

return cisco_syntax
