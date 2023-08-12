(local (_ {: oUF : E}) ...)

(local unit-is-dead _G.UnitIsDead)
(local unit-is-ghost _G.UnitIsGhost)
(local unit-is-connected _G.UnitIsConnected)
(local unit-health _G.UnitHealth)
(local unit-health-max _G.UnitHealthMax)

(local dead [0.76 0.37 0.37])
(local ghost [0.4 0.76 0.93])
(local health [0.68 0.31 0.31])
(local disconnected oUF.colors.disconnected)

(local trillion 1000000000000)
(local billion 1000000000)
(local million 1000000)
(local thousand 1000)

(lambda format-colour [[r g b] value]
  (: "|cff%02x%02x%02x%s|r" :format (* r 255) (* g 255) (* b 255) value))

; displays as percent
(lambda max-display [cur max]
  (math.floor (+ (* (/ cur max) 100) 0.5)))

(lambda compact-health [value]
  (let [place-value (: "%%.%df" :format 1)]
    (if (> value trillion) (.. (place-value:format (/ value trillion)) :t)
        (> value billion) (.. (place-value:format (/ value billion)) :b)
        (> value million) (.. (place-value:format (/ value million)) :m)
        (> value thousand) (.. (place-value:format (/ value thousand)) :k)
        (: "%d" :format value))))

(lambda health-val [unit]
  (let [cur (unit-health unit)
        max (unit-health-max unit)]
    (if (and (< cur max) (not= cur 0))
        (format-colour health
                       (.. (.. (compact-health cur) " | ")
                           (.. (max-display cur max) "%")))
        (format-colour health (compact-health cur)))))

(lambda health [unit]
  (if (unit-is-dead unit) (format-colour dead :Dead)
      (unit-is-ghost unit) (format-colour ghost :Ghost)
      (not (unit-is-connected unit)) (format-colour disconnected :Disconnected)
      (health-val unit)))

(tset oUF.Tags.Methods "sInterface:health" health)
(tset oUF.Tags.Events "sInterface:health" "UNIT_HEALTH UNIT_CONNECTION")
