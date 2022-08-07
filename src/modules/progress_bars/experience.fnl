(local (_ ns) ...)

(fn player-max-level []
    (let [(restricted-level _ _) (GetRestrictedAccountData)]
      (if (> restricted-level 0) restricted-level _G.MAX_PLAYER_LEVEL)))

(fn get-experience-current []
  ((if (IsWatchingHonorAsXP) _G.UnitHonor _G.UnitXP) "player"))

(fn get-experience-max []
  ((if (IsWatchingHonorAsXP) _G.UnitHonorMax _G.UnitXPMax) "player"))

(fn get-level []
  ((if (IsWatchingHonorAsXP) _G.UnitHonorLevel _G.UnitLevel) "player"))

(fn get-rested []
  (or ((if (IsWatchingHonorAsXP) _G.GetHonorExhaustion _G.GetXPExhaustion)) 0))

(let [bars ns.sInterfaceProgressBars
      holder (bars:CreateBar :experience)
      experience (CreateFrame :StatusBar :experience holder :AnimatedStatusBarTemplate)]
    (experience:SetMatchBarValueToAnimation true)
    (experience:SetAllPoints holder)
    (experience:SetStatusBarTexture "Interface\\AddOns\\sInterface\\media\\bar" :ARTWORK)
    (experience:SetFrameLevel (holder:GetFrameLevel))
    (experience:SetStatusBarColor 1 0 1 1)
    (let [cur (get-experience-current)
          max (get-experience-max)
          lvl (get-level)]
      (experience:SetAnimatedValues cur 0 max lvl)))
