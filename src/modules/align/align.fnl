(local create-frame _G.CreateFrame)
(local ui-parent _G.UIParent)
(local get-screen-width _G.GetScreenWidth)

(local vertical-rules 128)
(local horizontal-rules 72)

(let [align (create-frame :Frame :AlignFrame ui-parent)]
  (align:SetAllPoints ui-parent)
  (align:Hide)
  (let [vertical-rule-spacing (/ (get-screen-width) vertical-rules)]
    (for [i 0 vertical-rules]
      (let [rule (align:CreateTexture nil :BACKGROUND)]
        (if (= i (/ vertical-rules 2)) (rule:SetColorTexture 0.6 0.8 0.95 0.5)
            (= 0 (% i 2)) (rule:SetColorTexture 1 1 1 0.2)
            (rule:SetColorTexture 1 1 1 0.075))
        (rule:SetPoint :TOPLEFT align :TOPLEFT
                       (- (* vertical-rule-spacing i) 1) 0)
        (rule:SetPoint :BOTTOMRIGHT align :BOTTOMLEFT
                       (+ (* vertical-rule-spacing i) 1) 0))))
  (let [horizontal-rule-spacing (/ (get-screen-width) horizontal-rules)]
    (for [i 0 horizontal-rules]
      (let [rule (align:CreateTexture nil :BACKGROUND)]
        (if (= i (/ horizontal-rules 2))
            (rule:SetColorTexture 0.6 0.8 0.95 0.5)
            (= 0 (% i 2))
            (rule:SetColorTexture 1 1 1 0.2)
            (rule:SetColorTexture 1 1 1 0.075))
        (rule:SetPoint :TOPLEFT align :TOPLEFT 0
                       (+ (* horizontal-rule-spacing (- i)) 1))
        (rule:SetPoint :BOTTOMRIGHT align :TOPRIGHT 0
                       (- (* horizontal-rule-spacing (- i)) 1))))))
