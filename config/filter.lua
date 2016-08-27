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

C['filter'] = {}

if classIndex == 1 then -- warrior
	C['filter'].filters = {
		-- Prot Warrior
		{ spellId = 190456,	size = size,	pos = position1,	unit = 'player',	filter = 'HELPFUL',	spec = 3,	alpha = { found = 1,	not_found = 0 } }, -- ignore pain
		{ spellId = 2565,	size = size,	pos = position2,	unit = 'player',	filter = 'HELPFUL',	spec = 3,	alpha = { found = 1,	not_found = 0 } }, -- shield block
		{ spellId = 204488,	size = size,	pos = position3,	unit = 'player',	filter = 'HELPFUL',	spec = 3,	alpha = { found = 1,	not_found = 0 } }, -- ignore focused rage
		{ spellId = 6343,	size = size,	pos = position4,	unit = 'target',	filter = 'HARMFUL',	spec = 3,	alpha = { found = 1,	not_found = 0 } }, -- thunderclap
		{ spellId = 1719,	size = size,	pos = position5,	unit = 'player',	filter = 'HELPFUL',	spec = 3,	alpha = { found = 1,	not_found = 0 } }, -- battleshout
		{ spellId = 107574,	size = size,	pos = position6,	unit = 'player',	filter = 'HELPFUL',	spec = 3,	alpha = { found = 1,	not_found = 0 } }, -- avatar

		-- Arms Warrior
		{ spellId = 115804,	size = size,	pos = position1,	unit = 'target',	filter = 'HARMFUL',	spec = 1,	alpha = { found = 1,	not_found = 0 } }, -- mortal strike
		{ spellId = 60503,	size = size,	pos = position2,	unit = 'player',	filter = 'HELPFUL',	spec = 1,	alpha = { found = 1,	not_found = 0 } }, -- overpower
		{ spellId = 167105,	size = size,	pos = position3,	unit = 'target',	filter = 'HARMFUL',	spec = 1,	alpha = { found = 1,	not_found = 0 } }, -- colossus smash
		{ spellId = 204488,	size = size,	pos = position4,	unit = 'player',	filter = 'HELPFUL',	spec = 1,	alpha = { found = 1,	not_found = 0 } }, -- focused rage
		{ spellId = 845,	size = size,	pos = position5,	unit = 'player',	filter = 'HELPFUL',	spec = 1,	alpha = { found = 1,	not_found = 0 } }, -- cleave
		{ spellId = 1719,	size = size,	pos = position6,	unit = 'player',	filter = 'HELPFUL',	spec = 1,	alpha = { found = 1,	not_found = 0 } }, -- battleshout
		{ spellId = 107574,	size = size,	pos = position7,	unit = 'player',	filter = 'HELPFUL',	spec = 1,	alpha = { found = 1,	not_found = 0 } }, -- avatar
	}
end
