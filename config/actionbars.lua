local _, ns = ...
local C = ns.C

C["actionbars"] = {
	enabled = true,

	bar1 = {
		position = { "TOPLEFT", UIParent, "TOPLEFT", C.general.edgeSpacing, -C.general.edgeSpacing},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift] show; hide",
		two_rows = true
	},

	bar2 = {
		position = { "TOPLEFT", "sInterfaceBar1", "BOTTOMLEFT", 0, -20},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift] show; hide",
		two_rows = true

	},

	bar3 = {
		position = { "TOPLEFT", "sInterfaceBar2", "BOTTOMLEFT", 0, -20},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift] show; hide",
		two_rows = true

	},

	bar4 = {
		position = { "TOPLEFT", "sInterfaceBar3", "BOTTOMLEFT", 0, -20},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift] show; hide",
		two_rows = true
	},

	bar5 = {
		position = { "TOPLEFT", "sInterfaceBar4", "BOTTOMLEFT", 0, -20},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift] show; hide",
		two_rows = true
	},

	stancebar = {
		position = { "TOPLEFT", "sInterfaceBar5", "BOTTOMLEFT", 0, -20},
		visibility = "hide",
	},

	overridebar = {
		position = { "BOTTOM", UIParent, "BOTTOM", 0, C.general.edgeSpacing},
		visibility = "[overridebar][vehicleui][possessbar,@vehicle,exists] show; hide"
	},

	vehicleexit = {
		position = {"TOPLEFT", "sInterfaceOverrideBar", "TOPRIGHT", 6, 0},
		visibility = "[overridebar][vehicleui][possessbar,@vehicle,exists] show; hide"
	},

	bags = {
		position = { "TOP", UIParent, "TOP", 0, 0},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift] show; hide",
		show_all = false
	},

	micromenu = {
		position = { "TOP", "sInterfaceBagsBar", "BOTTOM", 0, 0},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift] show; hide",
	},
}
