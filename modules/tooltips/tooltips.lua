local _, ns = ...
local C = ns.C

if not C.tooltips.enabled then return end

local unpack, type = unpack, type
local RAID_CLASS_COLORS = RAID_CLASS_COLORS
local FACTION_BAR_COLORS = FACTION_BAR_COLORS
local WorldFrame = WorldFrame
local GameTooltip = GameTooltip

GameTooltipHeaderText:SetFont(C.general.displayFont.typeface, C.general.displayFont.size*1.1)
GameTooltipText:SetFont(C.general.displayFont.typeface, C.general.displayFont.size)
Tooltip_Small:SetFont(C.general.displayFont.typeface, C.general.displayFont.size)

GameTooltipStatusBar:ClearAllPoints()
GameTooltipStatusBar:Hide()

local bgColor = { 0.03, 0.03, 0.03, 0.8 }
local backdrop = { bgFile = "Interface\\Buttons\\WHITE8x8",
	edgeFile = "Interface\\Buttons\\WHITE8x8",
	tiled = false, edgeSize = 1,
	insets = { left = 0, right = 0, top = 0, bottom = 0 },
}


hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
	if C.tooltips.anchor_cursor then
		tooltip:SetOwner(parent, "ANCHOR_CURSOR")
	else
		tooltip:SetOwner(parent, "ANCHOR_NONE")
		tooltip:ClearAllPoints()
		tooltip:SetPoint(unpack(C.tooltips.pos))
	end
end)

local left = setmetatable({}, { __index = function(left, i)
	local line = _G["GameTooltipTextLeft" .. i]
	if line then rawset(left, i, line) end
	return line
end })

GameTooltip:HookScript("OnUpdate", function(self, elapsed)
	if not self.currentItem and not self.currentUnit then
		self:SetBackdropColor(unpack(bgColor))
	end
end)

local function GetHexColor(color)
	return ("%.2x%.2x%.2x"):format(color.r*255, color.g*255, color.b*255)
end

GameTooltip:HookScript("OnTooltipSetUnit", function(self,...)
	local unit = select(2, self:GetUnit()) or (GetMouseFocus() and GetMouseFocus():GetAttribute("unit")) or (UnitExists("mouseover") and "mouseover")
	if not unit then return end
	local line = 1
	if UnitIsPlayer(unit) then
		local name, realm = UnitName(unit)
		local _, unitClass = UnitClass(unit)
		local color = RAID_CLASS_COLORS[unitClass]
		if realm then
			left[line]:SetFormattedText("|cff%02x%02x%02x%s %s %s|r", color.r*255, color.g*255, color.b*255, name, 'of', realm)
		else
			left[line]:SetFormattedText("|cff%02x%02x%02x%s|r", color.r*255, color.g*255, color.b*255, name)
		end
		line = line + 1

		local guild = GetGuildInfo(unit)
		if guild then
			left[line]:SetFormattedText('|cff%02x%02x%02x%s|r', 255, 213, 131, guild)
			line = line + 1
		end

		local level, race = UnitLevel(unit), UnitRace(unit)
		level = level > 0 and level or '??'
		if level == '??' then
			local color = { r = 0.69, g = 0.69, b = 0.69 }
			left[line]:SetFormattedText('|cff%02x%02x%02x%s|r %s', color.r*255, color.g*255, color.b*255, level, race)
		else
			local color = GetQuestDifficultyColor(level)
			left[line]:SetFormattedText('|cff%02x%02x%02x%d|r %s', color.r*255, color.g*255, color.b*255, level, race)
		end
		line = line + 1

		for i = line, GameTooltip:NumLines() do
			left[i]:SetText(nil)
		end
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

local function TooltipOnShow(self,...)
	self:SetBackdropColor(unpack(bgColor))
	self:SetBackdropBorderColor(0, 0, 0, 0)
end

local function TooltipOnHide(self,...)
	self:SetBackdropColor(unpack(bgColor))
end


local tooltips = { GameTooltip, ItemRefTooltip, ShoppingTooltip1, ShoppingTooltip2, ShoppingTooltip3, WorldMapTooltip }
local tt = { GameTooltip, ShoppingTooltip1, ShoppingTooltip2, ShoppingTooltip3, ItemRefTooltip, ItemRefShoppingTooltip1, ItemRefShoppingTooltip2, ItemRefShoppingTooltip3, WorldMapTooltip, WorldMapCompareTooltip1, WorldMapCompareTooltip2, WorldMapCompareTooltip3, AtlasLootTooltip, QuestHelperTooltip, QuestGuru_QuestWatchTooltip }
for idx, tooltip in ipairs(tooltips) do
	tooltip:SetBackdrop(backdrop)
	tooltip:SetBackdropColor(unpack(bgColor))
	tooltip:HookScript("OnShow", TooltipOnShow)
	tooltip:HookScript("OnHide", TooltipOnHide)
end
