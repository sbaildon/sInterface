local _, ns = ...
local E, C = ns.E, ns.C

if not C.filter.enabled or not C.filter.filters then return end

local filterParent = CreateFrame('Frame', 'sInterfaceFilter', UIParent)

local filters = {}
local filterCount = 0  -- #filters doesn't work as expected?

local function reregisterFilterEvents()
	local spec = GetSpecialization()

	for k,v in pairs(filters) do
		if v.spec == spec then
			if v.unit == 'target' then
				v:RegisterEvent('PLAYER_TARGET_CHANGED')
			end
			v:RegisterUnitEvent('UNIT_AURA', v.unit)
			v:Show()
		else
			v:UnregisterAllEvents()
			v:Hide()
		end
	end
end

local function createFilter(filter)
	if not filter.spellId then print('Missing spellId in filter') return end

	local gsi_name, gsi_rank, gsi_icon, gsi_powerCost, gsi_isFunnel, gsi_powerType, gsi_castingTime, gsi_minRange, gsi_maxRange = GetSpellInfo(filter.spellId)
	if not gsi_name then print('No spell for id '..filter.spellId) return end

	local f = CreateFrame('Frame', 'sInterfaceFilter'..filterCount, filterParent)
	f:SetPoint(unpack(filter.pos))
	f:SetSize(filter.size, filter.size)

	local icon = f:CreateTexture(nil, 'ARTWORK')
	icon:SetTexture(gsi_icon)
	icon:SetAllPoints(f)
	icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	icon:SetDesaturated(1)

	local count = E:FontString({parent = f})
	count:SetPoint('BOTTOMRIGHT', 2, -5)

	local cooldown = CreateFrame('CoolDown', 'sInterfaceFilter'..filterCount..'Cooldown', f, 'CooldownFrameTemplate')
	cooldown:SetAllPoints()
	cooldown:SetReverse(true)

	f.icon = icon
	f.cooldown = cooldown
	f.count = count
	f.spec = filter.spec
	f.unit = filter.unit

	function f:CheckAvailability(force)
		local name, _, _, count, _, duration, expires = UnitAura(filter.unit, gsi_name, nil, filter.filter)
		if name then
			if f.expires == expires and not force then return end
			if count and count > 1 then
				f.count:SetText(count)
			end
			local gameTime = GetTime()
			f.expires = expires
			f:PlayAlpha(filter.alpha.found)
			f.icon:SetDesaturated(nil)
			f.cooldown:SetCooldown(expires - duration, duration)
		else
			f.count:SetText("")
			f:PlayAlpha(filter.alpha.not_found)
			f.icon:SetDesaturated(1)
			f.cooldown:SetCooldown(0, 0)
		end
	end

	function f:PLAYER_TARGET_CHANGED()
		if not UnitExists('target') then
			f.count:SetText("")
			f:PlayAlpha(filter.alpha.not_found)
			f.icon:SetDesaturated(1)
			f.cooldown:SetCooldown(0, 0)
		else
			f:CheckAvailability(true)
		end
	end

	function f:UNIT_AURA(unitId)
		f:CheckAvailability()
	end

	E:ShadowedBorder(f)
	E:RegisterAlphaAnimation(f)

	f:PlayAlpha(filter.alpha.not_found)

	f:SetScript('OnEvent', function(self, event, ...)
		self[event](this, ...)
	end)

	table.insert(filters, f)
	filterCount = filterCount + 1
end

E:RegisterAlphaAnimation(filterParent)
filterParent:RegisterEvent('PLAYER_REGEN_DISABLED')
filterParent:RegisterEvent('PLAYER_REGEN_ENABLED')
filterParent:RegisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
filterParent:RegisterEvent('PLAYER_LOGIN')
filterParent:SetScript('OnEvent', function(self, event, ...)
	if event == 'PLAYER_REGEN_ENABLED' then
		filterParent:PlayAlpha(C.general.oocAlpha)
	elseif event == 'PLAYER_REGEN_DISABLED' then
		filterParent:PlayReveal()
	elseif event == 'PLAYER_LOGIN' then
		filterParent:PlayAlpha(C.general.oocAlpha)

		for _,filter in pairs(C.filter.filters) do
			createFilter(filter)
		end

		reregisterFilterEvents()
	elseif event == 'ACTIVE_TALENT_GROUP_CHANGED' then
		reregisterFilterEvents()
	end
end)

