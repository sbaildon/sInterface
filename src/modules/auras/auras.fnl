(local (_ {: E : H}) ...)

(local grid-layout-util _G.GridLayoutUtil)
(local buff-frame _G.BuffFrame)
(local debuff-frame _G.DebuffFrame)
(local cluster _G.MinimapCluster)
(local hooksecurefunc _G.hooksecurefunc)
(local in-combat-lockdown _G.InCombatLockdown)
(local create-frame _G.CreateFrame)

(local {: set-frame-level : set-frame-strata : get-draw-layer} H)

(λ style []
  (let [aura-container buff-frame.AuraContainer]
    (tset aura-container :iconPadding 10)
    (aura-container:ClearAllPoints)
    (aura-container:SetPoint :TOPRIGHT buff-frame :TOPRIGHT 0 0))
  (buff-frame.CollapseAndExpandButton:Hide))

(λ position []
  (buff-frame:ClearAllPoints)
  (buff-frame:SetPoint :TOPRIGHT cluster :TOPLEFT -13 0))

(λ maybe-position []
  (when (not (in-combat-lockdown))
    (position)
    (style)))

(λ padder [self auras _]
  (let [padding 11
        layout (grid-layout-util.CreateStandardGridLayout self.iconStride
                                                          padding padding -1 -1)]
    (grid-layout-util.ApplyGridLayout auras self.currentGridLayoutInfo.anchor
                                      layout)))

(hooksecurefunc buff-frame :UpdateAuraContainerAnchor maybe-position)
(hooksecurefunc buff-frame.AuraContainer :UpdateGridLayout padder)

(debuff-frame:ClearAllPoints)
(debuff-frame:SetPoint :TOPRIGHT buff-frame :BOTTOMRIGHT 0 30)

(λ style-aura-duration [{:Duration duration :Icon icon}]
  (duration:SetFontObject :GameFontNormalOutline)
  (duration:SetPoint :TOP icon :BOTTOM 0 4))

(λ style-aura [{:Count count :Icon icon &as aura}]
  (when aura.Duration
    (style-aura-duration aura))
  (let [frame (create-frame :Frame nil aura)
        (layer sublayer) (get-draw-layer icon)]
    (frame:SetAllPoints icon)
    (set-frame-strata frame layer)
    (set-frame-level frame sublayer)
    (E:draw-border frame))
  (icon:SetTexCoord 0.1 0.9 0.1 0.9)
  (count:SetFontObject :GameFontNormalOutline)
  (count:SetPoint :BOTTOMLEFT aura :TOPRIGHT 0 0))

(λ maybe-style-aura [aura]
  (when (not (in-combat-lockdown))
    (style-aura aura)))

(λ padder []
  (tset buff-frame.AuraContainer :iconPadding 10))

(hooksecurefunc buff-frame :UpdateAuraButtons padder)

(each [_ f (ipairs buff-frame.auraFrames)]
  (if f.UpdateAuraType
      (hooksecurefunc f :UpdateAuraType maybe-style-aura)))
