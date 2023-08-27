(local (_ {: oUF : E : H}) ...)

(local unit-is-dead _G.UnitIsDead)
(local unit-is-ghost _G.UnitIsGhost)
(local unit-is-connected _G.UnitIsConnected)

(local feedback-icon-texture "|T%2$s:0:0:0:0:64:64:4:60:4:60|t %1$s")

(local {: hide
        : show
        : stop
        : play
        : set-font-object
        : set-word-wrap
        : set-non-space-wrap
        : get-parent
        : set-alpha
        : set-text
        : set-width
        : set-tex-coord
        : get-status-bar-texture
        : set-status-bar-color
        : get-string-height
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
        : get-height
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

(λ floating-combat-feedback [{:Health health &as self}]
  (let [feedback (create-frame nil health)]
    (doto feedback
      (set-size 32 32)
      (set-point :CENTER)
      (tset :fontHeight 16)
      (tset :useCLEU true)
      (tset :format feedback-icon-texture)
      (tset :mode :Fountain))
    (for [i 1 6]
      (tset feedback i
            (create-font-string feedback (.. :fcf_ i) :OVERLAY :CombatTextFont)))
    (tset self :FloatingCombatFeedback feedback)))

(λ layout-icon-and-cast-bar [unit-frame {:Icon icon &as cast-bar}]
  (let [gap 7
        uf-width (get-width unit-frame)
        icon-width (get-width icon)]
    (set-point icon :BOTTOMRIGHT cast-bar :BOTTOMLEFT (- gap) 0)
    (set-width cast-bar (- uf-width (+ icon-width gap)))))

(λ handle-cast-anim-finished [self _requested]
  (let [cast-bar (get-parent self)]
    (doto cast-bar
      (hide)
      (set-alpha 1))))

(λ post-cast-stop [self unit]
  (play self.FadeOutAnim))

(λ post-cast-fail [self unit]
  (set-status-bar-color self 1 0.09 0)
  (play self.HoldFadeOutAnim)
  (play self.InterruptShakeAnim))

(λ post-cast-start [self unit]
  (stop self.HoldFadeOutAnim)
  (stop self.FadeOutAnim)
  (layout-icon-and-cast-bar (: self :GetParent) self)
  (case self
    {:notInterruptible _} (set-status-bar-color self 0.65 0.65 0.65)
    {:casting _} (set-status-bar-color self 1 1 0)
    {:channeling _} (set-status-bar-color self 0 1 0)))

(λ cast-bar [{:PowerFrame power-frame : unit &as self}]
  (let [cast-bar (create-status-bar (.. :cast_bar_ unit) self
                                    :CastingBarFrameAnimsFXTemplate)
        spark (create-texture cast-bar nil :OVERLAY)
        icon (create-texture cast-bar nil :ARTWORK)
        name (create-font-string cast-bar :name :ARTWORK
                                 :GameFontHighlightOutline)
        time (create-font-string cast-bar :casty :ARTWORK
                                 :GameFontHighlightOutline)]
    (set-script cast-bar.HoldFadeOutAnim :OnFinished handle-cast-anim-finished)
    (set-script cast-bar.FadeOutAnim :OnFinished handle-cast-anim-finished)
    (doto cast-bar
      (E:draw-border)
      (set-status-bar-texture)
      (set-point :TOPRIGHT power-frame :BOTTOMRIGHT 0 -30)
      (tset :PostCastStart post-cast-start)
      (tset :PostCastFail post-cast-fail)
      (tset :PostCastStop post-cast-stop)
      (set-size 230 10)
      (set-widget self :Castbar))
    (doto icon
      (set-point :BOTTOMRIGHT cast-bar :BOTTOMLEFT 0 0)
      (set-size 20 20)
      (set-tex-coord 0.1 0.9 0.1 0.9)
      (set-widget cast-bar :Icon))
    (doto spark
      (set-size 10 (* (get-height cast-bar) 3))
      (set-blend-mode :ADD)
      (set-point :CENTER (get-status-bar-texture cast-bar) :RIGHT 0 0)
      (set-widget cast-bar :Spark))
    (doto name
      (set-justify-h :LEFT)
      (set-point :TOPLEFT 4 7)
      (set-text :null)
      (set-widget cast-bar :Text)
      (set-height (get-string-height name)))
    (doto time
      (set-justify-h :RIGHT)
      (set-point :TOPRIGHT -4 7)
      (set-widget cast-bar :Time))))

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
      (unit-is-ghost unit) (set-value self 0)
      (unit-is-disconnected unit) (set-value self 0)))

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

