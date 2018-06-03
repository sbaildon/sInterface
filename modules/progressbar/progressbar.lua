local _, ns = ...
local C = ns.C

if not C.progressBars.enabled then return end;

local bars = {}

local priority = {
	experienceHolder = 1,
	reputationHolder = 2,
	artifactHolder = 3
}

local progressBars = CreateFrame("Frame", "sInterfaceProgressBars", UIParent)

progressBars:SetPoint("TOPLEFT", Minimap, "BOTTOMLEFT", 0, -10)
progressBars:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 0, -10)

local height = (C.progressBars.experience.enabled and C.progressBars.experience.height or 0)
	+ (C.progressBars.reputation.enabled and C.progressBars.reputation.height or 0)
	+ (C.progressBars.artifactPower.enabled and C.progressBars.artifactPower.height or 0)
height = ((height > 0) and height or 1)

local enabledCount = 0
for _, element in pairs(C.progressBars) do
	if (type(element) == "table") and (element.enabled ~= nil) then
		if element.enabled then
			enabledCount = enabledCount + 1
		end
	end
end

local function reposition()
	local prevElement
	for _, element in pairs(bars) do
		if (prevElement == nil) then
			element:SetPoint("TOP", progressBars, "TOP")
		else
			element:SetPoint("TOP", prevElement, "BOTTOM", 0, -C.progressBars.spacing)
		end

		prevElement = element
	end
end

local function insert(element)
	local position = priority[element:GetName()]

	for _, ele in pairs(bars) do
		-- Check if element already exists in our table
		if (element:GetName() == ele:GetName()) then return end
	end

	table.insert(bars, position, element)

	reposition()
end

local function remove(element)
	local position = priority[element:GetName()]

	if position > #bars then return end

	if (bars[position]:GetName() == element:GetName()) then
		-- Only remove a bar from a position if it's the same bar
		-- that we actually want to remove
		-- eg dont remove rep bar at pos 2 if artifact calls remove
		table.remove(bars, position)
	end

	reposition()
end

progressBars.Insert = insert
progressBars.Remove = remove

local adjustForSpacing
if (enabledCount > 0) then
	adjustForSpacing = (enabledCount-1) * C.progressBars.spacing
end

height = height + adjustForSpacing

progressBars:SetHeight(height)

ns.ProgressBars = progressBars