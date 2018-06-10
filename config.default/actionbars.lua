local _, ns = ...
local C = ns.C

C["actionbars"] = {
	enabled = true,

	bar1 = { -- sInterfaceActionBar1
		position = { "TOPLEFT", UIParent, "TOPLEFT", C.general.edgeSpacing, -(C.general.edgeSpacing*15)},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift][cursor][possessbar] show; hide",
		two_rows = true
	},

	bar2 = { --sInterfaceActionBar2
		position = { "TOPLEFT", "sInterfaceActionBar1", "BOTTOMLEFT", 0, -20},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift][cursor] show; hide",
		two_rows = true,
		enabled = true,
	},

	bar3 = { --sInterfaceActionBar3
		position = { "TOPLEFT", "sInterfaceActionBar2", "BOTTOMLEFT", 0, -20},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift][cursor] show; hide",
		two_rows = true,
		enabled = true,
	},

	bar4 = { --sInterfaceActionBar4
		position = { "TOPLEFT", "sInterfaceActionBar3", "BOTTOMLEFT", 0, -20},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift][cursor] show; hide",
		two_rows = true,
		enabled = true,
	},

	bar5 = { --sInterfaceActionBar5
		position = { "TOPLEFT", "sInterfaceActionBar4", "BOTTOMLEFT", 0, -20},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift][cursor] show; hide",
		two_rows = true,
		enabled = true,
	},

	possessbar = { --sInterfacePossessBar
		position = { "BOTTOMLEFT", "sInterfaceActionBar1", "TOPLEFT", 0, 20},
		visibility = "[possessbar] show; hide",
	},

	petbar = { --sInterfacePetBar
		position = { "TOPLEFT", "sInterfaceActionBar5", "BOTTOMLEFT", 0, -20},
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
		position = { "BOTTOMLEFT", "sInterfaceMicromenu", "BOTTOMRIGHT", -25, 0},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift] show; hide",
		show_all = false
	},

	micromenu = { --sInterfaceMicromenu
		position = { "TOP", UIParent, "TOP", 0, -C.general.edgeSpacing},
		visibility = "[modifier:ctrl, modifier:alt, modifier:shift] show; hide",
		two_rows = true
	},
}
