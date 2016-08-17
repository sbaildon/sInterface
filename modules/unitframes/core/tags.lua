local _, ns = ...
local oUF = ns.oUF or oUF
local cfg = ns.cfg
local class = select(2, UnitClass('player'))

oUF.colors.power['MANA'] = {0.37, 0.6, 1}
oUF.colors.power['RAGE']  = {0.9,  0.3,  0.23}
oUF.colors.power['FOCUS']  = {1, 0.81,  0.27}
oUF.colors.power['RUNIC_POWER']  = {0, 0.81, 1}
oUF.colors.power['AMMOSLOT'] = {0.78,1, 0.78}
oUF.colors.power['FUEL'] = {0.9,  0.3,  0.23}
oUF.colors.power['POWER_TYPE_STEAM'] = {0.55, 0.57, 0.61}
oUF.colors.power['POWER_TYPE_PYRITE'] = {0.60, 0.09, 0.17}	
oUF.colors.power['POWER_TYPE_HEAT'] = {0.55,0.57,0.61}
oUF.colors.power['POWER_TYPE_OOZE'] = {0.76,1,0}
oUF.colors.power['POWER_TYPE_BLOOD_POWER'] = {0.7,0,1}

local colours = {
	dc = { 0.6, 0.69, 0.69 },
	ghost = { 0.4, 0.76, 0.93 },
	dead = { 0.76, 0.37, 0.37 },
	health = { 0.68, 0.31, 0.31}
}

local sValue = function(val)
	if (val >= 1e6) then
        return ('%.fm'):format(val / 1e6)
    elseif (val >= 1e3) then
        return ('%.fk'):format(val / 1e3)
    else
        return ('%d'):format(val)
    end
end

local function hex(r, g, b)
    if not r then return '|cffFFFFFF' end
    if(type(r) == 'table') then
        if(r.r) then r, g, b = r.r, r.g, r.b else r, g, b = unpack(r) end
    end
    return ('|cff%02x%02x%02x'):format(r * 255, g * 255, b * 255)
end

oUF.Tags.Methods['color'] = function(u, r)
    local reaction = UnitReaction(u, 'player')
    if (UnitIsTapDenied(u)) then
        return hex(oUF.colors.tapped)
    elseif UnitIsFriend("player", u) and UnitIsPlayer(u) then
        if UnitIsDead(u) then
            return hex(colours.dead)
        elseif UnitIsGhost(u) then
            return hex(colours.ghost)
        elseif not UnitIsConnected(u) then
            return hex(colours.dc)
        end
    end

    return hex(1, 1, 1)
end
oUF.Tags.Events['color'] = 'UNIT_REACTION UNIT_HEALTH'

oUF.Tags.Methods['threat'] = function(u, r)
	local s = UnitThreatSituation(u)
	if s and s > 0 then
		local r, g, b = GetThreatStatusColor(s)
		return hex(r, g, b)
	end
end
oUF.Tags.Events['threat'] = 'UNIT_THREAT_SITUATION_UPDATE'

oUF.Tags.Methods['long:name'] = function(u, r)
    local name = UnitName(realUnit or u or r)
    if string.len(name) > 18 then
	return string.sub(name, 1,  18).."..."
    else
        return name
    end
end
oUF.Tags.Events['long:name'] = 'UNIT_NAME_UPDATE UNIT_CONNECTION'

oUF.Tags.Methods['limit:name'] = function(u, r)
    local name = UnitName(realUnit or u or r)
    if name == nil then return 'non' end
    return string.sub(name, 1,  12)
end
oUF.Tags.Events['limit:name'] = 'UNIT_NAME_UPDATE UNIT_CONNECTION'

oUF.Tags.Methods['short:name'] = function(u, r)
    local name = UnitName(realUnit or u or r)
    return string.sub(name, 1,  5)
end
oUF.Tags.Events['short:name'] = 'UNIT_NAME_UPDATE UNIT_CONNECTION'

oUF.Tags.Methods['lvl'] = function(u)
    local level = UnitLevel(u)
    local typ = UnitClassification(u)
    local color = GetQuestDifficultyColor(level)
	
    if level == MAX_PLAYER_LEVEL then
       return nil
    end

    if level <= 0 then
        level = '??' 
    end

    if typ=='rareelite' then
        level = hex(color)..level..'r+'
    elseif typ=='elite' then
        level = hex(color)..level..'+'
    elseif typ=='rare' then
        level = hex(color)..level..'r'
    else
        level = hex(color)..level
    end

    return level..'|r '
end
oUF.Tags.Events['lvl'] = 'UNIT_CONNECTION'

oUF.Tags.Methods['primary:health'] = function(u)
    local min, max = UnitHealth(u), UnitHealthMax(u)
    if UnitIsDead(u) then
    	return hex(colours.health).."Dead"
    elseif UnitIsGhost(u) then
    	return hex(colours.ghost).."Ghost"
    elseif (min < max) then
        return (hex(colours.health)..sValue(min))..' | '..math.floor(min/max*100+.5)..'%'
    else
        return (hex(0.33, 0.58, 0.33)..sValue(min))
    end
end
oUF.Tags.Events['primary:health'] = 'UNIT_HEALTH UNIT_POWER UNIT_CONNECTION'

oUF.Tags.Methods['player:power'] = function(u)
    local power = UnitPower(u)
    local _, str, r, g, b = UnitPowerType(u)
    local t = oUF.colors.power[str]
    if t then
        r, g, b = t[1], t[2], t[3]
    end

    if (power > 0) then
        return hex(r, g, b)..sValue(power)
    end
end
oUF.Tags.Events['player:power'] = 'UNIT_POWER PLAYER_SPECIALIZATION_CHANGED PLAYER_TALENT_UPDATE UNIT_HEALTH UNIT_CONNECTION'

oUF.Tags.Methods['percent:health']  = function(u) 
    local min, max = UnitHealth(u), UnitHealthMax(u)
    if UnitIsDead(u) then
    	return hex(colours.health).."Dead"
    else	
        return hex(colours.health)..math.floor(min/max*100+.5)..'%'
    end
end
oUF.Tags.Events['percent:health'] = 'UNIT_HEALTH_FREQUENT UNIT_MAXHEALTH UNIT_TARGETABLE_CHANGED'

oUF.Tags.Methods['altpower'] = function(u)
	local cur = UnitPower(u, ALTERNATE_POWER_INDEX)
	local max = UnitPowerMax(u, ALTERNATE_POWER_INDEX)
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
