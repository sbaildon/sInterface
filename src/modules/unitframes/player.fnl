(local (_ {: oUF : E}) ...)

(local create-frame _G.CreateFrame)

(λ set-status-bar-texture [bar]
  (: bar :SetStatusBarTexture "Interface\\AddOns\\sInterface\\media\\bar"))

(λ set-all-points [frame]
  (: frame :SetAllPoints))

(fn health [unit]
  (let [health (create-frame :StatusBar :health unit)]
    (set-all-points health)
    (tset health :colorClass true)
    (tset health :colorTapping true)
    (tset health :colorReaction true)
    (set-status-bar-texture health)
    (tset unit :Health health)))

(λ player [unit]
  (E:bordered unit)
  (unit:SetSize 300 20)
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
