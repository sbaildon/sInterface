(local (_ {: oUF : E}) ...)

(local create-frame _G.CreateFrame)

(λ set-status-bar-texture [bar]
  (: bar :SetStatusBarTexture "Interface\\AddOns\\sInterface\\media\\bar"))

(λ set-all-points [frame]
  (: frame :SetAllPoints))

(λ enable-feature [frame feature]
  (tset frame feature true))

(λ set-size [frame ...]
  (: frame :SetSize ...))

(λ set-justify-h [frame justification]
  (: frame :SetJustifyH justification))

(λ set-point [frame ...]
  (: frame :SetPoint ...))

(λ tag [widget unit tag]
  (: unit :Tag widget tag))

(λ create-font-string [frame ...]
  (: frame :CreateFontString ...))

(λ set-widget [widget unit key]
  (tset unit key widget))

(λ health [unit]
  (let [health (create-frame :StatusBar :health unit)]
    (doto health
      (set-all-points)
      (enable-feature :colorClass)
      (enable-feature :colorTapping)
      (enable-feature :colorReaction)
      (set-status-bar-texture)
      (set-widget unit :Health))))

(λ health-text [unit]
  (let [htext (create-font-string unit.Health :sInterface_PlayerHealth :ARTWORK
                                  :GameFontNormalOutline)]
    (doto htext
      (set-justify-h :RIGHT)
      (set-point :TOPRIGHT -10 10)
      (tag unit "[sInterface:health]"))))

(λ power-text [unit]
  (let [ptext (create-font-string unit.Health :sInterface_PlayerPower :ARTWORK
                                  :GameFontNormalOutline)]
    (doto ptext
      (set-justify-h :LEFT)
      (set-point :TOPLEFT 10 10)
      (tset :frequentUpdates 0.1)
      (tag unit "[sInterface:power]"))))

(λ player [unit]
  (doto unit
    (E:bordered)
    (set-size 300 20)
    (health)
    (health-text)
    (power-text))
  unit)

(λ target [unit]
  (doto unit
    (E:bordered)
    (set-size 300 20)
    (health)
    (health-text))
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
                 (set-point player :CENTER)
                 (set-point target :CENTER 0 -50))))
