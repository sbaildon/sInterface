(local (_ {: oUF : E : H}) ...)

(local {: set-all-points
        : set-status-bar-texture
        : set-size
        : set-justify-h
        : create-font-string
        : create-frame
        : get-width
        : set-height
        : create-status-bar
        : set-point} H)

(λ enable-feature [frame feature]
  (tset frame feature true))

(λ tag [widget unit tag]
  (: unit :Tag widget tag))

(λ set-widget [widget unit key]
  (tset unit key widget))

(λ health [unit]
  (let [health (create-status-bar :health unit)]
    (doto health
      (set-all-points)
      (enable-feature :colorClass)
      (enable-feature :colorTapping)
      (enable-feature :colorReaction)
      (set-status-bar-texture)
      (set-widget unit :Health))))

(λ power [unit]
  (let [power-frame (create-frame nil unit)]
    (doto power-frame
      (set-point :LEFT)
      (set-point :RIGHT)
      (set-point :TOP unit :BOTTOM 0 -1)
      (set-height 3)
      (set-widget unit :PowerFrame)))
  (let [power (create-status-bar :power unit.PowerFrame)
        padding (/ (get-width unit) 18)]
    (doto power
      (E:draw-border)
      (set-status-bar-texture)
      (set-point :LEFT padding 0)
      (set-point :RIGHT (- padding) 0)
      (set-point :TOP)
      (set-point :BOTTOM)
      (enable-feature :colorPower)
      (enable-feature :Smooth)
      (set-widget unit :Power))))

(λ health-text [unit]
  (let [htext (create-font-string unit.Health :sInterface_PlayerHealth :ARTWORK
                                  :GameFontNormalMed2Outline)]
    (doto htext
      (set-justify-h :RIGHT)
      (set-point :TOPRIGHT -4 7)
      (tag unit "[sInterface:health]"))))

(λ power-text [unit]
  (let [ptext (create-font-string unit.Health :sInterface_PlayerPower :ARTWORK
                                  :GameFontNormalMed2Outline)]
    (doto ptext
      (set-justify-h :LEFT)
      (set-point :TOPLEFT 4 7)
      (tset :frequentUpdates 0.1)
      (tag unit "[sInterface:power]"))))

(λ player [unit]
  (doto unit
    (E:draw-border)
    (set-size 230 16)
    (health)
    (health-text)
    (power)
    (power-text))
  unit)

(λ name-text [unit]
  (let [name (create-font-string unit.Health :sInterface_TargetName :ARTWORK
                                 :GameFontNormalMed2Outline)]
    (doto name
      (set-justify-h :LEFT)
      (set-point :TOPLEFT unit 4 7)
      (tag unit "[sInterface:level<$ ][sInterface:name]"))))

(λ target [unit]
  (doto unit
    (E:draw-border)
    (set-size 230 16)
    (health)
    (health-text)
    (name-text))
  unit)

(fn shared [self unit]
  (match unit
    :player (player self)
    :target (target self)))

(oUF:RegisterStyle :sInterface shared)

(oUF:Factory (lambda [self]
               (self:SetActiveStyle :sInterface)
               (let [player (self:Spawn :player)
                     target (self:Spawn :target)]
                 (set-point player :CENTER 0 -150)
                 (set-point target :BOTTOMLEFT :oUF_sInterfacePlayer :TOPRIGHT
                            55 75))))
