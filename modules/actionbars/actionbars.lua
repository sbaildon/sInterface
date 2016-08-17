local A, L = ...

local fader = {
	fadeInAlpha = 1,
	fadeInDuration = 0.3,
	fadeInSmooth = "OUT",
	fadeOutAlpha = 0.3,
	fadeOutDuration = 0.9,
	fadeOutSmooth = "OUT",
}

local bagbar = {
	framePoint = { "BOTTOM", UIParent, "BOTTOM", 0, -5 },
	frameScale = 1,
	framePadding = 5,
	frameVisibility = "[modifier:ctrl,modifier:shift] show; hide",
	buttonWidth = 32,
	buttonHeight = 32,
	buttonMargin = 2,
	numCols = 6,
	startPoint = "BOTTOMLEFT",
	fader = fader,
}
rActionBar:CreateBagBar(A, bagbar)

local bar1 = {
	framePoint = { "RIGHT", UIParent, "RIGHT", -GetScreenWidth()/15, 0 },
	frameScale = 1,
	framePadding = 5,
	frameVisibility = "[modifier:ctrl,modifier:shift,modifier:alt][cursor][vehicleui][possessbar] show; hide",
	buttonWidth = 32,
	buttonHeight = 32,
	buttonMargin = 5,
	numCols = 6,
	startPoint = "TOPLEFT",
	fader = fader,
}
rActionBar:CreateActionBar1(A, bar1)

local bar2 = {
	framePoint = { "TOP", A.."Bar1", "BOTTOM", 0, -10 },
	frameScale = 1,
	framePadding = 5,
	frameVisibility = "[modifier:ctrl,modifier:shift,modifier:alt][cursor] show; hide",
	buttonWidth = 32,
	buttonHeight = 32,
	buttonMargin = 5,
	numCols = 6,
	startPoint = "TOPLEFT",
	fader = fader,
}
rActionBar:CreateActionBar2(A, bar2)

local bar3 = {
	framePoint = { "TOP", A.."Bar2", "BOTTOM", 0, -10 },
	frameScale = 1,
	framePadding = 5,
	frameVisibility = "[modifier:ctrl,modifier:shift,modifier:alt][cursor] show; hide",
	buttonWidth = 32,
	buttonHeight = 32,
	buttonMargin = 5,
	numCols = 6,
	startPoint = "TOPLEFT",
	fader = fader,
}
rActionBar:CreateActionBar3(A, bar3)

local petbar = {
	framePoint = { "BOTTOM", A.."Bar1", "TOP", 0, 0 },
	frameScale = 1,
	framePadding = 5,
	frameVisibility = "[cursor,pet] show; hide",
	buttonWidth = 32,
	buttonHeight = 32,
	buttonMargin = 5,
	numCols = 6,
	startPoint = "TOPLEFT",
	fader = fader,
}
rActionBar:CreatePetBar(A, petbar)

local vehicleexitbar = {
	framePoint = { "TOPLEFT", A.."Bar1", "TOPRIGHT", 0, 0 },
	frameScale = 1,
	framePadding = 5,
	frameVisibility = "[cursor][vehicleui][possessbar] show; hide",
	buttonWidth = 32,
	buttonHeight = 32,
	buttonMargin = 5,
	numCols = 1,
	startPoint = "BOTTOMLEFT",
	fader = fader,
}
rActionBar:CreateVehicleExitBar(A, vehicleexitbar)
