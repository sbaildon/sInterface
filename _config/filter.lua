local _, ns = ...
local C = ns.C

local anchorFrame = 'oUF_sInterfaceTarget'
local size = 30
local spacing = (C.uf.size.primary.width - (4*size)) / 3
local yOffset = -50

local position1 = {'TOPLEFT', anchorFrame, 'BOTTOMLEFT', 0, yOffset}
local position2 = {'TOPLEFT', anchorFrame, 'BOTTOMLEFT', spacing + size, yOffset}
local position3 = {'TOPLEFT', anchorFrame, 'BOTTOMLEFT', (size + spacing)*2, yOffset}
local position4 = {'TOPLEFT', anchorFrame, 'BOTTOMLEFT', (size + spacing)*3, yOffset}
local position5 = {'TOPLEFT', anchorFrame, 'BOTTOMLEFT', (size+spacing)/2, yOffset*2}
local position6 = {'TOPLEFT', anchorFrame, 'BOTTOMLEFT', (size+spacing)/2 + (spacing+size), yOffset*2}
local position7 = {'TOPLEFT', anchorFrame, 'BOTTOMLEFT', (size+spacing)/2 + (spacing+size)*2, yOffset*2}

local _, _, classIndex = UnitClass('player')

C['filter'] = {
	enabled = true
}

if classIndex == 1 then -- Warrior
	C['filter'].filters = {
		-- Protection
		{ spellId = 190456,	size = size,	pos = position1,	unit = 'player',	filter = 'HELPFUL',	spec = 3,	alpha = { found = 1,	not_found = 0 } }, -- ignore pain
		{ spellId = 2565,	size = size,	pos = position2,	unit = 'player',	filter = 'HELPFUL',	spec = 3,	alpha = { found = 1,	not_found = 0 } }, -- shield block
		{ spellId = 5302,	size = size,	pos = position3,	unit = 'player',	filter = 'HELPFUL',	spec = 3,	alpha = { found = 1,	not_found = 0 } }, -- revenge!
		{ spellId = 238149,	size = size,	pos = position4,	unit = 'target',	filter = 'HARMFUL',	spec = 3,	alpha = { found = 1,	not_found = 0 } }, -- neltharian's thunder
		{ spellId = 1719,	size = size,	pos = position5,	unit = 'player',	filter = 'HELPFUL',	spec = 3,	alpha = { found = 1,	not_found = 0 } }, -- battleshout
		{ spellId = 107574,	size = size,	pos = position6,	unit = 'player',	filter = 'HELPFUL',	spec = 3,	alpha = { found = 1,	not_found = 0 } }, -- avatar
		{ spellId = 203576,	size = size,	pos = position7,	unit = 'player',	filter = 'HELPFUL',	spec = 3,	alpha = { found = 1,	not_found = 0 } }, -- dragon scales

		-- Arms
		{ spellId = 167105,	size = size,	pos = position1,	unit = 'target',	filter = 'HARMFUL',	spec = 1,	alpha = { found = 1,	not_found = 0 }, caster = 'player' }, -- colossus smash
		{ spellId = 772,	size = size,	pos = position2,	unit = 'target',	filter = 'HARMFUL',	spec = 1,	alpha = { found = 1,	not_found = 0 }, caster = 'player' }, -- rend
		{ spellId = 115804,	size = size,	pos = position3,	unit = 'target',	filter = 'HARMFUL',	spec = 1,	alpha = { found = 1,	not_found = 0 } }, -- mortal strike
		{ spellId = 225947,	size = size,	pos = position4,	unit = 'player',	filter = 'HELPFUL',	spec = 1,	alpha = { found = 1,	not_found = 0 } }, -- focused rage
		{ spellId = 1719,	size = size,	pos = position5,	unit = 'player',	filter = 'HELPFUL',	spec = 1,	alpha = { found = 1,	not_found = 0 } }, -- battleshout
		--{ spellId = 1715,	size = size,	pos = position6,	unit = 'target',	filter = 'HARMFUL',	spec = 1,	alpha = { found = 1,	not_found = 0 } }, -- hamstring
		{ spellId = 238147,	size = size,	pos = position6,	unit = 'target',	filter = 'HARMFUL',	spec = 1,	alpha = { found = 1,	not_found = 0 } }, -- executioner's precision
		{ spellId = 248625,	size = size,	pos = position7,	unit = 'player',	filter = 'HELPFUL',	spec = 1,	alpha = { found = 1,	not_found = 0 } }, -- shattered defenses

		-- Fury
		{ spellId = 184362,	size = size,	pos = position1,	unit = 'player',	filter = 'HELPFUL',	spec = 2,	alpha = { found = 1,	not_found = 0 } }, -- enrage
		{ spellId = 215571,	size = size,	pos = position2,	unit = 'player',	filter = 'HELPFUL',	spec = 2,	alpha = { found = 1,	not_found = 0 } }, -- frothing berserker
		{ spellId = 200872,	size = size,	pos = position3,	unit = 'player',	filter = 'HELPFUL',	spec = 2,	alpha = { found = 1,	not_found = 0 } }, -- odyn's champion
		{ spellId = 1719,	size = size,	pos = position5,	unit = 'player',	filter = 'HELPFUL',	spec = 2,	alpha = { found = 1,	not_found = 0 } }, -- battleshout
		{ spellId = 206333,	size = size,	pos = position7,	unit = 'player',	filter = 'HELPFUL',	spec = 2,	alpha = { found = 1,	not_found = 0 } }, -- taste for blood
	}
end

if classIndex == 2 then -- Paladin
	C["filter"].filters = {}
end

if classIndex == 3 then -- Hunter 
	C["filter"].filters = {}
end
if classIndex == 4 then -- Rogue
	C["filter"].filters = {}
end

if classIndex == 5 then -- Priest
	C["filter"].filters = {}
end

if classIndex == 6 then -- DeathKnight
	C["filter"].filters = {}
end

if classIndex == 7 then -- Shaman
	C["filter"].filters = {}
end

if classIndex == 8 then -- Mage
	C["filter"].filters = {
		-- Arcane
		{ spellId = 79683,	size = size,	pos = position1,	unit = 'player',	filter = 'HELPFUL',	spec = 1,	alpha = { found = 1,	not_found = 0 } }, -- arcane missiles

		-- Fire
		{ spellId = 48107,	size = size,	pos = position1,	unit = 'player',	filter = 'HELPFUL',	spec = 2,	alpha = { found = 1,	not_found = 0 } }, -- heating up
		{ spellId = 48108,	size = size,	pos = position1,	unit = 'player',	filter = 'HELPFUL',	spec = 2,	alpha = { found = 1,	not_found = 0 } }, -- hotstreak
	}
end

if classIndex == 9 then -- Warlock
	C["filter"].filters = {}
end

if classIndex == 10 then -- Monk
	C["filter"].filters = {}
end

if classIndex == 11 then -- Druid
	C["filter"].filters = {}
end

if classIndex == 12 then -- Demon Hunter
	C["filter"].filters = {}
end
