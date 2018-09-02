local _, ns = ...
local E, C = ns.E, ns.C

if not C.np.enabled then return end;

local colours = {
	secure = {  0.2, 0.8, 0.1 },
	insecure = { 1, 1, 0.3},
	na = { 1, 0, 0 },
	reaction = {}
}

local multiplier = 0.4

for eclass, color in next, FACTION_BAR_COLORS do
	colours.reaction[eclass] = {color.r, color.g, color.b}
end

local sPlates = CreateFrame("FRAME")

function sPlates:NAME_PLATE_UNIT_ADDED(...)
	local namePlateUnitToken = ...
	local namePlateFrameBase = C_NamePlate.GetNamePlateForUnit(namePlateUnitToken, issecure());

	if not namePlateFrameBase then return end

	local namePlate = namePlateFrameBase.UnitFrame

	local castBar = namePlate.castBar
	castBar:SetStatusBarTexture(C.general.texture)
	castBar:SetHeight(3)

	local healthBar = namePlate.healthBar
	if healthBar == nil or healthBar:IsForbidden() or UnitAffectingCombat("player") then return end
	healthBar:SetPoint("BOTTOMLEFT", castBar, "TOPLEFT", 0, 3)
	healthBar:SetPoint("BOTTOMRIGHT", castBar, "TOPRIGHT", 0, 3)
end

hooksecurefunc("CompactUnitFrame_UpdateAggroFlash", function(frame)
	if UnitIsPlayer(frame.unit) then return end

	local status = UnitThreatSituation("player", frame.unit)
	local r, g, b
	if (not (C.np.tankMode and E:PlayerIsTank())) or (status == nil) then
		local reaction = colours.reaction[UnitReaction(frame.unit, "player")]
		if not reaction then return end
		r, g, b = unpack(reaction)
	elseif status == 3 then
		r, g, b = unpack(colours.secure)
	elseif status == 2 then
		r, g, b = unpack(colours.insecure)
	else
		r, g, b = unpack(colours.na)
	end
	frame.healthBar.barTexture:SetVertexColor (r, g, b)
	frame.healthBar.background:SetVertexColor(r*multiplier, g*multiplier, b*multiplier, 1)
end)

hooksecurefunc("CompactUnitFrame_UpdateHealthColor", function(frame)
	local r, g, b = frame.healthBar:GetStatusBarColor()
	frame.healthBar.background:SetVertexColor(r*multiplier, g*multiplier, b*multiplier, 1)
end)

hooksecurefunc(NameplateBuffContainerMixin, "UpdateAnchor", function(self)
	self:SetPoint("BOTTOM", self:GetParent().healthBar, "TOP", 0, 12);
	self:SetScale(0.85)
	local font, size, flags = GameFontNormalOutline:GetFont()
	for _, buff in ipairs(self.buffList) do
		buff.CountFrame.Count:SetFont(font, size, flags)
		buff.CountFrame:SetPoint("BOTTOMRIGHT", 2, -2)
	end
end)

hooksecurefunc("CompactUnitFrame_UpdateName", function(frame)
	if frame:IsForbidden() then return end
	if UnitIsPlayer(frame.unit) then
		frame.name:SetText(UnitName(frame.unit))
	end
	frame.name:SetTextColor(1, 1, 1, 1)
	local font, size, flags = GameFontNormalOutline:GetFont()
	frame.name:SetFont(font, size*UIParent:GetScale(), flags)
end)

hooksecurefunc("DefaultCompactNamePlateFrameSetupInternal", function(namePlate)
	if namePlate.styled or namePlate:IsForbidden() then return end
	namePlate.healthBar:SetStatusBarTexture(C.general.texture)
	namePlate.healthBar.background:SetTexture(C.general.texture)
	namePlate.healthBar.border:Hide()

	E:ShadowedBorder(namePlate.healthBar)

	namePlate.castBar.Flash:SetTexture(nil)
	namePlate.castBar.background:SetAlpha(0.3)
	local font, size, flags = GameFontNormalOutline:GetFont()
	namePlate.castBar.Text:SetFont(font, size*UIParent:GetScale(), flags)
	namePlate.castBar.Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	E:ShadowedBorder(namePlate.castBar)
	E:ShadowedBorder(namePlate.castBar.Icon)

	namePlate.name:SetParent(namePlate.healthBar)
	namePlate.name:SetPoint("BOTTOM", namePlate.healthBar, "TOP", 0, -3)

	local layer, sublayer = namePlate.selectionHighlight:GetDrawLayer()
	namePlate.name:SetDrawLayer(layer, sublayer+1)

	namePlate.selectionHighlight:SetAlpha(0)

	namePlate.styled = true
end)

sPlates:SetScript("OnEvent", function(self, event, ...)
	self[event](self, ...); -- call one of the functions above
end);
sPlates:RegisterEvent("NAME_PLATE_UNIT_ADDED");
