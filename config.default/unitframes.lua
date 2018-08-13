local _, ns = ...
local C = ns.C

C["uf"] = {
	enabled = true,
	hidePlayerFrameOoc = true,

	-- Setting emulatePersonalResourceDisplay to true will ignore the player frame position,
	-- instead, anchoring the player frame to the Personal Resource Display
	emulatePersonalResourceDisplay = true,

	-- Spacing between icons like combo points, arcane orbs, soul shards, etc.
	classIconSpacing = 4
}

C["uf"].size = {
	primary = {
		width = 155,
		health = 12,
		power = 3,
	},
	secondary = {
		width = 135,
		health = 12,
		power = 3,
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
	Player = { 'CENTER', UIParent, 'CENTER', 0, -275 }, -- Unused if emulatePersonalResourceDisplay is set
	Target = { 'TOPLEFT', 'oUF_sInterfacePlayer', 'TOPRIGHT', 55, 130 },
	Targettarget = { 'TOPLEFT', 'oUF_sInterfaceTarget', 'TOPRIGHT', 7, 0 },
	Focus = { 'TOPLEFT', 'oUF_sInterfacePlayer', 'TOPRIGHT', 56, -100 },
	Focustarget = { 'TOPLEFT', 'oUF_sInterfaceFocus', 'TOPRIGHT', 7, 0 },
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
		fontFlag = "OUTLINE"
	},
	party = {
		enable = false,
		mode = 'aura',
		size = 18,
		num = 9,
		gap = false,
		fontFlag = "OUTLINE"
	},
	focus = {
		enable = true,
		mode = 'aura',
		size = 16,
		num = 8,
		gap = false,
		fontFlag = "OUTLINE"
	},
	tank = {
		enable = true,
		mode = 'debuff',
		size = 20,
		num = 5,
		gap = false,
		fontFlag = "OUTLINE"
	},
	boss = {
		enable = false,
		mode = 'debuff',
		size = 18,
		num = 9,
		gap = false,
		fontFlag = "OUTLINE"
	}
}
