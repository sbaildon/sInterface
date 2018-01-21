local _, ns = ...
local E, C = ns.E, ns.C

if not C.actionbars.enabled then return end

local bar1 = CreateFrame("Frame", "sInterfaceActionBar1", UIParent, "SecureHandlerStateTemplate")
local bar2 = CreateFrame("Frame", "sInterfaceActionBar2", UIParent, "SecureHandlerStateTemplate")
local bar3 = CreateFrame("Frame", "sInterfaceActionBar3", UIParent, "SecureHandlerStateTemplate")
local bar4 = CreateFrame("Frame", "sInterfaceActionBar4", UIParent, "SecureHandlerStateTemplate")
local bar5 = CreateFrame("Frame", "sInterfaceActionBar5", UIParent, "SecureHandlerStateTemplate")

local possessbar = CreateFrame("Frame", "sInterfacePossessBar", UIParent, "SecureHandlerStateTemplate")
local extrabar = CreateFrame("Frame", "sInterfaceExtraBar", UIParent, "SecureHandlerStateTemplate")
local bags = CreateFrame("Frame", "sInterfaceBagsBar", UIParent)
local micromenu = CreateFrame("Frame", "sInterfaceMicromenu", UIParent)
local overridebar = CreateFrame("Frame", "sInterfaceOverrideBar", UIParent, "SecureHandlerStateTemplate")
local petbar = CreateFrame("Frame", "sInterfacePetBar", UIParent, "SecureHandlerStateTemplate")
local stancebar = CreateFrame("Frame", "sInterfaceStanceBar", UIParent, "SecureHandlerStateTemplate")

local bars = {}
bars.bar1 = bar1
bars.bar2 = bar2
bars.bar3 = bar3
bars.bar4 = bar4
bars.bar5 = bar5
bars.possessbar = possessbar
bars.extrabar = extrabar
bars.bags = bags
bars.micromenu = micromenu
bars.overridebar = overridebar
bars.petbar = petbar
bars.stancebar = stancebar

ns.sInterfaceBars = bars
