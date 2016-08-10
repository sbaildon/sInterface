local name, ns = ...
local cfg = ns.cfg

local solid = "Interface\\AddOns\\Kui_Media\\t\\solid"
local shadow = "Interface\\AddOns\\sInterface\\media\\shadow_border"

framebd = function(parent, anchor) 
    local frame = CreateFrame('Frame', nil, parent)
    frame:SetFrameStrata('BACKGROUND')
    frame:SetFrameLevel(0)
    frame:SetPoint('TOPLEFT', anchor, 'TOPLEFT', -1, 1)
    frame:SetPoint('BOTTOMRIGHT', anchor, 'BOTTOMRIGHT', 1, -1)
    frame:SetBackdrop({
	    edgeFile = solid, edgeSize = 1,
	    bgFile = [=[Interface\ChatFrame\ChatFrameBackground]=],
	    insets = {left = 0, right = 0, top = 0, bottom = 0}
    })
    frame:SetBackdropColor(0, 0, 0, 0.6)
    frame:SetBackdropBorderColor(0, 0, 0)

    local shadowframe = CreateFrame('Frame', nil, frame)
    shadowframe:SetFrameStrata('BACKGROUND')
    shadowframe:SetPoint('TOPLEFT', frame, 'TOPLEFT', -3, 3)
    shadowframe:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', 3, -3)
    shadowframe:SetBackdrop({
	    edgeFile = shadow, edgeSize = 5,
    })
    shadowframe:SetBackdropBorderColor(0, 0, 0, 0.7)
    return frame
end

createStatusbar = function(parent, tex, layer, height, width, r, g, b, alpha)
    local bar = CreateFrame'StatusBar'
    bar:SetParent(parent)
    if height then
        bar:SetHeight(height)
    end
    if width then
        bar:SetWidth(width)
    end
    bar:SetStatusBarTexture(tex, layer)
    bar:SetStatusBarColor(r, g, b, alpha)
    return bar
end

fs = function(parent, layer, font, fontsiz, outline, r, g, b, justify)
    local string = parent:CreateFontString(nil, layer)
    string:SetFont(font, fontsiz, outline)
    string:SetShadowOffset(cfg.shadowoffsetX, cfg.shadowoffsetY)
    string:SetTextColor(r, g, b)
    if justify then
        string:SetJustifyH(justify)
    end
    return string
end

local hider = CreateFrame("Frame", "Hider", UIParent)
hider:Hide()

