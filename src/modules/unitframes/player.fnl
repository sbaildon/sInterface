(print :hi)
(local (_ {: oUF}) ...)

(local create-frame _G.CreateFrame)

(fn health [unit]
  (let [health (create-frame :StatusBar nil unit)]
    (health:SetHeight 20)
    (health:SetStatusBarTexture :something)
    (set unit.Health health)))

(fn player [unit]
  (health unit)
  (print :testing)
  unit)

(fn shared [_self unit]
  (print unit)
  (match unit :player player))

(oUF:RegisterStyle :sInterface shared)

(oUF:Factory (lambda [self]
               (self:SetActiveStyle :sInterface)
               (let [player (self:Spawn :player)]
                 (player:SetPoint :CENTER))))
