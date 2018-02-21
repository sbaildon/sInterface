local addon, ns = ...
local E, C = ns.E, ns.C

local function skinInstance(instance)
	if not instance or not instance:IsEnabled() then return end

	instance:LockInstance(false)

	instance:HideMainIcon(true)
	instance:HideStatusBar()
	instance:SetAutoHideMenu(true)
	instance:AttributeMenu(true, -20, 6, nil, C.general.fontSize, {1, 0.75, 0, 1}, 1, true)

	instance:ToolbarSide(1)
	instance:ToolbarMenuSetButtons(true, true, true, true, true, true)
	instance:ToolbarMenuSetButtonsOptions(4, true)

	instance:SetBarSettings(C.skins.details.barHeight, nil, true, nil, nil, false, {0, 0, 0, 0}, 1, nil, true, C.skins.details.barSpacing, string.sub(C.general.texture, 11))
	instance:SetBarBackdropSettings(true, 0, {1, 1, 1, 0}, nil)
	instance:SetBarTextSettings(C.general.bodyFont.size, nil, {1, 1, 1}, nil, nil, nil, nil, nil, nil, 1, false)
	instance:SetBarFollowPlayer(true)
	instance:SetBarGrowDirection(1)

	instance:SetBackdropTexture(nil)
	instance:InstanceColor(0, 0, 0, 0, false, true)
	instance.bg_alpha = 0

	instance:LockInstance(true)

	E:ShadowedBorder(instance.baseframe)
end

local function resizeInstance(instance)
	if not instance or not instance:IsEnabled() then return end

	local numGroupMembers = GetNumGroupMembers()
	local barsToDisplay
	if (numGroupMembers >= C.skins.details.barsToDisplayMax) then
		barsToDisplay = C.skins.details.barsToDisplayMax
	elseif (numGroupMembers > 0) then
		barsToDisplay = numGroupMembers
	else
		barsToDisplay = 1
	end

	local pos = instance:CreatePositionTable()
	pos.w = C.skins.details.width
	pos.h = (C.skins.details.barHeight*(barsToDisplay)) + (C.skins.details.barSpacing*(barsToDisplay))
	pos.scale = 1
	pos.point = C.skins.details.point
	pos.x = -C.general.edgeSpacing
	pos.y = C.general.edgeSpacing

	instance:RestorePositionFromPositionTable(pos)
end

local function skin()
	Details:SelectNumericalSystem(1)
	Details:SetUseAnimations(true)
	Details:SetWindowUpdateSpeed(0.05)

	--[[
		Overwrite a func that moves instance 1
		to the details welcome screen after 12 seconds
		Why this func exists I don't know
	]]
	Details.WelcomeSetLoc = function() end

	local function postCreateInstance(instance)
		skinInstance(instance)
	end

	local oldCreateInstance = Details.CriarInstancia
	Details.CriarInstancia = function(...)
		return postCreateInstance(oldCreateInstance(...))
	end


	local function postSetFontFace(fontString, fontFace, ...)
		fontString:SetFont(C.general.bodyFont.typeface, C.general.bodyFont.size, C.general.bodyFont.flag)
		return ...
	end

	local oldSetFontFace = Details.SetFontFace
	Details.SetFontFace = function(...)
		local _, fontString, fontFace = ...
		return postSetFontFace(fontString, fontFace, oldSetFontFace(...))
	end

	local function postInstanceRefreshRows(...)
		local instance = ...
		if not instance.barras then return end
		for _, row in ipairs (instance.barras) do
			row.texto_esquerdo:SetPoint("LEFT", row.statusbar, "LEFT", 3, 0)
			row.texto_direita:SetPoint("RIGHT", row.statusbar, "RIGHT", -2, 0)
		end
	end

	local oldInstanceRefreshRows = Details.InstanceRefreshRows
	Details.InstanceRefreshRows = function(...)
		return postInstanceRefreshRows(..., oldInstanceRefreshRows(...))
	end

	for _, instance in Details:ListInstances() do
		skinInstance(instance)
	end
end

local sInterfaceDetailsSkin = CreateFrame("frame", addon.."DetailsSkin")
sInterfaceDetailsSkin:RegisterEvent("GROUP_ROSTER_UPDATE")
sInterfaceDetailsSkin:RegisterEvent("PLAYER_ENTERING_WORLD")

if IsAddOnLoaded("Details") then
	skin()
else
	sInterfaceDetailsSkin:RegisterEvent('ADDON_LOADED')
end

sInterfaceDetailsSkin:SetScript("OnEvent", function(self, event, ...)
	if  event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_ENTERING_WORLD" then
		resizeInstance(Details:GetInstance(1))
	elseif event == "ADDON_LOADED" then
		local addonname = ...
		if (addonname == "Details") then
			skin()
		end
	end
end)
