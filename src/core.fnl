(local (_ ns) ...)

(local cf _G.CreateFrame)
(local backdrop-template-mixin _G.BackdropTemplateMixin)
(local E (cf :Frame :sEngine))
(local H (cf :Frame :helpers))

(local default-status-bar-texture "Interface\\AddOns\\sInterface\\media\\bar")

(λ create-frame [...]
  "CreateFrame(frameType [, name, parent, template, id])"
  (_G.CreateFrame ...))

(λ get-frame-strata [frame]
  (: frame :GetFrameStrata))

(λ set-frame-strata [frame strata]
  (: frame :SetFrameStrata strata))

(λ get-frame-level [frame]
  (: frame :GetFrameLevel))

(λ set-frame-level [frame level]
  (: frame :SetFrameLevel level))

(λ set-backdrop [frame backdrop]
  (: frame :SetBackdrop backdrop))

(λ set-backdrop-border-color [frame ...]
  (: frame :SetBackdropBorderColor ...))

(λ set-point [frame ...]
  (: frame :SetPoint ...))

(λ E.bordered [_self frame]
  (let [border-tex :Interface/Tooltips/UI-Tooltip-Border
        border (create-frame :Frame :sInterfaceBorder frame
                             (and backdrop-template-mixin :BackdropTemplate))]
    (set-frame-strata border (get-frame-strata frame))
    (set-frame-level border (get-frame-level frame))
    (set-point border :TOPLEFT frame :TOPLEFT -3 3)
    (set-point border :BOTTOMRIGHT frame :BOTTOMRIGHT 3 -3)
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

(λ H.set-status-bar-texture [bar ?texture]
  (: bar :SetStatusBarTexture (or ?texture default-status-bar-texture)))

(λ H.set-status-bar-color [bar r g b]
  (: bar :SetStatusBarColor r g b))

(λ H.set-size [frame ...]
  (: frame :SetSize ...))

(λ H.set-justify-h [frame justification]
  (: frame :SetJustifyH justification))

(tset H :set-point set-point)

(λ H.create-font-string [frame ...]
  (: frame :CreateFontString ...))

(λ H.get-width [frame]
  (: frame :GetWidth))

(λ H.get-height [frame]
  (: frame :GetHeight))

(λ H.set-height [frame height]
  (: frame :SetHeight height))

(λ H.create-frame [...]
  (create-frame :Frame ...))

(λ H.create-status-bar [...]
  (create-frame :StatusBar ...))

(λ H.create-texture [frame ...]
  "Frame:CreateTexture([name, drawLayer, templateName, subLevel])"
  (: frame :CreateTexture ...))

(λ H.set-texture [texture-base ?texture ...]
  "TextureBase:SetTexture([textureAsset, wrapModeHorizontal, wrapModeVertical, filterMode])"
  (: texture-base :SetTexture (or ?texture default-status-bar-texture) ...))

(λ H.set-color-texture [texture-base r g b ?a]
  "TextureBase:SetColorTexture(colorR, colorG, colorB [, a])"
  (: texture-base :SetColorTexture r g b ?a))

(λ H.get-status-bar-texture [status-bar]
  (: status-bar :GetStatusBarTexture))

(λ H.hide [region]
  (: region :Hide))

(λ H.show [region]
  (: region :Show))

(λ H.set-tex-coord [region ...]
  (: region :SetTexCoord ...))

(λ H.set-value [status-bar value]
  (: status-bar :SetValue value))

(λ H.set-vertex-color [region r g b ?a]
  "Region:SetVertexColor(colorR, colorG, colorB [, a])"
  (: region :SetVertexColor r g b ?a))

(λ H.set-blend-mode [texture-base blend-mode]
  (: texture-base :SetBlendMode blend-mode))

(λ H.set-script [frame handler func]
  (: frame :SetScript handler func))

(λ H.set-text [font-string text]
  (: font-string :SetText text))

(λ H.get-string-height [font-string]
  (: font-string :GetStringHeight))

(set ns.E E)
(set ns.H H)
