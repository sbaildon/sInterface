local A, ns = ...
local C = ns.C

C["actionbars"] = {
	enabled = true,

	bar1 = {
		framePoint      = { "CENTER", UIParent, "BOTTOM", 0, 150 },
		frameScale      = 0.9,
		framePadding    = 5,
		buttonWidth     = 32,
		buttonHeight    = 32,
		buttonMargin    = 7,
		numCols         = 6,
		startPoint      = "BOTTOMLEFT",
		frameVisibility = "[petbattle] hide; [cursor][mod:ctrl, mod:alt][@vehicle,exists][overridebar][shapeshift][vehicleui][possessbar] show; hide",
		mouseover       = false,
	},

	bar2 = {
		framePoint      = { "TOPRIGHT", UIParent, "TOPRIGHT", -300, -250 },
		frameScale      = 0.9,
		framePadding    = 5,
		buttonWidth     = 32,
		buttonHeight    = 32,
		buttonMargin    = 7,
		numCols         = 6,
		startPoint      = "TOPLEFT",
		frameVisibility = "[cursor][mod:ctrl, mod:alt] show; hide",
		mouseover       = false,
	},

	bar3 = {
		framePoint      = { "TOPLEFT", A.."Bar2", "BOTTOMLEFT", 0, 0 },
		frameScale      = 0.9,
		framePadding    = 5,
		buttonWidth     = 32,
		buttonHeight    = 32,
		buttonMargin    = 7,
		numCols         = 6,
		startPoint      = "TOPLEFT",
		frameVisibility = "[cursor][mod:ctrl, mod:alt] show; hide",
		mouseover       = false,
	},

	bar4 = {
		framePoint      = { "TOPLEFT", A.."Bar3", "BOTTOMLEFT", 0, 0 },
		frameScale      = 0.9,
		framePadding    = 5,
		buttonWidth     = 32,
		buttonHeight    = 32,
		buttonMargin    = 7,
		numCols         = 6,
		startPoint      = "TOPLEFT",
		frameVisibility = "[cursor][mod:ctrl, mod:alt] show; hide",
		mouseover       = false,
	},

	bar5 = {
		framePoint      = { "TOPLEFT", A.."Bar4", "BOTTOMLEFT", 0, 0 },
		frameScale      = 0.9,
		framePadding    = 5,
		buttonWidth     = 32,
		buttonHeight    = 32,
		buttonMargin    = 7,
		numCols         = 6,
		startPoint      = "TOPLEFT",
		frameVisibility = "[cursor][mod:ctrl, mod:alt] show; hide",
		mouseover       = false,
	},

	possessexitbar = {
		framePoint      = { "BOTTOM", A.."VehicleExitBar", "TOP", 0, 5 },
		frameScale      = 0.95,
		framePadding    = 5,
		buttonWidth     = 32,
		buttonHeight    = 32,
		buttonMargin    = 7,
		numCols         = 1,
		startPoint      = "BOTTOMLEFT",
		frameVisibility = "show",
		mouseover       = false,
	},

	petbar = {
		framePoint      = { "TOPLEFT", A.."Bar5", "BOTTOMLEFT", 0, 0 },
		frameScale      = 0.9,
		framePadding    = 5,
		buttonWidth     = 32,
		buttonHeight    = 32,
		buttonMargin    = 7,
		numCols         = 6,
		startPoint      = "TOPLEFT",
		frameVisibility = "[cursor][pet, mod:ctrl, mod:alt] show; hide",
		mouseover       = false,
	},

	stancebar = {
		framePoint      = { "TOPLEFT", UIParent, "TOPLEFT", 0, 0 },
		frameScale      = 0.8,
		framePadding    = 5,
		buttonWidth     = 32,
		buttonHeight    = 32,
		buttonMargin    = 7,
		numCols         = 12,
		startPoint      = "BOTTOMLEFT",
		frameVisibility = "hide",
		mouseover       = false,
	},

	vehicleexitbar = {
		framePoint      = { "BOTTOMLEFT", "ChatFrame1", "TOPLEFT", 0, 70 },
		frameScale      = 0.95,
		framePadding    = 5,
		buttonWidth     = 36,
		buttonHeight    = 36,
		buttonMargin    = 7,
		numCols         = 1,
		startPoint      = "BOTTOMLEFT",
		frameVisibility = "show",
		mouseover       = false,
	},

	extrabar = {
		framePoint      = { "BOTTOM", UIParent, "BOTTOM", 0, 160 },
		frameScale      = 0.95,
		framePadding    = 0,
		buttonWidth     = 36,
		buttonHeight    = 36,
		buttonMargin    = 7,
		numCols         = 1,
		startPoint      = "CENTER",
		frameVisibility = "show",
		mouseover       = false,
	},

	bagbar = {
		framePoint      = { "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0, 0 },
		frameScale      = 1,
		framePadding    = 5,
		buttonWidth     = 32,
		buttonHeight    = 32,
		buttonMargin    = 2,
		numCols         = 1, --number of buttons per column
		startPoint      = "BOTTOMRIGHT", --start postion of first button: BOTTOMLEFT, TOPLEFT, TOPRIGHT, BOTTOMRIGHT
		frameVisibility = "hide",
		mouseover       = false
	},

	micromenubar = {
		framePoint      = { "BOTTOM", UIParent, "BOTTOM", 0, 0 },
		frameScale      = 0.8,
		framePadding    = 5,
		buttonWidth     = 28,
		buttonHeight    = 38,
		buttonMargin    = 0,
		numCols         = 12,
		startPoint      = "LEFT",
		frameVisibility = "show",
		mouseover       = true,
	}
}
