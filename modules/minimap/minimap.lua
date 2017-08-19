local addon, ns = ...
local E, C = ns.E, ns.C

if not C.minimap.enabled then return end

-- Position
Minimap:ClearAllPoints()
Minimap:SetPoint(unpack(C.minimap.position))
Minimap:SetSize(C.minimap.width, C.minimap.height)

-- Square Shape
Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')

-- Border
MinimapBorder:Hide()
MinimapBorderTop:Hide()

-- Zoom
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, direction)
	if direction > 0 then
		_G.MinimapZoomIn:Click()
	elseif direction < 0 then
		_G.MinimapZoomOut:Click()
	end
end)
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()

-- Voice
MiniMapVoiceChatFrame:Hide()

-- Compass
MinimapNorthTag:SetTexture(nil)

-- Zone
MinimapZoneTextButton:Hide()

-- Clock
if not IsAddOnLoaded("Blizzard_TimeManager") then
	LoadAddOn("Blizzard_TimeManager")
	TimeManagerClockButton:Hide()
end

-- Calendar
GameTimeFrame:Hide()

-- Garrison
GarrisonLandingPageMinimapButton:Hide()
GarrisonLandingPageMinimapButton:UnregisterAllEvents();

-- Tracking
MiniMapTrackingBackground:SetAlpha(0)
MiniMapTrackingButton:SetAlpha(0)
MiniMapTracking:ClearAllPoints()
MiniMapTracking:SetPoint("TOPRIGHT", Minimap, 0, 0)
MiniMapTracking:SetScale(.9)

-- Mail
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("TOPLEFT", Minimap, 0, 0)
MiniMapMailFrame:SetFrameStrata("LOW")
MiniMapMailBorder:Hide()
MiniMapMailIcon:SetTexture("Interface\\AddOns\\sInterface\\media\\mail.blp")

-- Queues
QueueStatusMinimapButton:SetParent(Minimap)
QueueStatusMinimapButton:ClearAllPoints()
QueueStatusMinimapButton:SetPoint("BOTTOMRIGHT", 0, 0)
QueueStatusMinimapButtonBorder:Hide()

-- Instance
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:Hide()

-- World Map
MiniMapWorldMapButton:Hide()

E:ShadowedBorder(Minimap)

local level = UnitLevel("player")
local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local micromenu = {
	{text = CHARACTER_BUTTON, notCheckable = 1, func = function()
		ToggleCharacter("PaperDollFrame")
	end},
	{text = SPELLBOOK_ABILITIES_BUTTON, notCheckable = 1, func = function()
		if InCombatLockdown() then
			print("|cffffff00"..ERR_NOT_IN_COMBAT..".|r") return
		end
		ToggleSpellBook(BOOKTYPE_SPELL)
	end},
	{text = TALENTS_BUTTON, notCheckable = 1, func = function()
		if not PlayerTalentFrame then
			TalentFrame_LoadUI()
		end
		if level >= SHOW_TALENT_LEVEL then
			ToggleTalentFrame()
		else
			print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_TALENT_LEVEL).."|r")
		end
	end},
	{text = ACHIEVEMENT_BUTTON, notCheckable = 1, func = function()
		ToggleAchievementFrame()
	end},
	{text = QUESTLOG_BUTTON, notCheckable = 1, func = function()
		ToggleFrame(WorldMapFrame)
	end},
	{text = ACHIEVEMENTS_GUILD_TAB, notCheckable = 1, func = function()
		if IsInGuild() then
			if not GuildFrame then
				LoadAddOn("Blizzard_GuildUI")
			end
			ToggleGuildFrame()
			GuildFrame_TabClicked(GuildFrameTab2)
		else
			if not LookingForGuildFrame then
				LoadAddOn("Blizzard_LookingForGuildUI")
			end
			if not LookingForGuildFrame then return end
			LookingForGuildFrame_Toggle()
		end
	end},
	{text = SOCIAL_BUTTON, notCheckable = 1, func = function()
		ToggleFriendsFrame(1)
	end},
	{text = PLAYER_V_PLAYER, notCheckable = 1, func = function()
		if level >= SHOW_PVP_LEVEL then
			if not IsAddOnLoaded("Blizzard_PVPUI") then
				LoadAddOn("Blizzard_PVPUI")
			end
			ToggleFrame(PVPUIFrame)
		else
			print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_PVP_LEVEL).."|r")
		end
	end},
	{text = DUNGEONS_BUTTON, notCheckable = 1, func = function()
		if level >= SHOW_LFD_LEVEL then
			PVEFrame_ToggleFrame()
		else
			print("|cffffff00"..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, SHOW_LFD_LEVEL).."|r")
		end
	end},
	{text = LOOKING_FOR_RAID, notCheckable = 1, func = function()
		ToggleRaidFrame(3)
	end},
	{text = MOUNTS_AND_PETS, notCheckable = 1, func = function()
		TogglePetJournal()
	end},
	{text = ENCOUNTER_JOURNAL, notCheckable = 1, func = function()
		if not IsAddOnLoaded("Blizzard_EncounterJournal") then
			LoadAddOn("Blizzard_EncounterJournal")
		end
		ToggleEncounterJournal()
	end},
	{text = HELP_BUTTON, notCheckable = 1, func = function()
		ToggleHelpFrame()
	end},
	{text = L_MINIMAP_CALENDAR, notCheckable = 1, func = function()
		if not CalendarFrame then
			LoadAddOn("Blizzard_Calendar")
		end
		Calendar_Toggle()
	end},
	{text = BATTLEFIELD_MINIMAP, notCheckable = true, func = function()
		ToggleBattlefieldMinimap()
	end},

}

Minimap:SetScript("OnMouseUp", function(self, btn)
	if btn == "RightButton" then
		EasyMenu(micromenu, menuFrame, "cursor", 0, 0, "MENU", 2)
	else
		Minimap_OnClick(self)
	end
end)
