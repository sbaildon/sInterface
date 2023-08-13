(local (_ ns) ...)

(local create-frame _G.CreateFrame)
(local backdrop-template-mixin _G.BackdropTemplateMixin)
(local E (create-frame :Frame :sEngine))
(local H (create-frame :Frame :helpers))

(λ get-frame-strata [frame]
  (: frame :GetFrameStrata))

(λ set-frame-strata [frame strata]
  (: frame :SetFrameStrata strata))

(λ set-backdrop [frame backdrop]
  (: frame :SetBackdrop backdrop))

(λ set-backdrop-border-color [frame ...]
  (: frame :SetBackdropBorderColor ...))

(λ E.bordered [_self frame]
  (let [border-tex "Interface\\Tooltips\\UI-Tooltip-Border"
        border (create-frame :Frame :sInterfaceBorder frame
                             (and backdrop-template-mixin :BackdropTemplate))]
    (set-frame-strata frame (get-frame-strata frame))
    (border:SetPoint :TOPLEFT frame :TOPLEFT -3 3)
    (border:SetPoint :BOTTOMRIGHT frame :BOTTOMRIGHT 3 -3)
    (set-backdrop border {:edgeFile border-tex :edgeSize 11})
    (set-backdrop-border-color border 0.69803921568627 0.55686274509804
                               0.3921568627451 1)))

(λ E.draw-border [self frame]
  (E.bordered self frame))

; credit http://richard.warburton.it
(λ E.comma-value [number]
  (local (left num right) (string.match number "^([^%d]*%d)(%d*)(.-)$"))
  (.. left (: (: (: num :reverse) :gsub "(%d%d%d)" "%1,") :reverse) right))

(λ H.set-all-points [frame]
  (: frame :SetAllPoints))

(λ H.set-status-bar-texture [bar]
  (: bar :SetStatusBarTexture "Interface\\AddOns\\sInterface\\media\\bar"))

(λ H.set-size [frame ...]
  (: frame :SetSize ...))

(λ H.set-justify-h [frame justification]
  (: frame :SetJustifyH justification))

(λ H.set-point [frame ...]
  (: frame :SetPoint ...))

(λ H.create-font-string [frame ...]
  (: frame :CreateFontString ...))

(λ H.get-width [frame]
  (: frame :GetWidth))

(λ H.set-height [frame height]
  (: frame :SetHeight height))

(λ H.create-frame [...]
  (create-frame :Frame ...))

(λ H.create-status-bar [...]
  (create-frame :StatusBar ...))

(set ns.E E)
(set ns.H H)
