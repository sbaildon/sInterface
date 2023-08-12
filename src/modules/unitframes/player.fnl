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

(fn health [unit]
  (let [health (create-frame :StatusBar :health unit)]
    (set-all-points health)
    (enable-feature health :colorClass)
    (enable-feature health :colorTapping)
    (enable-feature health :colorReaction)
    (set-status-bar-texture health)
    (tset unit :Health health)))

(λ player [unit]
  (E:bordered unit)
  (set-size unit 300 20)
  (health unit)
  (print :testing)
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
                 (player:SetPoint :CENTER))))
