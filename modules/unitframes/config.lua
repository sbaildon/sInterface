local name, ns = ...
local cfg = CreateFrame('Frame')
local _, class = UnitClass('player')

-----------------------------
-- Media
-----------------------------

local mediaPath = 'Interface\\AddOns\\sInterface\\media\\'

cfg.texture = mediaPath..'bar'
cfg.symbol = mediaPath..'symbol.ttf'
cfg.raidicons = mediaPath..'raidicons'
cfg.shadow = mediaPath..'shadow_border'
cfg.font, cfg.fontsize, cfg.shadowoffsetX, cfg.shadowoffsetY, cfg.fontflag = mediaPath..'font.ttf', 11, 0, 0,  'THINOUTLINE'

-----------------------------
-- Unit Frames
-----------------------------

cfg.uf = {
	raid = true,               -- Raid
	boss = true,               -- Boss
	arena = true,              -- Arena
	party = true,              -- Party
	tank = true,               -- Maintank
	tank_target = false,        -- Maintank target
}

-- Player, Target, Focus
cfg.uf.primary = {
	width = 160,
	health = 10,
	power = 2,
	specific_power = 2,
}

cfg.uf.secondary = {
	width = 135,
	health = 10,
	power = 2,
}

--pet, targettarget, focustarget, arenatarget, partytarget, maintankta
cfg.uf.tertiary = {
	width = 56,
	health = 7,
}

-- raid
cfg.uf.raid = {
	width = 60 ,
	health = 12,
}

-----------------------------
-- Unit Frames Positions
-----------------------------

cfg.unit_positions = {
	Player = { 'CENTER', UIParent, 'CENTER', 0, -200 },
	Target = { 'TOPLEFT', 'oUF_sInterfacePlayer', 'TOPRIGHT', 56, 89 },
	Targettarget = { 'TOPLEFT', 'oUF_sInterfaceTarget', 'TOPRIGHT', 7, 0 },
	Focus = { 'TOPLEFT', 'oUF_sInterfacePlayer', 'TOPRIGHT', 56, -100 },
	Focustarget = { 'TOPLEFT', 'oUF_sInterfaceFocus', 'TOPRIGHT', 67, 4 },
	Pet = { 'TOPLEFT', 'oUF_sInterfacePlayer', 'TOPRIGHT', 5, 0 },
	Boss = { 'BOTTOMLEFT', 'oUF_sInterfaceTarget', 'TOPRIGHT', 300, 250 },
	Tank = { 'BOTTOMRIGHT', 'oUF_sInterfacePlayer', 'TOPLEFT', -350, 150 },
	Raid = { 'TOPLEFT', UIParent, 'TOPLEFT', 20, -20 },
	Party = { 'BOTTOMRIGHT', 'oUF_sInterfacePlayer', 'TOPLEFT', -350, 150 },
	Arena = { 'BOTTOMLEFT', 'oUF_sInterfaceTarget', 'TOPRIGHT', 250, 175 },
}

-----------------------------
-- Unit Frames Options
-----------------------------

cfg.AltPowerBar = {
	boss = {
		enable = true,
		pos = {'TOP', 0, 13},
		width = 265,
		height = 9,
	},
}

-----------------------------
-- Auras
-----------------------------

cfg.aura = {
	target = {
		enable = true,
		mode = 'aura',
		size = 15,
		num = 8,
		gap = false,
	},
	party = {
		enable = false,
		mode = 'aura',
		size = 18,
		num = 9,
		gap = false,
	},
	focus = {
		enable = true,
		mode = 'aura',
		size = 18,
		num = 9,
		gap = false,
	},
	tank = {
		enable = true,
		mode = 'debuff',
		size = 18,
		num = 9,
		gap = false,
	},
	boss = {
		enable = false,
		mode = 'debuff',
		size = 18,
		num = 9,
		gap = false,
	},

	disableCooldown = false,
	disableTime = true,
	font = cfg.font,
	fontsize = 12,
	fontflag = 'THINOUTLINE',
}
cfg.aura.target.spacing = ((cfg.uf.primary.width - (cfg.aura.target.size * cfg.aura.target.num)) / cfg.aura.target.num+1)

-----------------------------
-- Plugins
-----------------------------

--Experience/Reputation
cfg.exp_rep = {
	pos = {'BOTTOM', 'oUF_sInterfacePlayer', 'TOP', 0, 5},
	height = 2,
	mouseover_text = true,
	colour_standing = true --rep bar coloured by faction standing
}

-----------------------------
-- Colors
-----------------------------

cfg.Color = {
	Health = {r =  0.33,	g =  0.33, 	b =  0.33 },
	Health_bg = {r =  0.33,	g =  0.33, 	b =  0.33, a = 0.5},
	Castbar = {r =  0,	g =  0.7, 	b =  1},
	CPoints = {r =  .96,	g =  0.37, 	b =  0.34},
}

ns.cfg = cfg
