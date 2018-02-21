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