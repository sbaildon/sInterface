local A, ns = ...
local C = ns.C

if not C.actionbars.enabled then return end

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

C.actionbars.bar1["fader"] = faderOnShow
C.actionbars.bar2["fader"] = faderOnShow
C.actionbars.bar3["fader"] = faderOnShow
C.actionbars.bar4["fader"] = faderOnShow
C.actionbars.bar5["fader"] = faderOnShow
C.actionbars.petbar["fader"] = faderOnShow
C.actionbars.extrabar["fader"] = faderOnShow
C.actionbars.micromenubar["fader"] = fader


rActionBar:CreateActionBar1(A, C.actionbars.bar1)
rActionBar:CreateActionBar2(A, C.actionbars.bar2)
rActionBar:CreateActionBar3(A, C.actionbars.bar3)
rActionBar:CreateActionBar4(A, C.actionbars.bar4)
rActionBar:CreateActionBar5(A, C.actionbars.bar5)
rActionBar:CreatePetBar(A, C.actionbars.petbar)
rActionBar:CreateStanceBar(A, C.actionbars.stancebar)
rActionBar:CreateBagBar(A, C.actionbars.bagbar)
rActionBar:CreateMicroMenuBar(A, C.actionbars.micromenubar)
rActionBar:CreateExtraBar(A, C.actionbars.extrabar)
rActionBar:CreateVehicleExitBar(A, C.actionbars.vehicleexitbar)
rActionBar:CreatePossessExitBar(A, C.actionbars.possessexitbar)
