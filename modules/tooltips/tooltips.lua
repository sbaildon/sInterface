local _, ns = ...
local E = ns.E

if not E:C('tooltips', 'enabled') then return end

local unpack, type = unpack, type
local RAID_CLASS_COLORS = RAID_CLASS_COLORS
local GameTooltip = GameTooltip

GameTooltipStatusBar:ClearAllPoints()
GameTooltipStatusBar:Hide()

local bgColor = { 0.03, 0.03, 0.03, 0.8 }
local backdrop = {
	bgFile = "Interface\\Buttons\\WHITE8x8",
	edgeFile = "Interface\\Buttons\\WHITE8x8",
	tiled = false, edgeSize = 0,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
}

local function SetBackdropStyle(self)
	if (self.SetBackdrop) then
		self:SetBackdrop(nil)
	end

	if not self.style then return end

	self.style:SetBackdrop(backdrop)
	self.style:SetBackdropBorderColor(1, 1, 1, 0)
	self.style:SetBackdropColor(unpack(bgColor))
end

hooksecurefunc("GameTooltip_UpdateStyle", function(self)
	SetBackdropStyle(self)
end)

hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
	if E:C('tooltips', 'anchor_cursor') then
		tooltip:SetOwner(parent, "ANCHOR_CURSOR")
	else
		tooltip:SetOwner(parent, "ANCHOR_NONE")
		tooltip:ClearAllPoints()
		tooltip:SetClampedToScreen(true)
		tooltip:SetPoint(unpack(E:C('tooltips', 'pos')))
	end
end)

hooksecurefunc("EmbeddedItemTooltip_UpdateSize", function(self)
	self.Tooltip:SetBackdrop(nil)
end)

local left = setmetatable({}, { __index = function(left, i)
	local line = _G["GameTooltipTextLeft" .. i]
	if line then rawset(left, i, line) end
	return line
end })

GameTooltip:HookScript("OnTooltipSetUnit", function(self, ...)
	local unit = select(2, self:GetUnit()) or (GetMouseFocus() and GetMouseFocus():GetAttribute("unit")) or (UnitExists("mouseover") and "mouseover")
	if not unit then return end
	local line = 1
	if UnitIsPlayer(unit) then
		local name, realm = UnitName(unit)
		local _, unitClass = UnitClass(unit)
		local classColor = RAID_CLASS_COLORS[unitClass]

		if realm then
			left[line]:SetFormattedText("|cff%02x%02x%02x%s %s %s|r", classColor.r*255, classColor.g*255, classColor.b*255, name, 'of', realm)
		else
			left[line]:SetFormattedText("|cff%02x%02x%02x%s|r", classColor.r*255, classColor.g*255, classColor.b*255, name)
		end
		line = line + 1

		local guild = GetGuildInfo(unit)
		if guild then
			left[line]:SetFormattedText('|cff%02x%02x%02x%s|r', 255, 213, 131, guild)
			line = line + 1
		end

		local level, race = UnitLevel(unit), UnitRace(unit)
		local difficultyColor
		level = level > 0 and level or '??'
		if level == '??' then
			difficultyColor = { r = 0.69, g = 0.69, b = 0.69 }
		else
			difficultyColor = GetQuestDifficultyColor(level)
		end

		left[line]:SetFormattedText('|cff%02x%02x%02x%s|r %s', difficultyColor.r*255, difficultyColor.g*255, difficultyColor.b*255, level, race)
	else
		local name = UnitName(unit)
		left[line]:SetText(name)
		line = line + 1

		local info = left[line]:GetText()
		if not info then return GameTooltip:Show() end

		if not strmatch(info, "Level") and not strmatch(info, "Pet Level") then
			line = line + 1
		end

		local level, race = UnitLevel(unit), UnitCreatureType(unit)
		level = level == -1 and '??' or level
		local color = type(level) == 'number' and GetQuestDifficultyColor(level) or {r=1, g=0.5, b=0.5}
		if level and race then
			left[line]:SetFormattedText('|cff%02x%02x%02x%s|r %s', color.r*255, color.g*255, color.b*255, level, race)
		end
	end
end)


local tooltips = { GameTooltip, ItemRefTooltip, ShoppingTooltip1, ShoppingTooltip2, ShoppingTooltip3, WorldMapTooltip, SmallTextTooltip }
for _, tooltip in ipairs(tooltips) do
	tooltip.style = CreateFrame("Frame", nil, tooltip, BackdropTemplateMixin and "BackdropTemplate" or nil)
	tooltip.style:SetFrameLevel(tooltip:GetFrameLevel())
	tooltip.style:SetAllPoints()

	if (tooltip == GameTooltip) then
		tooltip.GetBackdrop = function(self) return self.style:GetBackdrop() end
		tooltip.GetBackdropColor = function(self) return self.style:GetBackdropColor() end
		tooltip.GetBackdropBorderColor = function(self) return self.style:GetBackdropBorderColor() end
	end

	if (tooltip.style and tooltip.NineSlice) then
		tooltip.NineSlice:Hide()
		tooltip.NineSlice.Show = function() end
	end

	SetBackdropStyle(tooltip)
end
