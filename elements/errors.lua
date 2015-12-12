local _, addon = ...

local functionality_enabled = true;

local toBlock = {
	errors = true,
	information = false,
	system = false,
	combat = false,
}

local map = {
	SYSMSG = "system",
	UI_INFO_MESSAGE = "information",
	UI_ERROR_MESSAGE = "errors",
}

local originalOnEvent = UIErrorsFrame:GetScript("OnEvent")
UIErrorsFrame:SetScript("OnEvent", function(self, event, message, r, g, b, ...)
	if not toBlock[map[event]] or not functionality_enabled then
		return originalOnEvent(self, event, message, r, g, b, ...)
	end
end)

local toggle_enabled = function()
	functionality_enabled = not functionality_enabled
end

SlashCmdList["TOGGLE"] = function() toggle_enabled() print("Errors shown: "..tostring(!functionality_enabled)) end
SLASH_TOGGLE1 = "/errors"
