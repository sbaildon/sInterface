(local (_ ns) ...)

(let [minimap _G.Minimap
      progress-bars (CreateFrame :Frame :sInterfaceProgressBars minimap)]
  (progress-bars:SetPoint :TOPLEFT minimap :BOTTOMLEFT 0 -10)
  (progress-bars:SetPoint :TOPRIGHT minimap :TOPRIGHT 0 -10)
  (progress-bars:SetHeight 20)
  (fn progress-bars.CreateBar [self barName]
    (let [frame (CreateFrame :Frame (.. :sInterfaceProgressBars_ barName) self)]
      (frame:SetPoint :LEFT self :LEFT)
      (frame:SetPoint :RIGHT self :RIGHT)
      (frame:SetFrameLevel (self:GetFrameLevel))
      (frame:SetHeight 4)
      (ns.E:bordered frame)
      frame))
  (set ns.sInterfaceProgressBars progress-bars))
