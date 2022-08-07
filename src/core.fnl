(local (_ ns) ...)

(local E (CreateFrame :Frame :sEngine))

(fn E.bordered [self frame]
  (let [border-tex "Interface\\Tooltips\\UI-Tooltip-Border"
       border (CreateFrame :Frame nil frame (and _G.BackdropTemplateMixin :BackdropTemplate))]
    (border:SetFrameStrata (frame:GetFrameStrata))
    (border:SetPoint :TOPLEFT frame :TOPLEFT -3 3)
    (border:SetPoint :BOTTOMRIGHT frame :BOTTOMRIGHT 3 -3)
    (border:SetBackdrop {:edgeFile border-tex :edgeSize 11})
    (border:SetBackdropBorderColor 0.69803921568627 0.55686274509804 0.3921568627451 1)))

(set ns.E E)
