-- Laptop screen pinned at the origin
hl.monitor({ output = "eDP-1", mode = "preferred", position = "0x0", scale = 1 })
-- Any other monitor: native resolution, placed to the right, scale from pixel density
hl.monitor({ output = "", mode = "preferred", position = "auto-right", scale = "auto" })
