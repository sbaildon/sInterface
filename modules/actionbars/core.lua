local A, ns = ...
local E = ns.E

if not E:C('actionbars', 'enabled') then return end

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

local fader = {
	fadeInAlpha = 1,
	fadeInDuration = 0.3,
	fadeInSmooth = "OUT",
	fadeOutAlpha = 0,
	fadeOutDuration = 0.9,
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
	}

	return t
end

local bar1 = loader("bar1")
bar1["fader"] = faderOnShow

local bar2 = loader("bar2")
bar2["fader"] = faderOnShow

local bar3 = loader("bar3")
bar3["fader"] = faderOnShow

local bar4 = loader("bar4")
bar4["fader"] = faderOnShow

local bar5 = loader("bar5")
bar5["fader"] = faderOnShow

local petbar = loader("petbar")
petbar["fader"] = faderOnShow

local stancebar = loader("stancebar")
stancebar["fader"] = faderOnShow

local extrabar = loader("extrabar")
extrabar["fader"] = faderOnShow

local micromenubar = loader("micromenubar")
micromenubar["fader"] = fader

local bagbar = loader("bagbar")
bagbar["fader"] = fader

local vehicleexitbar = loader("vehicleexitbar")
vehicleexitbar["fader"] = faderOnShow

local possessexitbar = loader("possessexitbar")
possessexitbar["fader"] = faderOnShow

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
