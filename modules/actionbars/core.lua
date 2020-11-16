local A, ns = ...
local E, C, UC = ns.E, ns.C, ns.UC

if not E:ValueOrFallback(C.actionbars.enabled, UC, 'actionbars', 'enabled') then return end

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

local bar1 = E:ValueOrFallback(C.actionbars.bar1, UC, 'actionbars', 'bar1')
bar1["fader"] = faderOnShow

local bar2 = E:ValueOrFallback(C.actionbars.bar2, UC, 'actionbars', 'bar2')
bar2["fader"] = faderOnShow

local bar3 = E:ValueOrFallback(C.actionbars.bar3, UC, 'actionbars', 'bar3')
bar3["fader"] = faderOnShow

local bar4 = E:ValueOrFallback(C.actionbars.bar4, UC, 'actionbars', 'bar4')
bar4["fader"] = faderOnShow

local bar5 = E:ValueOrFallback(C.actionbars.bar5, UC, 'actionbars', 'bar5')
bar5["fader"] = faderOnShow

local petbar = E:ValueOrFallback(C.actionbars.petbar, UC, 'actionbars', 'petbar')
petbar["fader"] = faderOnShow

local stancebar = E:ValueOrFallback(C.actionbars.stancebar, UC, 'actionbars', 'stancebar')
stancebar["fader"] = faderOnShow

local extrabar = E:ValueOrFallback(C.actionbars.extrabar, UC, 'actionbars', 'extrabar')
extrabar["fader"] = faderOnShow

local micromenubar = E:ValueOrFallback(C.actionbars.micromenubar, UC, 'actionbars', 'micromenubar')
micromenubar["fader"] = fader

local bagbar = E:ValueOrFallback(C.actionbars.bagbar, UC, 'actionbars', 'bagbar')
bagbar["fader"] = fader

local vehicleexitbar = E:ValueOrFallback(C.actionbars.vehicleexitbar, UC, 'actionbars', 'vehicleexitbar')
vehicleexitbar["fader"] = faderOnShow

local possessexitbar = E:ValueOrFallback(C.actionbars.possessexitbar, UC, 'actionbars', 'possessexitbar')
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
