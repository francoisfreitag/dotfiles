hl.config({
	ecosystem = {
		enforce_permissions = true,
		no_donation_nag = true,
		no_update_news = true,
	},
})
hl.permission({
	binary = "/usr/bin/grim",
	type = "screencopy",
	mode = "allow",
})
hl.permission({
	binary = "/usr/bin/hyprlock",
	type = "screencopy",
	mode = "allow",
})
hl.permission({
	binary = "/usr/bin/wf-recorder",
	type = "screencopy",
	mode = "allow",
})
hl.permission({
	binary = "/usr/lib/xdg-desktop-portal-hyprland",
	type = "screencopy",
	mode = "allow",
})
