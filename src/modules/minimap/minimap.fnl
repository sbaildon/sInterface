(let [minimap _G.Minimap
      zoom-out _G.MinimapZoomOut
      zoom-in _G.MinimapZoomIn]
  (minimap:ClearAllPoints)
  (minimap:SetMaskTexture "Interface\\ChatFrame\\ChatFrameBackground")
  (minimap:EnableMouseWheel true)
  (minimap:SetScript :OnMouseWheel
                     (lambda [?self direction]
                       (if (> direction 0)
                           (zoom-in:Click)
                           (zoom-out:Click)))))

(each [_ border (ipairs [_G.MinimapBorder _G.MinimapBorderTop])]
  (border:Hide))

(each [_ button (ipairs [_G.MinimapZoomIn _G.MinimapZoomOut])]
  (button:Hide))

(let [instance _G.MiniMapInstanceDifficulty]
  (instance:Hide))

(let [calendar _G.GameTimeFrame]
  (calendar:Hide))

(let [world-map _G.MiniMapWorldMapButton]
  (world-map:Hide))

(let [tracking-background _G.MiniMapTrackingBackground
      tracking-button _G.MiniMapTrackingButton
      tracking _G.MiniMapTracking
      minimap _G.Minimap]
  (tracking-background:SetAlpha 0)
  (tracking-button:SetAlpha 0)
  (tracking:ClearAllPoints)
  (tracking:SetPoint :TOPRIGHT minimap 0 0)
  (tracking:SetScale 0.9))

(let [mail-frame _G.MiniMapMailFrame
      mail-border _G.MiniMapMailBorder
      mail-icon _G.MiniMapMailIcon
      minimap _G.Minimap]
  (mail-frame:ClearAllPoints)
  (mail-frame:SetPoint :TOPLEFT minimap 0 0)
  (mail-frame:SetFrameStrata :LOW)
  (mail-border:Hide)
  (mail-icon:SetTexture "Interface\\Minimap\\ObjectIcons.blp")
  (mail-icon:SetTexCoord 0.875 1 0.25 0.375))

(let [north-tag _G.MinimapNorthTag]
  (north-tag:SetTexture nil))

(let [zone-text _G.MinimapZoneTextButton]
  (zone-text:Hide))

(let [garrison _G.GarrisonLandingPageMinimapButton]
  (garrison:Hide)
  (garrison:UnregisterAllEvents))

(let [queue _G.QueueStatusMinimapButton
      queue-border _G.QueueStatusMinimapButtonBorder
      minimap _G.Minimap]
  (queue:SetParent minimap)
  (queue:ClearAllPoints)
  (queue:SetPoint :BOTTOMRIGHT 0 0)
  (queue-border:Hide))

(when (not (IsAddOnLoaded :Blizzard_TimeManager))
  (LoadAddOn :Blizzard_TimeManager)
  (let [clock _G.TimeManagerClockButton]
    (clock:Hide)))
