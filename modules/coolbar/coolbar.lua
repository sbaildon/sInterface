local CoolBar = CreateFrame("Frame", "CoolBar", UIParent)

local tick0, tick1, tick2, tick3, tick4, tick5, tick6 = 0, 1, 3, 10, 30, 120, 360
local segment
local cooldowns = {}
local active = 0

local function fs(frame, text, offset, just)
	local fs = frame:CreateFontString(nil, "OVERLAY")
	fs:SetFont("Fonts\\FRIZQT__.TTF", 12)
	if (text > 60) then text = (text/60).."m" end
	fs:SetText(text)
	fs:SetJustifyH(just or "CENTER")
	fs:SetPoint("LEFT", offset, 0)
end

function CoolBar:PLAYER_LOGIN()
	CoolBar:SetFrameStrata("BACKGROUND")
	CoolBar:SetHeight(12)
	CoolBar:SetWidth(160)
	CoolBar:SetPoint("CENTER", 140, 0)

	CoolBar.bg = CoolBar:CreateTexture(nil, "ARTWORK")
	CoolBar.bg:SetTexture("Interface\\AddOns\\sInterface\\media\\bar")
	CoolBar.bg:SetVertexColor(0.2, 0.2, 0.2, 0.6)
	CoolBar.bg:SetAllPoints(CoolBar)
	CoolBar:Hide()

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
	
	segment = CoolBar:GetWidth() / 7

	fs(CoolBar, tick0, 4, "LEFT")
	fs(CoolBar, tick1, segment)
	fs(CoolBar, tick2, segment* 2)
	fs(CoolBar, tick3, segment * 3)
	fs(CoolBar, tick4, segment * 4)
	fs(CoolBar, tick5, segment * 5)
	fs(CoolBar, tick6, (segment * 6) + 6, "RIGHT")
end

