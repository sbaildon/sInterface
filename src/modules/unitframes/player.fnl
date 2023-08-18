(local (_ {: oUF : E : H}) ...)

(local unit-is-dead _G.UnitIsDead)
(local unit-is-ghost _G.UnitIsGhost)
(local unit-is-connected _G.UnitIsConnected)

(local {: hide
        : show
        : set-all-points
        : set-script
        : set-vertex-color
        : set-blend-mode
        : set-value
        : set-status-bar-texture
        : set-size
        : set-justify-h
        : create-font-string
        : create-frame
        : get-width
        : set-height
        : create-status-bar
        : create-texture
        : set-texture
        : set-point} H)

(λ unit-is-disconnected [unit]
  (not (unit-is-connected unit)))

(λ enable-feature [frame feature]
  (tset frame feature true))

(λ tag [widget unit tag]
  (: unit :Tag widget tag))

(λ set-widget [widget unit key]
  (tset unit key widget))

(λ highlight [{:Health health &as self}]
  (let [highlight (create-texture health nil :OVERLAY nil nil nil 1)]
    (doto highlight
      (set-all-points)
      (set-texture :Interface/TargetingFrame/UI-TargetingFrame-BarFill)
      (set-vertex-color 1 1 1 0.15)
      (set-blend-mode :ADD)
      (hide))
    (tset self :Highlight highlight)))

(λ post-update-health [self unit cur _max]
  (if (> cur 0) nil
      (unit-is-dead unit) (set-value self 0)
      (unit-is-disconnected unit) (set-value self 0)
      (unit-is-dead unit) (set-value self 0)))

(λ health [unit]
  (let [health (create-status-bar :health unit)
        bg (create-texture health nil :BACKGROUND)]
    (doto bg
      (set-all-points)
      (set-texture)
      (tset :multiplier 0.4))
    (doto health
      (set-all-points)
      (enable-feature :colorClass)
      (enable-feature :colorTapping)
      (enable-feature :colorReaction)
      (set-status-bar-texture)
      (tset :bg bg)
      (set-widget unit :Health))))

(λ post-update-power [self _unit _cur ?_min max]
  (if (= max 0) (hide self) (show self)))

(λ power [unit]
  (let [power-frame (create-frame nil unit)]
    (doto power-frame
      (set-point :LEFT)
      (set-point :RIGHT)
      (set-point :TOP unit :BOTTOM 0 -1)
      (set-height 3)
      (set-widget unit :PowerFrame)))
  (let [power (create-status-bar :power unit.PowerFrame)
        bg (create-texture power nil :BACKGROUND)
        padding (/ (get-width unit) 18)]
    (doto bg
      (set-all-points)
      (set-texture)
      (tset :multiplier 0.4))
    (doto power
      (E:draw-border)
      (set-status-bar-texture)
      (set-point :LEFT padding 0)
      (set-point :RIGHT (- padding) 0)
      (set-point :TOP)
      (set-point :BOTTOM)
      (enable-feature :colorPower)
      (enable-feature :frequentUpdates)
      (enable-feature :Smooth)
      (tset :bg bg)
      (tset :PostUpdate post-update-power)
      (set-widget unit :Power))))

(λ health-text [{:Health health &as unit}]
  (let [htext (create-font-string health :sInterface_PlayerHealth :ARTWORK
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

(λ on-enter [{:Highlight highlight &as _self}]
  (show highlight))

(λ on-leave [{:Highlight highlight &as _self}]
  (hide highlight))

(λ player [unit]
  (doto unit
    (E:draw-border)
    (set-size 230 16)
    (health)
    (health-text)
    (set-script :OnEnter on-enter)
    (set-script :OnLeave on-leave)
    (highlight)
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
    (highlight)
    (set-script :OnEnter on-enter)
    (set-script :OnLeave on-leave)
    (health-text)
    (power)
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
