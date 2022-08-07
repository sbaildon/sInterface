(local vertical-rules 128)
(local horizontal-rules 72)

(let [align (CreateFrame :Frame :AlignFrame UIParent)]
  (align:SetAllPoints UIParent)
  (let [vertical-rule-spacing (/ (GetScreenWidth) vertical-rules)]
    (for [i 0 vertical-rules]
      (let [rule (align:CreateTexture nil :BACKGROUND)]
        (if (= i (/ vertical-rules 2)) (rule:SetColorTexture 0.6 0.8 0.95 0.5)
            (= 0 (% i 2)) (rule:SetColorTexture 1 1 1 0.2)
            (rule:SetColorTexture 1 1 1 0.075))
        (rule:SetPoint :TOPLEFT align :TOPLEFT
                       (- (* vertical-rule-spacing i) 1) 0)
        (rule:SetPoint :BOTTOMRIGHT align :BOTTOMLEFT
                       (+ (* vertical-rule-spacing i) 1) 0))))
  (let [horizontal-rule-spacing (/ (GetScreenWidth) horizontal-rules)]
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
