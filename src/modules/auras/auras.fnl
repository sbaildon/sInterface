(local (_ ns) ...)

(local buff-frame _G.BuffFrame)
(local debuff-frame _G.DebuffFrame)
(local cluster _G.MinimapCluster)
(local hooksecurefunc _G.hooksecurefunc)
(local in-combat-lockdown _G.InCombatLockdown)

(λ style []
  (let [aura-container buff-frame.AuraContainer]
    (aura-container:ClearAllPoints)
    (aura-container:SetPoint :TOPRIGHT buff-frame :TOPRIGHT 0 0))
  (buff-frame.CollapseAndExpandButton:Hide))

(λ position []
  (buff-frame:ClearAllPoints)
  (buff-frame:SetParent cluster)
  (buff-frame:SetPoint :TOPRIGHT cluster :TOPLEFT -13 0))

(λ maybe-position []
  (when (not (in-combat-lockdown))
    (print :positioning)
    (position)))

(λ things []
  (print :entry)
  (maybe-position)
  (style))

(hooksecurefunc buff-frame :Update things)

(debuff-frame:ClearAllPoints)
(debuff-frame:SetPoint :TOPRIGHT buff-frame :BOTTOMRIGHT 0 30)

(λ update [{:Duration duration :Count count &as aura}]
  (count:SetFontObject :GameFontNormalOutline)
  (count:SetPoint :BOTTOMLEFT aura :TOPRIGHT 0 0)
  (duration:SetFontObject :GameFontNormalOutline)
  (duration:SetPoint :TOP aura :BOTTOM 0 14))

(each [_ f (ipairs buff-frame.auraFrames)]
  (if f.OnUpdate
      (hooksecurefunc f :OnUpdate update)))
