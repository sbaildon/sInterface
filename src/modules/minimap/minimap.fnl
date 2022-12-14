(local (_ ns) ...)

(local cluster _G.MinimapCluster)
(local header-offset 9)

(cluster:SetPoint :TOPRIGHT UIParent :TOPRIGHT -30 -10)

(let [minimap cluster.Minimap]
  (ns.E:bordered minimap)
  (minimap:SetMaskTexture "Interface\\ChatFrame\\ChatFrameBackground")
  (cluster:SetSize (minimap:GetWidth) (+ header-offset (minimap:GetHeight))))

(let [border-top cluster.BorderTop
      minimap _G.MinimapCluster]
  (border-top:ClearAllPoints)
  (border-top:SetPoint :TOPLEFT minimap :TOPLEFT 0 0)
  (border-top:SetPoint :TOPRIGHT minimap :TOPRIGHT 0 0))

(let [zone-text _G.MinimapZoneText
      border-top cluster.BorderTop]
  (zone-text:SetFontObject :GameFontNormalOutline)
  (zone-text:SetJustifyH :CENTER)
  (zone-text:SetPoint :CENTER border-top :CENTER))

(fn position-border [cluster]
  (let [border cluster.BorderTop
        minimap cluster.Minimap]
    (minimap:SetPoint :TOPRIGHT cluster :TOPRIGHT 0 0)
    (border:ClearAllPoints)
    (border:SetPoint :TOP minimap :TOP 0 header-offset)))

(let [border-top cluster.BorderTop]
  (hooksecurefunc cluster :SetHeaderUnderneath position-border))

(let [instance cluster.InstanceDifficulty]
  (instance:Hide))

(let [mail-frame cluster.MailFrame]
  (mail-frame:ClearAllPoints)
  (mail-frame:SetPoint :TOPLEFT cluster :TOPLEFT 0 0)
  (mail-frame:SetFrameStrata :LOW))

(let [compass _G.MinimapCompassTexture]
  (compass:SetTexture nil))

;; (let [garrison _G.GarrisonLandingPageMinimapButton]
;;   (garrison:Hide)
;;   (garrison:UnregisterAllEvents))

;; (let [queue _G.QueueStatusMinimapButton
;;       queue-border _G.QueueStatusMinimapButtonBorder
;;       minimap _G.Minimap]
;;   (queue:SetParent minimap)
;;   (queue:ClearAllPoints)
;;   (queue:SetPoint :BOTTOMRIGHT 0 0)
;;   (queue-border:Hide))

;; (when (not (IsAddOnLoaded :Blizzard_TimeManager))
;;   (LoadAddOn :Blizzard_TimeManager)
;;   (let [clock _G.TimeManagerClockButton]
;;     (clock:Hide)))
;; (let [calendar _G.GameTimeFrame
;;       border _G.MinimapCluster.BorderTop]
;;   (calendar:Hide))

;; (let [tracking-background _G.MiniMapTrackingBackground
;;       tracking-button _G.MiniMapTrackingButton
;;       tracking _G.MiniMapTracking
;;       minimap _G.Minimap]
;;   (tracking-background:SetAlpha 0)
;;   (tracking-button:SetAlpha 0)
;;   (tracking:ClearAllPoints)
;;   (tracking:SetPoint :TOPRIGHT minimap 0 0)
;;   (tracking:SetScale 0.9))

