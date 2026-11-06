-- ==========================================
-- Custom Autostart Applications & Daemons
-- ==========================================

-- Trigger when Hyprland initializes
hl.on("hyprland.start", function()
    -- Start the window switcher background daemon
    hl.exec_cmd("hyprshell run")
    
    -- NOTE: If you are using the older package, comment out the line above 
    -- by adding '--' and uncomment the line below:
    -- hl.exec_cmd("hyprswitch init --show-title &")
end)
