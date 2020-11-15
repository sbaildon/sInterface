local A, ns = ...
local C = ns.C

if not C.actionbars.enabled then return end

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
