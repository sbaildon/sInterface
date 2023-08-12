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
