local name, ns = ...

local C = ns.C

createStatusbar = function(parent, tex, layer, height, width, r, g, b, alpha)
    local bar = CreateFrame("StatusBar", nil, parent)
    if height then
        bar:SetHeight(height)
    end
    if width then
        bar:SetWidth(width)
    end
    bar:SetStatusBarTexture(tex, layer or "ARTWORK")
    if (r and b and g and alpha) then
	    bar:SetStatusBarColor(r, g, b, alpha)
    end
    return bar
end

fs = function(parent, layer, font, fontsiz, outline, r, g, b, justify)
    local string = parent:CreateFontString(nil, layer)
    string:SetFont(C.general.secondarFont, fontsiz, outline)
    string:SetTextColor(r, g, b)
    if justify then
        string:SetJustifyH(justify)
    end
    return string
end

local hider = CreateFrame("Frame", "Hider", UIParent)
hider:Hide()

