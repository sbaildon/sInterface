local tick0 = 0
local tick1 = 1
local tick2 = 3
local tick3 = 10
local tick4 = 30
local tick5 = 120
local tick6 = 360

local CoolBar = CreateFrame("Frame", "CoolBar", UIParent)
CoolBar:SetFrameStrata("BACKGROUND")
CoolBar:SetHeight(12)
CoolBar:SetWidth(160)
CoolBar:SetPoint("CENTER", 0, 0)

CoolBar.bg = CoolBar:CreateTexture(nil, "ARTWORK")
CoolBar.bg:SetTexture("Interface\\AddOns\\sInterface\\media\\bar")
CoolBar.bg:SetAllPoints(CoolBar)

local shadow = CreateFrame("Frame", nil, CoolBar)
shadow:SetFrameLevel(1)
shadow:SetFrameStrata(CoolBar:GetFrameStrata())
shadow:SetPoint("TOPLEFT", CoolBar, "TOPLEFT", -3, 3)
shadow:SetPoint("BOTTOMRIGHT", CoolBar, "BOTTOMRIGHT", 3, -3)
shadow:SetBackdrop({
	edgeFile = "Interface\\AddOns\\sInterface\\media\\shadow_border",
	edgeSize = 5,
	insets = { left = 0, right = 0, top = 0, bottom = 0 }
})
shadow:SetBackdropColor(0, 0, 0, 0)
shadow:SetBackdropBorderColor(0, 0, 0, 0.7)

local segment = CoolBar:GetWidth() / 7

local function fs(frame, text, offset, just)
	local fs = frame:CreateFontString(nil, "OVERLAY")
	fs:SetFont("Fonts\\FRIZQT__.TTF", 12)
	if (text > 60) then text = (text/60).."m" end
	fs:SetText(text)
	fs:SetJustifyH(just or "CENTER")
	fs:SetPoint("LEFT", offset, 0)
end

fs(CoolBar, tick0, 3, "LEFT")
fs(CoolBar, tick1, segment)
fs(CoolBar, tick2, segment* 2)
fs(CoolBar, tick3, segment * 3)
fs(CoolBar, tick4, segment * 4)
fs(CoolBar, tick5, segment * 5)
fs(CoolBar, tick6, (segment * 6) + 3, "RIGHT")

function CoolBar:CreateCooldown(spellId)
	local _, _, icon, _ = GetSpellInfo(spellId)
	local start, dur, enabled = GetSpellCooldown(spellId)

	local f = CreateFrame("Frame", "FRAMEWORK")
	f.pos = 0
	f.spellId = spellId
	f.endTime = start + dur
	f.icon = f:CreateTexture(nil, "ARTWORK")
	f.icon:SetTexture(icon)
	f.icon:SetAllPoints(f)
	f.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	f:SetHeight(CoolBar:GetHeight())
	f:SetWidth(CoolBar:GetHeight())
	f:SetPoint("CENTER", CoolBar, "LEFT", f.pos, 0)
	f:Show()

	f.ticker = C_Timer.NewTicker(0.01, function(self)
		local ctime = GetTime()
		local remain = f.endTime - ctime
		if ctime >= f.endTime then
			f:Hide()
		end	

		local tick0 = 0
		local tick1 = 1
		local tick2 = 3
		local tick3 = 10
		local tick4 = 30
		local tick5 = 120
		local tick6 = 360

		local pos = (segment * remain) 
		print(pos)
		f:SetPoint("CENTER", CoolBar, "LEFT", pos, 0)

		if remain < tick1 then
			--f:SetPoint("CENTER", CoolBar, "LEFT", segment * remain, 0)
		elseif remain < tick2 then
			--f:SetPoint("CENTER", CoolBar, "LEFT", segment * (remain + 1) * 0.5, 0)
		elseif remain < tick3 then
			--f:SetPoint("CENTER", CoolBar, "LEFT", segment * (remain + 11) * 0.14286 , 0)
		elseif remain < tick4 then
			--f:SetPoint("CENTER", CoolBar, "LEFT", segment * (remain + 50) * 0.05, 0)
		elseif remain < tick5 then
			--f:SetPoint("CENTER", CoolBar, "LEFT", segment * (remain + 200) * 0.011111, 0)
		elseif remain < tick6 then
			--f:SetPoint("CENTER", CoolBar, "LEFT", segment * (remain + 1080) * 0.0041667, 0)
		end
	end, dur/0.01)
end

CoolBar:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
function CoolBar:UNIT_SPELLCAST_SUCCEEDED(unitId, _, _, _, spellId)
	if  not (unitId == "player") then return end
	local timer = C_Timer.NewTimer(0.1, function()
		CoolBar:CreateCooldown(spellId)
	end)
end

CoolBar:SetScript("OnEvent", function(this, event, ...)
	this[event](this, ...)
end)
