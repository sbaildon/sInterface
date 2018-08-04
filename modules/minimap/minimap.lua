local _, ns = ...
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
-- MiniMapVoiceChatFrame:Hide()

-- Compass
MinimapNorthTag:SetTexture(nil)

-- Zone
MinimapZoneTextButton:Hide()
if (C.minimap.zoneText) then
	MinimapZoneText:SetFontObject("GameFontNormalOutline")
	MinimapZoneText:SetPoint("LEFT", Minimap, "LEFT", 0, 0)
	MinimapZoneText:SetPoint("RIGHT", Minimap, "RIGHT", 0, 0)
	MinimapZoneText:SetPoint("BOTTOM", Minimap, "TOP", 0, -5)
	MinimapZoneText:SetParent(Minimap)
end

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
MiniMapMailIcon:SetTexture("Interface\\Minimap\\ObjectIcons.blp")
MiniMapMailIcon:SetTexCoord(0.875, 1, 0.25, 0.375)

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