(local (_ ns) ...)

(local cluster _G.MinimapCluster)
(local minimap _G.Minimap)
(local hooksecurefunc _G.hooksecurefunc)
(local uiparent _G.UIParent)
(local header-offset 9)

(when (not (_G.IsAddOnLoaded :Blizzard_TimeManager))
  (_G.LoadAddOn :Blizzard_TimeManager))

(λ fake-mouseover [] true)
(each [_ button (ipairs [minimap.ZoomIn minimap.ZoomOut])]
  (set button.IsMouseOver fake-mouseover)
  (button:Show))

(let [zone-text _G.MinimapZoneText
      border-top cluster.BorderTop]
  (zone-text:SetFontObject :GameFontNormalLargeOutline)
  (zone-text:ClearAllPoints)
  (zone-text:SetJustifyH :CENTER)
  (zone-text:SetPoint :LEFT border-top :LEFT)
  (zone-text:SetPoint :RIGHT border-top :RIGHT))

(λ position-border-top []
  (let [border-top cluster.BorderTop
        x-offset 0
        y-offset -4]
    (border-top:ClearAllPoints)
    (border-top:SetPoint :BOTTOMLEFT minimap :TOPLEFT x-offset y-offset)
    (border-top:SetPoint :BOTTOMRIGHT minimap :TOPRIGHT x-offset y-offset)))

(let [border cluster.BorderTop]
  (each [_ edge (ipairs [border.BottomEdge
                         border.BottomLeftCorner
                         border.BottomRightCorner
                         border.Center
                         border.LeftEdge
                         border.RightEdge
                         border.TopEdge
                         border.TopLeftCorner
                         border.TopRightCorner])]
    (edge:Hide)))

(λ discard-compass []
  (let [compass _G.MinimapCompassTexture]
    (compass:SetTexture nil)
    (compass:Hide)))

(λ discard-tracking []
  (let [tracking cluster.Tracking]
    (tracking:Hide)))

(λ discard-game-time-frame []
  (let [calendar _G.GameTimeFrame]
    (calendar:Hide)))

(λ discard-clock []
  (let [clock _G.TimeManagerClockTicker]
    (clock:Hide)))

(λ style-minimap []
  (ns.E:bordered minimap)
  (minimap:SetParent cluster)
  (minimap:SetMaskTexture "Interface\\ChatFrame\\ChatFrameBackground")
  (minimap:ClearAllPoints)
  (minimap:SetAllPoints cluster)
  (discard-clock)
  (discard-tracking)
  (discard-game-time-frame)
  (discard-compass))

(λ position-cluster []
  (let [x-offset -40
        y-offset -20
        minimap-width (minimap:GetWidth)
        minimap-height (minimap:GetHeight)]
    (cluster:SetSize minimap-width (+ header-offset minimap-height))
    (cluster:ClearAllPoints)
    (cluster:SetPoint :TOPRIGHT uiparent :TOPRIGHT x-offset y-offset)))

(λ on-update []
  (style-minimap)
  (position-border-top)
  (position-cluster))

(hooksecurefunc cluster :SetRotateMinimap on-update)
