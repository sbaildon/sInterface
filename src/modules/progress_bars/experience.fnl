(local (_ ns) ...)

(fn max-player-level []
  (let [(restricted-level _ _) (_G.GetRestrictedAccountData)]
    (if (> restricted-level 0) restricted-level _G.MAX_PLAYER_LEVEL)))

(fn unit-is-max-level? [unit]
  (= (_G.UnitLevel unit) (max-player-level)))

(fn get-experience-current []
  ((if (_G.IsWatchingHonorAsXP) _G.UnitHonor _G.UnitXP) :player))

(fn get-experience-max []
  ((if (_G.IsWatchingHonorAsXP) _G.UnitHonorMax _G.UnitXPMax) :player))

(fn get-level []
  ((if (_G.IsWatchingHonorAsXP) _G.UnitHonorLevel _G.UnitLevel) :player))

(fn get-rested []
  (or ((if (_G.IsWatchingHonorAsXP) _G.GetHonorExhaustion _G.GetXPExhaustion))
      0))

(fn set-colour [bar]
  (let [[r g b a] (if (_G.IsWatchingHonorAsXP) [1 0.25 0 1] [1 0 1 1])]
    (bar:SetStatusBarColor r g b a)))

(fn set-values [bar]
  (let [cur (get-experience-current)
        max (get-experience-max)
        lvl (get-level)
        rst (get-rested)]
    (bar:SetAnimatedValues cur 0 max lvl)
    (bar.Exhaustion:SetMinMaxValues 0 max)
    (bar.Exhaustion:SetValue (math.min (+ cur rst) max))))

(fn update [bar]
  (set-colour bar)
  (set-values bar))

(fn register-xp-events [bar]
  (each [_ event (ipairs [:PLAYER_XP_UPDATE
                          :HONOR_LEVEL_UPDATE
                          :HONOR_XP_UPDATE
                          :UPDATE_EXHAUSTION])]
    (bar:RegisterEvent event)))

(fn unregister-xp-events [bar]
  (each [_ event (ipairs [:PLAYER_XP_UPDATE
                          :HONOR_LEVEL_UPDATE
                          :HONOR_XP_UPDATE
                          :UPDATE_EXHAUSTION])]
    (bar:UnregisterEvent event)))

(fn visibility [self]
  (if (or (and (unit-is-max-level? :player) (not (_G.IsWatchingHonorAsXP)))
          (_G.IsXPUserDisabled))
      (unregister-xp-events self.Experience)
      (do
        (register-xp-events self.Experience)
        (update self.Experience))))

(local bars ns.sInterfaceProgressBars)

(let [frame (bars:CreateBar :experience)]
  (frame:SetScript :OnEvent visibility)

  (fn frame.Enable [self]
    (each [_ event (ipairs [:PLAYER_LEVEL_UP
                            :DISABLE_XP_GAIN
                            :ENABLE_XP_GAIN
                            :PLAYER_ENTERING_WORLD])]
      (frame:RegisterEvent event))
    (visibility frame))

  (fn frame.Disable [self]
    (each [_ event (ipairs [:PLAYER_LEVEL_UP
                            :DISABLE_XP_GAIN
                            :ENABLE_XP_GAIN
                            :PLAYER_ENTERING_WORLD])]
      (frame:UnregisterEvent event)))

  (let [experience (CreateFrame :StatusBar :experience frame
                                :AnimatedStatusBarTemplate)]
    (experience:SetMatchBarValueToAnimation true)
    (experience:SetAllPoints frame)
    (experience:SetStatusBarTexture "Interface\\AddOns\\sInterface\\media\\bar"
                                    :ARTWORK)
    (experience:SetScript :OnEvent update)
    (set frame.Experience experience)
    (let [exhaustion (CreateFrame :StatusBar :exhaustion experience)]
      (exhaustion:SetStatusBarTexture "Interface\\AddOns\\sInterface\\media\\bar"
                                      :ARTWORK)
      (exhaustion:SetAllPoints experience)
      (exhaustion:SetStatusBarColor 0 0.4 1)
      (exhaustion:SetFrameLevel (- (experience:GetFrameLevel) 1))
      (set experience.Exhaustion exhaustion)))
  (bars:EnableBar :experience))

