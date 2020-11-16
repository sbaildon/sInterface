local A, ns = ...
local C = ns.C

local fader = {
	fadeInAlpha = 1,
	fadeInDuration = 0.3,
	fadeInSmooth = "OUT",
	fadeOutAlpha = 0,
	fadeOutDuration = 0.9,
	fadeOutSmooth = "OUT",
	fadeOutDelay = 0,
      }

local faderOnShow = {
	fadeInAlpha = 1,
	fadeInDuration = 0.3,
	fadeInSmooth = "OUT",
	fadeOutAlpha = 0,
	fadeOutDuration = 0.9,
	fadeOutSmooth = "OUT",
	fadeOutDelay = 0,
	trigger = "OnShow",
}

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
		fader           = faderOnShow,
		frameVisibility = "[petbattle] hide; [cursor][mod:ctrl, mod:alt][@vehicle,exists][overridebar][shapeshift][vehicleui][possessbar] show; hide"
	},

	bar2 = {
		framePoint      = { "TOPLEFT", UIParent, "TOPLEFT", 100, -200 },
		frameScale      = 0.9,
		framePadding    = 5,
		buttonWidth     = 32,
		buttonHeight    = 32,
		buttonMargin    = 7,
		numCols         = 6,
		startPoint      = "TOPLEFT",
		fader           = faderOnShow,
		frameVisibility = "[cursor][mod:ctrl, mod:alt] show; hide"
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
		fader           = faderOnShow,
		frameVisibility = "[cursor][mod:ctrl, mod:alt] show; hide"
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
		fader           = faderOnShow,
		frameVisibility = "[cursor][mod:ctrl, mod:alt] show; hide"
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
		fader           = faderOnShow,
		frameVisibility = "[cursor][mod:ctrl, mod:alt] show; hide"
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
		fader           = nil,
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
		fader           = faderOnShow,
		frameVisibility = "[cursor][pet, mod:ctrl, mod:alt] show; hide"
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
		fader           = nil,
		frameVisibility = "show"
		-- frameVisibility = "[petbattle][overridebar][vehicleui][possessbar][shapeshift][nomod] hide; show"
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
		fader           = nil,
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
		fader           = nil,
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
		fader           = fader,
		frameVisibility = "hide"
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
		fader           = fader,
	}
}