(fn post-update-power [self _unit _cur _min max]
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
      (tag unit "[sInterface:health]"))
    (tset unit :RightText htext)))

(λ power-text [{:Health health &as unit}]
  (let [ptext (create-font-string health :sInterface_PlayerPower :ARTWORK
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

(λ calculate-spacing [width size]
  (var spacing 0)
  (var iterations 0)
  (var buttons-per-row 0)
  (while (< spacing 4)
    (set buttons-per-row (- (math.floor (/ width size)) iterations))
    (local leftover (- width (* buttons-per-row size)))
    (set spacing (/ leftover (- buttons-per-row 1)))
    (set iterations (+ iterations 1)))
  (print spacing)
  (print buttons-per-row)
  [spacing buttons-per-row])

(λ post-create-button [_auras
                        {:Cooldown cooldown :Icon icon :Count count &as button}]
  (set-font-object count :SystemFont_Shadow_Small_Outline)
  (set-point count :BOTTOMRIGHT 3 -2)
  (: cooldown :SetReverse true)
  (set-tex-coord icon 0.05 0.95 0.2 0.7))

(λ post-update-button [_auras button]
  (set-height button (/ (get-width button) 1.4)))

(λ auras [unit-frame ?mode]
  (let [size 18
        auras (create-frame :Frame nil unit-frame)
        [spacing buttons-per-row] (calculate-spacing (get-width unit-frame)
                                                     size)]
    (doto auras
      (set-point :BOTTOMLEFT unit-frame :TOPLEFT 0 8)
      (set-size (get-width unit-frame) 300)
      (tset :size size)
      (tset :PostCreateButton post-create-button)
      (tset :PostUpdateButton post-update-button)
      (tset :spacing spacing)
      (tset :buttonsPerRow buttons-per-row)
      (tset :growth-y :UP))
    (case (or ?mode :auras)
      :auras (set-widget auras unit-frame :Auras)
      :buffs (set-widget auras unit-frame :Buffs)
      :debuffs (set-widget auras unit-frame :Debuffs))))

(λ player [unit]
  (doto unit
    (E:draw-border)
    (set-size 230 16)
    (auras :buffs)
    (health)
    (floating-combat-feedback)
    (health-text)
    (set-script :OnEnter on-enter)
    (set-script :OnLeave on-leave)
    (highlight)
    (power)
    (cast-bar)
    (power-text))
  unit)

(λ maybe-truncate-text [unit]
  "Sets the left text against the right text, so that the left text will truncate"
  (case unit
    {:LeftText left :RightText right} (set-point left :RIGHT right :LEFT -3 0)
    {} nil))

(λ name-text [{:Health health &as unit}]
  (let [name (create-font-string health :sInterface_TargetName :ARTWORK
                                 :GameFontNormalMed2Outline)]
    (doto name
      (set-justify-h :LEFT)
      (set-point :TOPLEFT unit 4 7)
      (set-word-wrap false)
      (set-non-space-wrap false)
      (tag unit "[sInterface:level<$ ][sInterface:name]"))
    (tset unit :LeftText name)))

(λ target [unit]
  (doto unit
    (E:draw-border)
    (set-size 230 16)
    (auras :auras)
    (health)
    (highlight)
    (set-script :OnEnter on-enter)
    (set-script :OnLeave on-leave)
    (health-text)
    (power)
    (name-text)
    (maybe-truncate-text))
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
