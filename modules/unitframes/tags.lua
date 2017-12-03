local _, ns = ...
local oUF = ns.oUF or oUF
local cfg = ns.cfg
local class = select(2, UnitClass('player'))

oUF.colors.power['MANA'] = {0.37, 0.6, 1}
oUF.colors.power['RAGE']  = {0.9, 0.3, 0.23}
oUF.colors.power['FOCUS']  = {1, 0.81, 0.27}
oUF.colors.power['RUNIC_POWER']  = {0, 0.81, 1}
oUF.colors.power['AMMOSLOT'] = {0.78, 1, 0.78}
oUF.colors.power['FUEL'] = {0.9,  0.3,  0.23}
oUF.colors.power['POWER_TYPE_STEAM'] = {0.55, 0.57, 0.61}
oUF.colors.power['POWER_TYPE_PYRITE'] = {0.60, 0.09, 0.17}
oUF.colors.power['POWER_TYPE_HEAT'] = {0.55, 0.57, 0.61}
oUF.colors.power['POWER_TYPE_OOZE'] = {0.76, 1, 0}
oUF.colors.power['POWER_TYPE_BLOOD_POWER'] = {0.7, 0, 1}
oUF.colors.ghost = {0.4, 0.76, 0.93}
oUF.colors.dead = {0.76, 0.37, 0.37}
oUF.colors.health = { 0.68, 0.31, 0.31}

local sValue = function(val)
	local placeValue = ("%%.%df"):format(1)
	if (val >= 1e12) then
		return placeValue:format(val/1e12).."t"
	elseif (val >= 1e9) then
		return placeValue:format(val/1e9).."b"
	elseif (val >= 1e6) then
		return placeValue:format(val/1e6).."m"
	elseif (val >= 1e3) then
		return placeValue:format(val/1e3).."k"
	else
		return ('%d'):format(val)
	end
end

local function hex(r, g, b)
    if(type(r) == 'table') then
        if(r.r) then r, g, b = r.r, r.g, r.b else r, g, b = unpack(r) end
    end
    return ('|cff%02x%02x%02x'):format(r * 255, g * 255, b * 255)
end

local function IsPlayerEffectivelyTank()
	local assignedRole = UnitGroupRolesAssigned("player")
	if (assignedRole == "NONE") then
		local spec = GetSpecialization()
		return spec and GetSpecializationRole(spec) == "TANK"
	end

	return assignedRole == "TANK"
end

local function StatusColor(unit)
	if (UnitIsTapDenied(unit)) then
		return hex(oUF.colors.tapped)
	end

	if UnitIsPlayer(unit) then
		if UnitIsGhost(unit) then
			return hex(oUF.colors.ghost)
		elseif not UnitIsConnected(unit) then
			return hex(oUF.colors.disconnected)
		end

		if IsPlayerEffectivelyTank()
			and UnitIsFriend("player", unit)
			and not (UnitName("player") == UnitName(unit))
			and (UnitInRaid(unit) or UnitInParty(unit)) then
			local status = UnitThreatSituation(unit)
			if status and status > 0 then
				return hex(GetThreatStatusColor(status))
			end
		end
	end

	if UnitIsDead(unit) then
		return hex(oUF.colors.dead)
	end

	return hex(1, 1, 1)
end

oUF.Tags.Methods['sInterface:name'] = function(u, r)
	return StatusColor(u)..oUF.Tags.Methods['name'](u)
end
oUF.Tags.Events['sInterface:name'] = 'UNIT_CONNECTION UNIT_NAME_UPDATE UNIT_THREAT_SITUATION_UPDATE'

oUF.Tags.Methods['sInterface:shortname'] = function(u, r)
	return StatusColor(u)..string.sub(oUF.Tags.Methods['name'](u), 1, 7)
end
oUF.Tags.Events['sInterface:shortname'] = 'UNIT_NAME_UPDATE UNIT_CONNECTION'

oUF.Tags.Methods['sInterface:level'] = function(u)
	local level = UnitLevel(u)
	local difficulty = hex(GetCreatureDifficultyColor((level > 0) and level or 999))

	if level == MAX_PLAYER_LEVEL then
		return nil
	elseif level <= 0 then
		level = '??'
	end

	return difficulty..level.."|r"

end
oUF.Tags.Events['sInterface:level'] = 'UNIT_LEVEL UNIT_CONNECTION'

oUF.Tags.Methods['primary:health'] = function(u)
	if UnitIsDead(u) then
		return hex(oUF.colors.health).."Dead"
	elseif UnitIsGhost(u) then
		return hex(oUF.colors.ghost).."Ghost"
	end

	local min, max = UnitHealth(u), UnitHealthMax(u)
	if (min < max) then
		return (hex(oUF.colors.health)..sValue(min))..' | '..math.floor(min/max*100+.5)..'%'
	else
		return (hex(0.33, 0.58, 0.33)..sValue(min))
	end
end
oUF.Tags.Events['primary:health'] = 'UNIT_HEALTH_FREQUENT UNIT_POWER UNIT_CONNECTION'

oUF.Tags.Methods['sInterface:power'] = function(u)
	return oUF.Tags.Methods['powercolor'](u)..sValue(UnitPower(u))
end
oUF.Tags.Events['sInterface:power'] = 'UNIT_POWER PLAYER_SPECIALIZATION_CHANGED PLAYER_TALENT_UPDATE UNIT_CONNECTION'

oUF.Tags.Methods['percent:health']  = function(u)
	if UnitIsDead(u) then
		return hex(oUF.colors.dead).."Dead"
	end

	local min, max = UnitHealth(u), UnitHealthMax(u)
	return hex(oUF.colors.health)..math.floor(min/max*100+.5)..'%'
end
oUF.Tags.Events['percent:health'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_TARGETABLE_CHANGED'

oUF.Tags.Methods['altpower'] = function(u)
	local cur = UnitPower(u, ALTERNATE_POWER_INDEX)
	local max = UnitPowerMax(u, ALTERNATE_POWER_INDEX)
	if max == 0 then return end
	local per = math.floor(cur/max*100+.5)
	return ('|cffCDC5C2'..sValue(cur))..('|cffCDC5C2 / ')..sValue(max)
end
oUF.Tags.Events['altpower'] = 'UNIT_POWER UNIT_MAXPOWER'

oUF.Tags.Methods['LFD'] = function(u)
	local role = UnitGroupRolesAssigned(u)
	if role == 'HEALER' then
		return '|cff8AFF30H|r'
	elseif role == 'TANK' then
		return '|cff5F9BFFT|r'
	elseif role == 'DAMAGER' then
		return '|cffFF6161D|r'
	end
end
oUF.Tags.Events['LFD'] = 'PLAYER_ROLES_ASSIGNED PARTY_MEMBERS_CHANGED'
