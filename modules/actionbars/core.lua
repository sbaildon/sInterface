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

local bar1 = E:C('actionbars', 'bar1')
bar1["fader"] = faderOnShow

local bar2 = E:C('actionbars', 'bar2')
bar2["fader"] = faderOnShow

local bar3 = E:C('actionbars', 'bar3')
bar3["fader"] = faderOnShow

local bar4 = E:C('actionbars', 'bar4')
bar4["fader"] = faderOnShow

local bar5 = E:C('actionbars', 'bar5')
bar5["fader"] = faderOnShow

local petbar = E:C('actionbars', 'petbar')
petbar["fader"] = faderOnShow

local stancebar = E:C('actionbars', 'stancebar')
stancebar["fader"] = faderOnShow

local extrabar = E:C('actionbars', 'extrabar')
extrabar["fader"] = faderOnShow

local micromenubar = E:C('actionbars', 'micromenubar')
micromenubar["fader"] = fader

local bagbar = E:C('actionbars', 'bagbar')
bagbar["fader"] = fader

local vehicleexitbar = E:C('actionbars', 'vehicleexitbar')
vehicleexitbar["fader"] = faderOnShow

local possessexitbar = E:C('actionbars', 'possessexitbar')
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
