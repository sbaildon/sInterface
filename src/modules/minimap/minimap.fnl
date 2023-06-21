(local (_ ns) ...)

(local cluster _G.MinimapCluster)
(local minimap _G.Minimap)
(local hooksecurefunc _G.hooksecurefunc)
(local uiparent _G.UIParent)
(local header-offset 9)

(λ fake-mouseover [] true)
(each [_ button (ipairs [minimap.ZoomIn minimap.ZoomOut])]
  (set button.IsMouseOver fake-mouseover)
  (button:Show))

(let [zone-text _G.MinimapZoneText
      border-top cluster.BorderTop]
  (zone-text:SetFontObject :GameFontNormalLargeOutline)
  (zone-text:ClearAllPoints)
  (zone-text:SetJustifyH :CENTER)
  (zone-text:SetPoint :CENTER border-top :CENTER))

(λ position-border-top []
  (let [border-top cluster.BorderTop
        x-offset 0
        y-offset -20]
    (border-top:ClearAllPoints)
    (border-top:SetPoint :TOPLEFT cluster :TOPLEFT x-offset y-offset)
    (border-top:SetPoint :TOPRIGHT cluster :TOPRIGHT x-offset y-offset)))

(λ style-minimap []
  (ns.E:bordered minimap)
  (minimap:SetMaskTexture "Interface\\ChatFrame\\ChatFrameBackground"))

(λ position-cluster []
  (let [x-offset -40
        y-offset 0]
    (cluster:SetSize (minimap:GetWidth) (+ header-offset (minimap:GetHeight)))
    (cluster:ClearAllPoints)
    (cluster:SetPoint :TOPRIGHT uiparent :TOPRIGHT x-offset y-offset)))

(λ on-update []
  (style-minimap)
  (position-border-top)
  (position-cluster))

(hooksecurefunc cluster :SetRotateMinimap on-update)