function CoolBar:CreateCooldown(spellId)
	local start, dur, enabled = GetSpellCooldown(spellId)
	if (dur < 2) then return end --probably GCD

	local f

	for index, frame in pairs(cooldowns) do
		if frame.spellId == spellId then
			f = frame
			break
		end
	end

	if not f then
		local _, _, icon, _ = GetSpellInfo(spellId)
		f = CreateFrame("Frame", nil, CoolBar)
		f.spellId = spellId
		f.icon = f:CreateTexture(nil, "ARTWORK")
		f.icon:SetTexture(icon)
		f.icon:SetAllPoints(f)
		f.icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

		f.finishAnimation = f:CreateAnimationGroup()
		f.finishAnimation.scaleUp = f.finishAnimation:CreateAnimation("Scale")
		f.finishAnimation.scaleUp:SetFromScale(1, 1)
		f.finishAnimation.scaleUp:SetToScale(4, 4)
		f.finishAnimation.scaleUp:SetDuration(0.3)
		f.finishAnimation.scaleUp:SetSmoothing("OUT")
		f.finishAnimation.alphaOut = f.finishAnimation:CreateAnimation("Alpha")
		f.finishAnimation.alphaOut:SetFromAlpha(1)
		f.finishAnimation.alphaOut:SetToAlpha(0.2)
		f.finishAnimation.alphaOut:SetDuration(0.6)
		f.finishAnimation.alphaOut:SetEndDelay(20)

		f.failAnimation = f:CreateAnimationGroup()
		f.failAnimation.scaleUp = f.failAnimation:CreateAnimation("Scale")
		f.failAnimation.scaleUp:SetFromScale(1, 1)
		f.failAnimation.scaleUp:SetToScale(4, 4)
		f.failAnimation.scaleUp:SetDuration(0.3)
		f.failAnimation.scaleUp:SetSmoothing("OUT")
		f.failAnimation.scaleUp:SetEndDelay(0.1)

		f.failAnimation.alphaOut = f.failAnimation:CreateAnimation("Alpha")
		f.failAnimation.alphaOut:SetFromAlpha(1)
		f.failAnimation.alphaOut:SetToAlpha(0)
		f.failAnimation.alphaOut:SetDuration(0.2)
		f.failAnimation.alphaOut:SetOrder(2)
		f.failAnimation.scaleDown = f.failAnimation:CreateAnimation("Scale")
		f.failAnimation.scaleDown:SetFromScale(1, 1)
		f.failAnimation.scaleDown:SetToScale(0.25, 0.25)
		f.failAnimation.scaleDown:SetDuration(0.2)
		f.failAnimation.scaleDown:SetOrder(2)

		f.failAnimation.alphaIn = f.failAnimation:CreateAnimation("Alpha")
		f.failAnimation.alphaIn:SetToAlpha(1)
		f.failAnimation.alphaIn:SetDuration(0.2)
		f.failAnimation.alphaIn:SetOrder(3)

		table.insert(cooldowns, f)
	end
	f.finishAnimation:Stop()
	f.endTime = start + dur
	f:SetHeight(CoolBar:GetHeight()*1.4)
	f:SetWidth(CoolBar:GetHeight()*1.4)
	f:SetAlpha(1)
	f:Show()
	active = active + 1
	CoolBar:Show()

	f.ticker = C_Timer.NewTicker(0.01, function(self)
		local start, dur, enabled = GetSpellCooldown(f.spellId)
		if f.endTime > start + dur then
			f.endTime = start + dur
		end

		local gameTime = GetTime()
		local remain = f.endTime - gameTime
		if gameTime >= f.endTime then
			f.ticker:Cancel()
			active = active - 1
			if active == 0 then
				CoolBar:Hide()
			end
		end	

		if remain < tick1 then
			f:SetPoint("CENTER", CoolBar, "LEFT", segment * remain, 0)
			if remain < 0.3 and not f.finishAnimation:IsPlaying() then
				f.failAnimation:Stop()
				f.finishAnimation:Play()
			end
		elseif remain < tick2 then
			f:SetPoint("CENTER", CoolBar, "LEFT", ((0.5 * remain) + 0.5)*segment, 0)
		elseif remain < tick3 then
			f:SetPoint("CENTER", CoolBar, "LEFT", ((0.14285714 * remain) + 1.5714285)*segment, 0)
		elseif remain < tick4 then
			f:SetPoint("CENTER", CoolBar, "LEFT", ((0.05 * remain) + 2.5)*segment, 0)
		elseif remain < tick5 then
			f:SetPoint("CENTER", CoolBar, "LEFT", ((0.01111112 * remain) + 3.666665)*segment, 0)
		else
			f:SetPoint("CENTER", CoolBar, "LEFT", ((0.00416667 * remain) + 4.5)*segment, 0)
		end

		if (random() > .95) then
			f:SetFrameLevel(random(1,5) * 2 + 2)
		end
	end, dur/0.01)
end

function CoolBar:UNIT_SPELLCAST_SUCCEEDED(unitId, _, _, _, spellId)
	if  not (unitId == "player") then return end
	local timer = C_Timer.After(0.1, function()
		CoolBar:CreateCooldown(spellId)
	end)
end

function CoolBar:UNIT_SPELLCAST_FAILED(unitId, _, _, _, spellId)
	if  not (unitId == "player") then return end
	local f
	for index, frame in pairs(cooldowns) do
		if frame.spellId == spellId then
			f = frame
			break
		end
	end
	if not f then return end

	if not f.finishAnimation:IsPlaying() then
		f.failAnimation:Stop()
		f.failAnimation:Play()
	end
end

function CoolBar:PLAYER_REGEN_DISABLED()
	CoolBar:SetAlpha(1)
end

function CoolBar:PLAYER_REGEN_ENABLED()
	CoolBar:SetAlpha(0.7)
end

CoolBar:SetScript("OnEvent", function(this, event, ...)
	this[event](this, ...)
end)
for k, v in pairs(CoolBar) do
	if (k  == string.upper(k)) then
		CoolBar:RegisterEvent(k)
	end
end
