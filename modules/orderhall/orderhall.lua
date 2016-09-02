local orderhall = CreateFrame('Frame', 'OrderHall')

orderhall:RegisterEvent('PLAYER_ENTERING_WORLD')
orderhall:SetScript('OnEvent', function(self, event, ...)
	local b = OrderHallCommandBar
	b:UnregisterAllEvents()
	b:SetScript("OnShow", b.Hide)
	b:Hide()
end)
