local name, ns = ...
local C = ns.C

local _, class = UnitClass('player')

local mediaPath = 'Interface\\AddOns\\sInterface\\media\\'

C["uf"] = { 
	symbol = mediaPath..'symbol.ttf',
	raidicons = mediaPath..'raidicons',
}

C["uf"].size = {
	primary = {
		width = 160,
		health = 10,
		power = 2,
		specific_power = 2,
	},
	secondary = {
		width = 135,
		health = 10,
		power = 2,
	},
	tertiary = {
		width = 56,
		health = 7,
	},
	raid = {
		width = 60,
		health = 12
	}
}

C["uf"].positions = {
	Player = { 'CENTER', UIParent, 'CENTER', 0, -275 },
	Target = { 'TOPLEFT', 'oUF_sInterfacePlayer', 'TOPRIGHT', 55, 130 },
	Targettarget = { 'TOPLEFT', 'oUF_sInterfaceTarget', 'TOPRIGHT', 7, 0 },
	Focus = { 'TOPLEFT', 'oUF_sInterfacePlayer', 'TOPRIGHT', 56, -100 },
	Focustarget = { 'TOPLEFT', 'oUF_sInterfaceFocus', 'TOPRIGHT', 67, 4 },
	Pet = { 'TOPLEFT', 'oUF_sInterfacePlayer', 'TOPRIGHT', 5, 0 },
	Boss = { 'BOTTOMLEFT', 'oUF_sInterfaceTarget', 'TOPRIGHT', 300, 250 },
	Tank = { 'BOTTOMRIGHT', 'oUF_sInterfacePlayer', 'TOPLEFT', -350, 150 },
	Raid = { 'TOPLEFT', UIParent, 'TOPLEFT', 20, -20 },
	Party = { 'BOTTOMRIGHT', 'oUF_sInterfacePlayer', 'TOPLEFT', -350, 150 },
	Arena = { 'BOTTOMLEFT', 'oUF_sInterfaceTarget', 'TOPRIGHT', 225, 150 },
}

C["uf"].aura = {
	target = {
		enable = true,
		mode = 'aura',
		size = 16,
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
}

C["uf"].Color = {
	Health = {r =  0.33,	g =  0.33, 	b =  0.33 },
	Health_bg = {r =  0.33,	g =  0.33, 	b =  0.33, a = 0.5},
	Castbar = {r =  0,	g =  0.7, 	b =  1},
	CPoints = {r =  .96,	g =  0.37, 	b =  0.34},
}
