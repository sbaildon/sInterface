(local (_ {: oUF : E}) ...)

(local create-frame _G.CreateFrame)

(λ set-status-bar-texture [bar]
  (: bar :SetStatusBarTexture "Interface\\AddOns\\sInterface\\media\\bar"))

(λ set-all-points [frame]
  (: frame :SetAllPoints))

(λ enable-feature [frame feature]
  (tset frame feature true))

(λ set-size [frame ...]
  (: frame :SetSize ...))

(λ set-justify-h [frame justification]
  (: frame :SetJustifyH justification))

(λ set-point [frame ...]
  (: frame :SetPoint ...))

(λ tag [widget unit tag]
  (: unit :Tag widget tag))

(λ create-font-string [frame ...]
  (: frame :CreateFontString ...))

(λ set-widget [widget unit key]
  (tset unit key widget))

(λ health [unit]
  (let [health (create-frame :StatusBar :health unit)]
    (doto health
      (set-all-points)
      (enable-feature :colorClass)
      (enable-feature :colorTapping)
      (enable-feature :colorReaction)
      (set-status-bar-texture)
      (set-widget unit :Health))))

(λ health-text [unit]
  (let [htext (create-font-string unit.Health :sInterface_PlayerHealth :ARTWORK
                                  :GameFontNormalOutline)]
    (doto htext
      (set-justify-h :RIGHT)
      (set-point :TOPRIGHT -10 10)
      (tag unit "[sInterface:health]"))))

(λ player [unit]
  (E:bordered unit)
  (set-size unit 300 20)
  (health unit)
  (health-text unit)
  unit)

(λ target [unit]
  (print :target))

(fn shared [self unit]
  (match unit
    :player (player self)
    :target target))

(oUF:RegisterStyle :sInterface shared)

(oUF:Factory (lambda [self]
               (self:SetActiveStyle :sInterface)
               (let [player (self:Spawn :player)]
                 (set-point player :CENTER))))
