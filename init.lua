local _, ns = ...
local E, C = CreateFrame('Frame', 'sEngine'), {}
ns.E, ns.C = E, C

function E:HeightPercentage(percentage)
	return (GetScreenHeight() / UIParent:GetEffectiveScale()) * (percentage / 100)
end

function E:WidthPercentage(percentage)
	return (GetScreenWidth() / UIParent:GetEffectiveScale()) * (percentage / 100)
end