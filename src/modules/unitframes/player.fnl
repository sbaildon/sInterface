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

(λ tag [unit widget tag]
  (: unit :Tag widget tag))

(λ create-font-string [frame ...]
  (: frame :CreateFontString ...))

(λ set-widget [widget unit key]
  (tset unit key widget))

(fn health [unit]
  (let [health (create-frame :StatusBar :health unit)]
    (doto health
      (set-all-points)
      (enable-feature :colorClass)
      (enable-feature :colorTapping)
      (enable-feature :colorReaction)
      (set-status-bar-texture)
      (set-widget unit :Health))))

(λ player [unit]
  (E:bordered unit)
  (set-size unit 300 20)
  (health unit)
  (let [htext (create-font-string unit.Health :sInterface_PlayerHealth :ARTWORK
                                  :GameFontNormalOutline)]
    (set-justify-h htext :RIGHT)
    (set-point htext :TOPRIGHT -10 10)
    (tag unit htext "[sInterface:health]"))
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
