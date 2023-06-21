(local (_ ns) ...)

(local create-frame _G.CreateFrame)
(local is-watching-honor-as-xp _G.IsWatchingHonorAsXP)
(local unit-level _G.IsWatchingHonorAsXP)
(local get-restricted-account-data _G.GetRestrictedAccountData)
(local unit-honor _G.UnitHonor)
(local unit-xp _G.UnitXP)
(local unit-honor-max _G.UnitHonorMax)
(local unit-xp-max _G.UnitXPMax)
(local unit-honor-level _G.UnitHonorLevel)
(local unit-level _G.UnitLevel)
(local get-honor-exhaustion _G.GetHonorExhaustion)
(local get-xp-exhaustion _G.GetXPExhaustion)
(local is-xp-user-disabled _G.IsXPUserDisabled)

(λ max-player-level []
  (let [(restricted-level _ _) (get-restricted-account-data)]
    (if (> restricted-level 0) restricted-level _G.MAX_PLAYER_LEVEL)))

(λ unit-is-max-level? [unit]
  (= (unit-level unit) (max-player-level)))

(λ get-experience-current []
  ((if (is-watching-honor-as-xp) unit-honor unit-xp) :player))

(λ get-experience-max []
  ((if (is-watching-honor-as-xp) unit-honor-max unit-xp-max) :player))

(λ get-level []
  ((if (is-watching-honor-as-xp) unit-honor-level unit-level) :player))

(λ get-rested []
  (or ((if (is-watching-honor-as-xp) get-honor-exhaustion get-xp-exhaustion)) 0))

(λ set-colour [bar]
  (let [[r g b a] (if (is-watching-honor-as-xp) [1 0.25 0 1] [1 0 1 1])]
    (bar:SetStatusBarColor r g b a)))

(λ set-values [bar]
  (let [cur (get-experience-current)
        max (get-experience-max)
        lvl (get-level)
        rst (get-rested)]
    (bar:SetAnimatedValues cur 0 max lvl)
    (bar.Exhaustion:SetMinMaxValues 0 max)
    (bar.Exhaustion:SetValue (math.min (+ cur rst) max))))

(λ update [bar]
  (set-colour bar)
  (set-values bar))

(λ register-xp-events [bar]
  (each [_ event (ipairs [:PLAYER_XP_UPDATE
                          :HONOR_LEVEL_UPDATE
                          :HONOR_XP_UPDATE
                          :UPDATE_EXHAUSTION])]
    (bar:RegisterEvent event)))

(λ unregister-xp-events [bar]
  (each [_ event (ipairs [:PLAYER_XP_UPDATE
                          :HONOR_LEVEL_UPDATE
                          :HONOR_XP_UPDATE
                          :UPDATE_EXHAUSTION])]
    (bar:UnregisterEvent event)))

(λ visibility [self]
  (if (or (and (unit-is-max-level? :player) (not (is-watching-honor-as-xp)))
          (is-xp-user-disabled))
      (unregister-xp-events self.Experience)
      (do
        (register-xp-events self.Experience)
        (update self.Experience))))

(local bars ns.sInterfaceProgressBars)

(let [frame (bars:CreateBar :experience)]
  (frame:SetScript :OnEvent visibility)

  (fn frame.Enable [_self]
    (each [_ event (ipairs [:PLAYER_LEVEL_UP
                            :DISABLE_XP_GAIN
                            :ENABLE_XP_GAIN
                            :PLAYER_ENTERING_WORLD])]
      (frame:RegisterEvent event))
    (visibility frame))

  (fn frame.Disable [_self]
    (each [_ event (ipairs [:PLAYER_LEVEL_UP
                            :DISABLE_XP_GAIN
                            :ENABLE_XP_GAIN
                            :PLAYER_ENTERING_WORLD])]
      (frame:UnregisterEvent event)))

  (let [experience (create-frame :StatusBar :experience frame
                                 :AnimatedStatusBarTemplate)]
    (experience:SetMatchBarValueToAnimation true)
    (experience:SetAllPoints frame)
    (experience:SetStatusBarTexture "Interface\\AddOns\\sInterface\\media\\bar"
                                    :ARTWORK)
    (experience:SetScript :OnEvent update)
    (set frame.Experience experience)
    (let [exhaustion (create-frame :StatusBar :exhaustion experience)]
      (exhaustion:SetStatusBarTexture "Interface\\AddOns\\sInterface\\media\\bar"
                                      :ARTWORK)
      (exhaustion:SetAllPoints experience)
      (exhaustion:SetStatusBarColor 0 0.4 1)
      (exhaustion:SetFrameLevel (- (experience:GetFrameLevel) 1))
      (set experience.Exhaustion exhaustion)))
  (bars:EnableBar :experience))
