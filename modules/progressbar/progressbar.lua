local _, ns = ...
local E, C = ns.E, ns.C

if not C.progressBars.enabled then return end;

local ProgressBars = CreateFrame('Frame', 'sInterfaceProgressBars', UIParent)
ProgressBars:SetPoint("TOPLEFT", Minimap, "BOTTOMLEFT", 0, -10)
ProgressBars:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 0, -10)
ProgressBars:SetHeight(50)

local registeredBars = {}

local function getObject(barName)
	for key, value in pairs(registeredBars) do
		if key == barName then
			return value
		end
	end

	return false
end

local function getBar(barName)
	local obj = getObject(barName)
	return obj and obj.bar or false
end

local function getEnabled(barName)
	local obj = getObject(barName)
	return obj and obj.enabled or false
end

local function reposition()
	local prevElement
	for key, element in pairs(registeredBars) do
		if element.enabled then
			print(key, "is enabled")
			local something = element.bar
			if (prevElement == nil) then
				something:SetPoint("TOP", ProgressBars, "TOP")
			else
				something:SetPoint("TOP", prevElement, "BOTTOM", 0, -C.progressBars.spacing)
			end

			prevElement = something
		end
	end
end

function ProgressBars:RegisterBar(barName)
	local holder = CreateFrame("Frame", "holder", UIParent)
	holder:SetHeight(C.progressBars.reputation.height)
	holder:SetPoint("LEFT", ProgressBars, "LEFT")
	holder:SetPoint("RIGHT", ProgressBars, "RIGHT")
	holder:SetScript("OnEvent", reputationVisibility)
	E:ShadowedBorder(holder)

	local statusBar = CreateFrame("StatusBar", "ProgressBar", holder)
	statusBar:SetAllPoints(holder)
	statusBar:SetStatusBarTexture(C.general.texture, "ARTWORK")
	holder.StatusBar = statusBar

	registeredBars[barName] = {
		enabled = false,
		bar = holder
	}
	reposition()
end

function ProgressBars:EnableBar(barName)
	local obj = getObject(barName)
	if not obj then return end

	obj.enabled = true
	obj.bar:Show()
	reposition()
end

function ProgressBars:DisableBar(barName)
	local obj = getObject(barName)
	if not obj then return end

	obj.enabled = false
	obj.bar:Hide()
	reposition()
end

function ProgressBars:SetBarValues(barName, min, max, current)
	local bar = getBar(barName)
	if not bar then return end

	bar.StatusBar:SetMinMaxValues(min, max)
	bar.StatusBar:SetValue(current)
end

function ProgressBars:SetBarColor(barName, r, g, b)
	local bar = getBar(barName)
	if not bar then return end

	bar.StatusBar:SetStatusBarColor(r, g, b)
end

ns.sInterfaceProgressBars = ProgressBars