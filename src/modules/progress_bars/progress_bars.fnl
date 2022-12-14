(local (_ ns) ...)

(let [minimap _G.Minimap
      progress-bars (CreateFrame :Frame :sInterfaceProgressBars minimap)]
  (progress-bars:SetPoint :TOPLEFT minimap :BOTTOMLEFT 0 -10)
  (progress-bars:SetPoint :TOPRIGHT minimap :TOPRIGHT 0 -10)
  (progress-bars:SetHeight 20)
  (tset progress-bars :bars {})
  (fn progress-bars.CreateBar [self bar-name]
    (let [frame (CreateFrame :Frame (.. :sInterfaceProgressBars_ bar-name) self)]
      (frame:SetPoint :LEFT self :LEFT)
      (frame:SetPoint :RIGHT self :RIGHT)
      (frame:SetFrameLevel (self:GetFrameLevel))
      (frame:SetHeight 4)
      (tset (. self :bars) bar-name frame)
      (ns.E:bordered frame)
      frame))
  (fn progress-bars.EnableBar [self bar-name]
    (match (?. self :bars bar-name)
      nil nil
      bar (bar:Enable)))
  (fn progress-bars.DisableBar [self bar-name]
    (match (?. self :bars bar-name)
      nil nil
      bar (bar:Disable)))
  (set ns.sInterfaceProgressBars progress-bars))
