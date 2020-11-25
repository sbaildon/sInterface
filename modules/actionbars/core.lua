local A, ns = ...
local E = ns.E

if not E:C('actionbars', 'enabled') then return end

local faderOnShow = {
	fadeInAlpha = 1,
	fadeInDuration = 0.1,
	fadeInSmooth = "OUT",
	fadeOutAlpha = 0,
	fadeOutDuration = 0.2,
	fadeOutSmooth = "OUT",
	fadeOutDelay = 0,
	trigger = "OnShow",
}

local fader = {
	fadeInAlpha = 1,
	fadeInDuration = 0.1,
	fadeInSmooth = "OUT",
	fadeOutAlpha = 0,
	fadeOutDuration = 0.2,
	fadeOutSmooth = "OUT",
	fadeOutDelay = 0,
}

local function loader(name)
	local t = {
		framePoint      = E:C('actionbars', name, 'framePoint'),
		frameScale      = E:C('actionbars', name, 'frameScale'),
		framePadding    = E:C('actionbars', name, 'framePadding'),
		buttonWidth     = E:C('actionbars', name, 'buttonWidth'),
		buttonHeight    = E:C('actionbars', name, 'buttonHeight'),
		buttonMargin    = E:C('actionbars', name, 'buttonMargin'),
		numCols         = E:C('actionbars', name, 'numCols'),
		startPoint      = E:C('actionbars', name, 'startPoint'),
		frameVisibility = E:C('actionbars', name, 'frameVisibility'),
		fader           = E:C('actionbars', name, 'mouseover') and fader or faderOnShow
	}

	return t
end

local bar1 = loader("bar1")
local bar2 = loader("bar2")
local bar3 = loader("bar3")
local bar4 = loader("bar4")
local bar5 = loader("bar5")
local petbar = loader("petbar")
local stancebar = loader("stancebar")
local extrabar = loader("extrabar")
local micromenubar = loader("micromenubar")
local bagbar = loader("bagbar")
local vehicleexitbar = loader("vehicleexitbar")
local possessexitbar = loader("possessexitbar")

rActionBar:CreateActionBar1(A, bar1)
rActionBar:CreateActionBar2(A, bar2)
rActionBar:CreateActionBar3(A, bar3)
rActionBar:CreateActionBar4(A, bar4)
rActionBar:CreateActionBar5(A, bar5)
rActionBar:CreatePetBar(A, petbar)
rActionBar:CreateStanceBar(A, stancebar)
rActionBar:CreateBagBar(A, bagbar)
rActionBar:CreateMicroMenuBar(A, micromenubar)
rActionBar:CreateExtraBar(A, extrabar)
rActionBar:CreateVehicleExitBar(A, vehicleexitbar)
rActionBar:CreatePossessExitBar(A, possessexitbar)
