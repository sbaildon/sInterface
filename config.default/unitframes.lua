local _, ns = ...
local C = ns.C

-- 'sizes' is created for convenience.
-- you can set values directly in the unitframe
-- configuration
local sizes = {
	primary = {
		width = 155,
		height = 12,
		power = 3,
	},
	secondary = {
		width = 135,
		height = 12,
		power = 3
	},
	tertiary = {
		width = 56,
		height = 7,
	},
	raid = {
		width = 60,
		height = 12
	}
}

C["uf"] = {
	enabled = true,
	hidePlayerFrameOoc = true,

	-- Setting emulatePersonalResourceDisplay to true will ignore the player frame position,
	-- instead, anchoring the player frame to the Personal Resource Display
	emulatePersonalResourceDisplay = true,

	-- Spacing between icons like combo points, arcane orbs, soul shards, etc.
	classIconSpacing = 4,

	player = {
		enabled = true,
		position = { "CENTER", UIParent, "CENTER", 0, -175}, -- Unused if emulatePersonalResourceDisplay is set
		size = sizes.primary,
		auras = {
			enabled = true,
			mode = "buff",
			size = 24
		},
	},

	target = {
		enabled = true,
		position = { "TOPLEFT", "oUF_sInterfacePlayer", "TOPRIGHT", 55, 130 },
		size = sizes.primary,
		auras = {
			enabled = true,
			mode = "aura",
			size = 18
		}
	},

	targettarget = {
		enabled = true,
		position = { "TOPLEFT", "oUF_sInterfaceTarget", "TOPRIGHT", 7, 0 },
		size = sizes.tertiary,
		auras = {
			enabled = false,
			mode = "aura",
			size = 16
		}
	},

	pet = {
		enabled = true,
		position = { "TOPLEFT", "oUF_sInterfacePlayer", "TOPRIGHT", 5, 0 },
		size = sizes.tertiary,
		auras = {
			enabled = false,
			mode = "aura",
			size = 16
		}
	},

	focus = {
		enabled = true,
		position = { "TOPLEFT", "oUF_sInterfacePlayer", "TOPRIGHT", 56, -100 },
		size = sizes.primary,
		auras = {
			enabled = true,
			mode = "aura",
			size = 18
		},
	},

	focustarget = {
		enabled = true,
		position = { "TOPLEFT", "oUF_sInterfaceFocus", "TOPRIGHT", 7, 0 },
		size = sizes.tertiary,
		auras = {
			enabled = false,
			mode = "aura",
			size = 16
		}
	},

	party = {
		enabled = true,
		position = { "BOTTOMRIGHT", "oUF_sInterfacePlayer", "TOPLEFT", -350, 150 },
		size = sizes.secondary,
		auras = {
			enabled = false,
			mode = "debuff",
			size = 18
		}
	},

	boss = {
		enabled = true,
		position = { "BOTTOMLEFT", "oUF_sInterfaceTarget", "TOPRIGHT", 300, 250 },
		size = sizes.secondary,
		auras = {
			enabled = false,
			mode = "debuff",
			size = 24
		}
	},

	arena = {
		enabled = true,
		position = { "BOTTOMLEFT", "oUF_sInterfaceTarget", "TOPRIGHT", 125, 125 },
		size = sizes.secondary,
		auras = {
			enabled = true,
			mode = "debuff",
			size = 30
		}
	},

	maintank = {
		enabled = true,
		position = { "BOTTOMRIGHT", "oUF_sInterfacePlayer", "TOPLEFT", -350, 150 },
		size = sizes.secondary,
		auras = {
			enabled = true,
			mode = "debuff",
			size = 30
		},
	},

	raid = {
		enabled = true,
		position = { "TOPLEFT", UIParent, "TOPLEFT", 20, -20 },
		size = {
			width = 60,
			height = 12
		}
	},

	-- buffs to track on the player unitframe
	buffs = {
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
		["Battle Trance"] = true,

		-- Arcane Mage
		["Clearcasting"] = true,
		["Rule of Threes"] = true,
		["Displacement Beacon"] = true,
		["Presence of Mind"] = true,

		-- Fire Mage
		["Heating Up"] = true,
		["Hot Streak!"] = true
	}
}
