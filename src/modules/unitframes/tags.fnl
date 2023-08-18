(local (_ {: oUF : E}) ...)

(local unit-is-dead _G.UnitIsDead)
(local unit-is-ghost _G.UnitIsGhost)
(local unit-is-connected _G.UnitIsConnected)
(local unit-health _G.UnitHealth)
(local unit-health-max _G.UnitHealthMax)
(local unit-power _G.UnitPower)
(local unit-effective-level _G.UnitEffectiveLevel)
(local max-player-level _G.MAX_PLAYER_LEVEL)
(local get-difficulty-color _G.GetDifficultyColor)
(local get-content-difficulty-creature-for-player
       _G.C_PlayerInfo.GetContentDifficultyCreatureForPlayer)

(local dead [0.76 0.37 0.37])
(local ghost [0.4 0.76 0.93])
(local health [0.68 0.31 0.31])
(local disconnected oUF.colors.disconnected)

(local trillion 1000000000000)
(local billion 1000000000)
(local million 1000000)
(local thousand 1000)

(lambda format [thing ...]
  (: thing :format ...))

(lambda format-colour [[r g b] value]
  (: "|cff%02x%02x%02x%s|r" :format (* r 255) (* g 255) (* b 255) value))

; displays as percent
(lambda max-display [cur max]
  (math.floor (+ (* (/ cur max) 100) 0.5)))

(lambda compact-value [value]
  (let [place-value (: "%%.%df" :format 1)]
    (if (> value trillion) (.. (format place-value (/ value trillion)) :t)
        (> value billion) (.. (format place-value (/ value billion)) :b)
        (> value million) (.. (format place-value (/ value million)) :m)
        (> value thousand) (.. (format place-value (/ value thousand)) :k)
        (: "%d" :format value))))

(lambda health-val [unit]
  (let [cur (unit-health unit)
        max (unit-health-max unit)]
    (if (and (< cur max) (not= cur 0))
        (format-colour health
                       (.. (compact-value cur) " | " (max-display cur max) "%"))
        (format-colour health (compact-value cur)))))

(lambda health [unit]
  (if (unit-is-dead unit) (format-colour dead :Dead)
      (unit-is-ghost unit) (format-colour ghost :Ghost)
      (not (unit-is-connected unit)) (format-colour disconnected :Disconnected)
      (health-val unit)))

(tset oUF.Tags.Methods "sInterface:health" health)
(tset oUF.Tags.Events "sInterface:health" "UNIT_HEALTH UNIT_CONNECTION")

(lambda power [unit]
  (.. ((. oUF.Tags.Methods :powercolor) unit) (compact-value (unit-power unit))))

(tset oUF.Tags.Methods "sInterface:power" power)
(tset oUF.Tags.Events "sInterface:power"
      "UNIT_POWER_UPDATE PLAYER_SPECIALIZATION_CHANGED PLAYER_TALENT_UPDATE UNIT_CONNECTION")

(lambda level [unit]
  (let [level (unit-effective-level unit)
        difficulty (get-content-difficulty-creature-for-player unit)
        {: r : g : b} (get-difficulty-color difficulty)]
    (if (= level max-player-level) nil
        (<= level 0) (format-colour [r g b] "??")
        (format-colour [r g b] level))))

(tset oUF.Tags.Methods "sInterface:level" level)
(tset oUF.Tags.Events "sInterface:level" "UNIT_LEVEL UNIT_CONNECTION")

(lambda name [unit]
  (format-colour [1 1 1] ((. oUF.Tags.Methods :name) unit)))

(tset oUF.Tags.Methods "sInterface:name" name)
(tset oUF.Tags.Events "sInterface:name"
      "UNIT_CONNECTION UNIT_NAME_UPDATE UNIT_THREAT_SITUATION_UPDATE")
