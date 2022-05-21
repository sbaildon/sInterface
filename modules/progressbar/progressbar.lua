local _, ns = ...
local E = ns.E

if not E:C('progressbars', 'enabled') then return end
;
local bars = {}

local Minimap = Minimap

local ProgressBars = CreateFrame("Frame", "sInterfaceProgressBars", Minimap)
ProgressBars:SetPoint("TOPLEFT", Minimap, "BOTTOMLEFT", 0, -10)
ProgressBars:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 0, -10)
ProgressBars:SetHeight(1)

local function getObject(barName)
	for key, value in pairs(bars) do
		if key == barName then
			return value
		end
	end

	return false
end

-- local function getBar(barName)
-- 	local obj = getObject(barName)
-- 	return obj and obj.bar or false
-- end

-- local function getEnabled(barName)
-- 	local obj = getObject(barName)
-- 	return obj and obj.enabled or false
-- end

local function reposition()
	local prevElement
	local enabledCount = 0
	local totalHeight = 0
	for _, element in pairs(bars) do
		if element.enabled then
			enabledCount = enabledCount + 1
			local something = element.bar
			totalHeight = totalHeight + something:GetHeight()
			if (prevElement == nil) then
				something:SetPoint("TOP", ProgressBars, "TOP")
			else
				something:SetPoint("TOP", prevElement, "BOTTOM", 0, -E:C('progressbars', 'spacing'))
			end

			prevElement = something
		end
	end

	ProgressBars:SetHeight(totalHeight + (E:C('progressbars', 'spacing') * (enabledCount - 1)))
end

function ProgressBars:CreateBar(barName)
	if not barName then return end
	local barHolder = CreateFrame("Frame", "sInterfaceProgressBars_" .. barName, ProgressBars)
	barHolder:SetPoint("LEFT", ProgressBars, "LEFT")
	barHolder:SetPoint("RIGHT", ProgressBars, "RIGHT")
	E:ShadowedBorder(barHolder)

	bars[barName] = {
		enabled = false,
		bar = barHolder
	}

	return barHolder
end

function ProgressBars:EnableBar(barName)
	local obj = getObject(barName)
	if not obj then return end

	obj.enabled = true
	obj.bar:Show()
	reposition()
end

function ProgressBars:DisableBar(barName, element)
	local obj = getObject(barName)
	if not obj then return end

	obj.enabled = false
	obj.bar:Hide()
	reposition()

end

ns.sInterfaceProgressBars = ProgressBars
