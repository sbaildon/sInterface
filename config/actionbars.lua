local _, ns = ...
local C = ns.C

C["actionbars"] = {
	enabled = true,

	bar1 = { -- sInterfaceBar1
		position = { "TOPLEFT", UIParent, "TOPLEFT", C.general.edgeSpacing, -C.general.edgeSpacing},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift][cursor] show; hide",
		two_rows = true
	},

	bar2 = { --sInterfaceBar2
		position = { "TOPLEFT", "sInterfaceBar1", "BOTTOMLEFT", 0, -20},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift][cursor] show; hide",
		two_rows = true

	},

	bar3 = { --sInterfaceBar3
		position = { "TOPLEFT", "sInterfaceBar2", "BOTTOMLEFT", 0, -20},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift][cursor] show; hide",
		two_rows = true
	},

	bar4 = { --sInterfaceBar4
		position = { "TOPLEFT", "sInterfaceBar3", "BOTTOMLEFT", 0, -20},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift][cursor] show; hide",
		two_rows = true
	},

	bar5 = { --sInterfaceBar5
		position = { "TOPLEFT", "sInterfaceBar4", "BOTTOMLEFT", 0, -20},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift][cursor] show; hide",
		two_rows = true
	},

	petbar = { --sInterfacePetBar
		position = { "TOPLEFT", "sInterfaceBar5", "BOTTOMLEFT", 0, -20},
		visibility = "[petbattle][overridebar][vehicleui][possessbar,@vehicle,exists] hide; [modifier:ctrl,modifier:alt,modifier:shift,@pet,exists][cursor,@pet,exists] show; hide",
	},

	stancebar = { --sInterfaceStanceBar
		position = { "TOPLEFT", "sInterfacePetBar", "BOTTOMLEFT", 0, -20},
		visibility = "hide",
	},

	overridebar = { --sInterfaceOverrideBar
		position = { "BOTTOM", UIParent, "BOTTOM", 0, C.general.edgeSpacing*3},
		visibility = "[overridebar][vehicleui][possessbar,@vehicle,exists] show; hide"
	},

	vehicleexit = {
		position = {"TOPLEFT", "sInterfaceOverrideBar", "TOPRIGHT", 6, 0},
		visibility = "[overridebar][vehicleui][possessbar,@vehicle,exists] show; hide"
	},

	extrabar = { --sInterfaceExtraBar
		position = { "BOTTOM", UIParent, "BOTTOM", 0, C.general.edgeSpacing*6},
		visibility = "show"
	},

	bags = { --sInterfaceBagsBar
		position = { "TOP", UIParent, "TOP", 0, 0},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift] show; hide",
		show_all = false
	},

	micromenu = { --sInterfaceMicromenu
		position = { "TOP", "sInterfaceBagsBar", "BOTTOM", 0, 0},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift] show; hide",
		two_rows = true
	},
}
