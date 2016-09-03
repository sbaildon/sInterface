local orderhall = CreateFrame('Frame', 'OrderHall')

orderhall:RegisterEvent('ZONE_CHANGED_NEW_AREA')
orderhall:RegisterEvent('PLAYER_ENTERING_WORLD')
orderhall:SetScript('OnEvent', function(self, event, ...)
	local b = OrderHallCommandBar

	if not b then return end

	b:UnregisterAllEvents()
	b:SetScript("OnShow", b.Hide)
	b:Hide()
end)
