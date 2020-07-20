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
	Player = { "CENTER", UIParent, "CENTER", 0, -275 }, -- Unused if emulatePersonalResourceDisplay is set
	Target = { "TOPLEFT", "oUF_sInterfacePlayer", "TOPRIGHT", 55, 130 },
	Targettarget = { "TOPLEFT", "oUF_sInterfaceTarget", "TOPRIGHT", 7, 0 },
	Focus = { "TOPLEFT", "oUF_sInterfacePlayer", "TOPRIGHT", 56, -100 },
	Focustarget = { "TOPLEFT", "oUF_sInterfaceFocus", "TOPRIGHT", 7, 0 },
	Pet = { "TOPLEFT", "oUF_sInterfacePlayer", "TOPRIGHT", 5, 0 },
	Boss = { "BOTTOMLEFT", "oUF_sInterfaceTarget", "TOPRIGHT", 300, 250 },
	Tank = { "BOTTOMRIGHT", "oUF_sInterfacePlayer", "TOPLEFT", -350, 150 },
	Raid = { "TOPLEFT", UIParent, "TOPLEFT", 20, -20 },
	Party = { "BOTTOMRIGHT", "oUF_sInterfacePlayer", "TOPLEFT", -350, 150 },
	Arena = { "BOTTOMLEFT", "oUF_sInterfaceTarget", "TOPRIGHT", 225, 150 },
}

C["uf"].aura = {
	player = {
		enable = true,
		mode = "buff",
		size = 24
	},
	target = {
		enable = true,
		mode = "aura",
		size = 18
	},
	party = {
		enable = false,
		mode = "aura",
		size = 18
	},
	focus = {
		enable = true,
		mode = "aura",
		size = 18
	},
	tank = {
		enable = true,
		mode = "debuff",
		size = 30
	},
	boss = {
		enable = false,
		mode = "debuff",
		size = 24
	}
}

C["uf"].buffs = {
	-- Unholy DK
	["Sudden Doom"] = true,
	["Dark Succor"] = true,

	-- Arms Warrior
	["Victorious"] = true,
	["Sharpen Blade"] = true,
	["Crushing Assault"] = true,

	-- Fury Warrior
	["Enraged Regeneration"] = true,
	["Whirlwind"] = true,
	["Barbarian"] = true,
}
