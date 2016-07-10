local cfg = {}
local addon, ns = ...
local globals = ns.globals
  
cfg.pos   = { "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -180, 180 }
cfg.scale = 1
cfg.font = {}
cfg.font.family = STANDARD_TEXT_FONT
-- cfg.font.family = 'Interface\\AddOns\\oUF_Skaarj\\Media\\normal.ttf'
cfg.backdrop = { bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8",  tiled = false, edgeSize = 1, insets = {left=0, right=0, top=0, bottom=0} }
cfg.backdrop.bgColor = {0.03,0.03,0.03,0.8}
cfg.backdrop.borderColor = {0.8,0.8,0.8,0}

---------------------------------------------
--  VARIABLES
---------------------------------------------
local unpack, type = unpack, type
local RAID_CLASS_COLORS = RAID_CLASS_COLORS
local FACTION_BAR_COLORS = FACTION_BAR_COLORS
local WorldFrame = WorldFrame
local GameTooltip = GameTooltip
local GameTooltipStatusBar = GameTooltipStatusBar

local classes = { "Warrior", "Paladin", "Hunter", "Shaman", "Druid", "Rogue", "Monk", "Death Knight", "Mage", "Warlock", "Priest" }

---------------------------------------------
--  FUNCTIONS
---------------------------------------------

--change some text sizes
GameTooltipHeaderText:SetFont(cfg.font.family, 15)
GameTooltipText:SetFont(cfg.font.family, 13)
Tooltip_Small:SetFont(cfg.font.family, 12)

--gametooltip statusbar
GameTooltipStatusBar:ClearAllPoints()
GameTooltipStatusBar.bg = GameTooltipStatusBar:CreateTexture(nil,"BACKGROUND",nil,-8)
GameTooltipStatusBar.bg:SetPoint("TOPLEFT",-1,1)
GameTooltipStatusBar.bg:SetPoint("BOTTOMRIGHT",1,-1)
GameTooltipStatusBar.bg:SetTexture(1,1,1)
GameTooltipStatusBar.bg:SetVertexColor(0,0,0,0.7)

-- HookScript GameTooltip OnTooltipCleared
GameTooltip:HookScript("OnSizeChanged", function(self)
	self:SetBackdropColor(unpack(cfg.backdrop.bgColor))
end)

--hooksecurefunc GameTooltip_SetDefaultAnchor
hooksecurefunc("GameTooltip_SetDefaultAnchor", function(tooltip, parent)
	tooltip:SetOwner(parent, "ANCHOR_NONE")
	tooltip:ClearAllPoints()
	tooltip:SetPoint(unpack(cfg.pos))
end)

hooksecurefunc(GameTooltip, "Show", function(self)
	self:SetBackdropColor(unpack(cfg.backdrop.bgColor))
	if not self:GetItem() and not self:GetUnit() then
		self:SetBackdropBorderColor(unpack(cfg.backdrop.borderColor))
	end
end)

GameTooltip:HookScript("OnUpdate", function(self, elapsed)
	if not self.currentItem and not self.currentUnit then
		self:SetBackdropColor(unpack(cfg.backdrop.bgColor))
		self:SetBackdropBorderColor(unpack(cfg.backdrop.borderColor))
	end

	if self.currentUnit and not UnitExists(self.currentUnit) then
		self:Hide()
	end

	if self.newHeight and abs(self:GetHeight() - self.newHeight) > 0.1 then
		self:SetHeight(self.newHeight)
	end
end)

--func GetHexColor
local function GetHexColor(color)
	return ("%.2x%.2x%.2x"):format(color.r*255, color.g*255, color.b*255)
end

local classColors, reactionColors = {}, {}

for class, color in pairs(RAID_CLASS_COLORS) do
	classColors[class] = GetHexColor(RAID_CLASS_COLORS[class])
end

for i = 1, #FACTION_BAR_COLORS do
	reactionColors[i] = GetHexColor(FACTION_BAR_COLORS[i])
end

--HookScript GameTooltip OnTooltipSetUnit
GameTooltip:HookScript("OnTooltipSetUnit", function(self,...)
	GameTooltipTextLeft5:Hide()
	if (GameTooltipTextLeft4:GetText() == "PvP") then GameTooltipTextLeft4:Hide() end
	three_text = GameTooltipTextLeft3:GetText()
	if (three_text) then
		three_text = three_text:gsub("%b()", "")
		for i,v in ipairs(classes) do
			three_text = three_text:gsub(v, "")
		end
		GameTooltipTextLeft3:SetText(three_text)
	end
	local unit = select(2, self:GetUnit()) or (GetMouseFocus() and GetMouseFocus():GetAttribute("unit")) or (UnitExists("mouseover") and "mouseover")
	if not unit or (unit and type(unit) ~= "string") then return end
	if not UnitGUID(unit) then return end
	local ricon = GetRaidTargetIndex(unit)
	if ricon then
		local text = GameTooltipTextLeft1:GetText()
		GameTooltipTextLeft1:SetText(("%s %s"):format(ICON_LIST[ricon].."14|t", text))
	end
	for i = 2, GameTooltip:NumLines() do
		local line = _G["GameTooltipTextLeft"..i]
		if line then
			line:SetTextColor(0.5,0.5,0.5)
		end
	end
	if UnitIsPlayer(unit) then
		local _, unitClass = UnitClass(unit)
		local color = RAID_CLASS_COLORS[unitClass]
		GameTooltipStatusBar:SetStatusBarColor(color.r,color.g,color.b)
		local text = GameTooltipTextLeft1:GetText()
		GameTooltipTextLeft1:SetFormattedText("|cff%02x%02x%02x%s|r", color.r * 255, color.g * 255, color.b * 255, text:match("|cff\x\x\x\x\x\x(.+)|r") or text)
		if UnitIsAFK(unit) then
			self:AppendText(" |cff00cccc<AFK>|r")
		elseif UnitIsDND(unit) then
			self:AppendText(" |cffcc0000<DND>|r")
		end

		local unitGuild = GetGuildInfo(unit)
		local text = GameTooltipTextLeft2:GetText()
		if unitGuild and text and text:find("^"..unitGuild) then
			GameTooltipTextLeft2:SetText("<"..text..">")
			GameTooltipTextLeft2:SetTextColor(205/255, 126/255, 215/255)
		else
			three_text = GameTooltipTextLeft2:GetText()
			if (three_text) then
				three_text = three_text:gsub("%b()", "")
				for i,v in ipairs(classes) do
					three_text = three_text:gsub(v, "")
				end
				GameTooltipTextLeft2:SetText(three_text)
			end
		end
	else
		local reaction = UnitReaction(unit, "player")
		if reaction then
			local color = FACTION_BAR_COLORS[reaction]
		if color then
			GameTooltipStatusBar:SetStatusBarColor(color.r,color.g,color.b)
			GameTooltipTextLeft1:SetTextColor(color.r,color.g,color.b)
		end
	end

	local unitClassification = UnitClassification(unit)
	if unitClassification == "worldboss" or UnitLevel(unit) == -1 then
		if UnitReaction(unit, "player") == 2 then
			--highlight bosses
			GameTooltipTextLeft1:SetTextColor(1,0.1,0)
		end
		self:AppendText(" |TInterface\\TargetingFrame\\UI-TargetingFrame-Skull:14:14|t")
	elseif unitClassification == "rare" then
		self:AppendText(" |TInterface\\AddOns\\rTooltip\\diablo:14:14:0:0:16:16:0:15:0:14|t")
	elseif unitClassification == "rareelite" then
		self:AppendText(" |TInterface\\AddOns\\rTooltip\\diablo:14:14:0:0:16:16:0:15:0:14|t")
	elseif unitClassification == "elite" then
		self:AppendText(" |TInterface\\AddOns\\rTooltip\\plus:14:14|t")
	end
	end

	if UnitIsGhost(unit) then
		self:AppendText(" |cffaaaaaa<GHOST>|r")
		GameTooltipTextLeft1:SetTextColor(0.5,0.5,0.5)
	elseif UnitIsDead(unit) then
		self:AppendText(" |cffaaaaaa<DEAD>|r")
		GameTooltipTextLeft1:SetTextColor(0.5,0.5,0.5)
	end
end)

--func TooltipOnShow
local function TooltipOnShow(self,...)
	self:SetBackdropColor(unpack(cfg.backdrop.bgColor))
	self:SetBackdropBorderColor(unpack(cfg.backdrop.borderColor))
	local itemName, itemLink = self:GetItem()
	if itemLink then
		local itemRarity = select(3,GetItemInfo(itemLink))
		if itemRarity then
			self:SetBackdropBorderColor(unpack({GetItemQualityColor(itemRarity)}))
		end
	end
end
  
--func TooltipOnShow
local function TooltipOnHide(self,...)
	self:SetBackdropColor(unpack(cfg.backdrop.bgColor))
	self:SetBackdropBorderColor(unpack(cfg.backdrop.borderColor))
end

--loop over tooltips
local tooltips = { GameTooltip, ItemRefTooltip, ShoppingTooltip1, ShoppingTooltip2, ShoppingTooltip3, WorldMapTooltip, }
local tt = { GameTooltip, ShoppingTooltip1, ShoppingTooltip2, ShoppingTooltip3, ItemRefTooltip, ItemRefShoppingTooltip1, ItemRefShoppingTooltip2, ItemRefShoppingTooltip3, WorldMapTooltip, WorldMapCompareTooltip1, WorldMapCompareTooltip2, WorldMapCompareTooltip3, AtlasLootTooltip, QuestHelperTooltip, QuestGuru_QuestWatchTooltip, }
for idx, tooltip in ipairs(tooltips) do
	tooltip:SetBackdrop(cfg.backdrop)
	tooltip:SetBackdropColor(unpack(cfg.backdrop.bgColor))
	tooltip:SetScale(cfg.scale)
	tooltip:HookScript("OnShow", TooltipOnShow)
	tooltip:HookScript("OnHide", TooltipOnHide)
end

--loop over menues
local menues = {
	DropDownList1MenuBackdrop,
	DropDownList2MenuBackdrop,
}
for idx, menu in ipairs(menues) do
	menu:SetScale(cfg.scale)
end