hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

hl.window_rule({ match = { class = "foot" }, workspace = "1", border_size = 1, rounding = 0 })
hl.window_rule({ match = { class = "firefox-developer-edition" }, workspace = "2" })
hl.window_rule({ match = { title = "Meet –.*$" }, idle_inhibit = "focus" })
hl.window_rule({ match = { title = "Dev Standup –.*$" }, idle_inhibit = "focus" })
hl.window_rule({ match = { class = "chromium" }, workspace = "3" })
hl.window_rule({ match = { class = "org.telegram.desktop" }, workspace = "4" })
hl.window_rule({ match = { class = "signal" }, workspace = "4" })
hl.window_rule({ match = { class = "SoliumInfernum" }, workspace = "5", fullscreen = true })
hl.window_rule({ match = { class = "org.keepassxc.KeePassXC" }, workspace = "10", no_screen_share = true })

hl.layer_rule({ match = { namespace = "launcher" }, blur = true, dim_around = true })
