(local (_ ns) ...)

(local create-frame _G.CreateFrame)
(local backdrop-template-mixin _G.BackdropTemplateMixin)
(local E (create-frame :Frame :sEngine))

(λ E.bordered [_self frame]
  (let [border-tex "Interface\\Tooltips\\UI-Tooltip-Border"
        border (create-frame :Frame nil frame
                             (and backdrop-template-mixin :BackdropTemplate))]
    (border:SetFrameStrata (frame:GetFrameStrata))
    (border:SetPoint :TOPLEFT frame :TOPLEFT -3 3)
    (border:SetPoint :BOTTOMRIGHT frame :BOTTOMRIGHT 3 -3)
    (border:SetBackdrop {:edgeFile border-tex :edgeSize 11})
    (border:SetBackdropBorderColor 0.69803921568627 0.55686274509804
                                   0.3921568627451 1)))

; credit http://richard.warburton.it
(λ E.comma-value [number]
  (local (left num right) (string.match number "^([^%d]*%d)(%d*)(.-)$"))
  (.. left (: (: (num:reverse) :gsub "(%d%d%d)" "%1,") :reverse) right))

(set ns.E E)
