(local (_ {: oUF : E}) ...)

(local create-frame _G.CreateFrame)

(fn health [unit]
  (let [health (create-frame :StatusBar :health unit)]
    (health:SetAllPoints)
    (tset health :colorClass true)
    (tset health :colorTapping true)
    (tset health :olorReaction true)
    (health:SetStatusBarTexture "Interface\\AddOns\\sInterface\\media\\bar")
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
