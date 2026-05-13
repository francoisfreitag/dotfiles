------------------
---- MONITORS ----
------------------
require("config.monitors")

---------------------
---- MY PROGRAMS ----
---------------------
local terminal = "foot"
local fileManager = "yazi"
local menu = "fuzzel"

-------------------
---- AUTOSTART ----
-------------------
require("config.autostart")

-----------------------
----- PERMISSIONS -----
-----------------------
require("config.permissions")

-----------------------
---- LOOK AND FEEL ----
-----------------------
require("config.look")

----------------
----  MISC  ----
----------------

hl.config({
	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
	},
})

hl.config({
	xwayland = {
		force_zero_scaling = true,
	},
})

---------------
---- INPUT ----
---------------
require("config.input")

---------------------
---- KEYBINDINGS ----
---------------------
require("config.keybindings")

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------
require("config.windows")
