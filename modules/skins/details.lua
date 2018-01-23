local _, ns = ...
local E, C = ns.E, ns.C

if not IsAddOnLoaded("Details") then return end

local groupWatcher = CreateFrame("frame", nil, UIParent)
groupWatcher:RegisterEvent("GROUP_ROSTER_UPDATE")
groupWatcher:RegisterEvent("PLAYER_ENTERING_WORLD")
groupWatcher:RegisterEvent("PLAYER_REGEN_DISABLED")

local BAR_HEIGHT = 19
local BAR_SPACING = 1
local BAR_TOTAL = 7

Details:SelectNumericalSystem(1)
Details:SetUseAnimations(true)
Details:SetWindowUpdateSpeed(0.05)

local instance = Details:GetInstance(1)
instance:LockInstance(false)
instance:ChangeSkin("Safe Skin Legion Beta")
instance:HideMainIcon(true)
instance:ToolbarSide(1)
instance:HideStatusBar()
instance:SetAutoHideMenu(true)
instance:SetBackdropTexture(nil)
instance:ToolbarMenuSetButtonsOptions(5)
instance:SetBarSettings(BAR_HEIGHT, nil, true, nil, nil, false, {0, 0, 0, 0}, 1, nil, true, BAR_SPACING, string.sub(C.general.texture, 11))
instance:SetBarTextSettings(15, nil, {1, 1, 1}, nil, nil, nil, nil, nil, nil, 1, false)
instance:SetBarFollowPlayer(true)
instance:SetBarGrowDirection(1)
E:ShadowedBorder(DetailsBaseFrame1)
instance:AttributeMenu(true, -20, 6, nil, 13, {1, 0.75, 0, 1}, 1, true)

instance:LockInstance(true)
instance:InstanceColor(0, 0, 0, 0, false, true)
instance.bg_alpha = 0
local pos = instance:CreatePositionTable()
pos.w = 240
pos.h = (BAR_HEIGHT*(BAR_TOTAL)) + (BAR_SPACING*(BAR_TOTAL))
pos.scale = 1
pos.point = "BOTTOMRIGHT"
pos.x = -C.general.edgeSpacing
pos.y = C.general.edgeSpacing
instance:RestorePositionFromPositionTable(pos)
instance:SetBarBackdropSettings(true, 0, {1, 1, 1, 0}, nil, "gucci")

groupWatcher:SetScript('OnEvent', function(self, event, ...)
	if event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_ENTERING_WORLD" then
		numGroupMembers = GetNumGroupMembers()
		if (numGroupMembers >= BAR_TOTAL) then
			pos.h = (BAR_HEIGHT*(BAR_TOTAL)) + (BAR_SPACING*(BAR_TOTAL))
		elseif (numGroupMembers > 0) then
			pos.h = (BAR_HEIGHT*(numGroupMembers)) + (BAR_SPACING*(numGroupMembers))
		else
			pos.h = BAR_HEIGHT+BAR_SPACING
		end
		instance:RestorePositionFromPositionTable(pos)
	end
end)