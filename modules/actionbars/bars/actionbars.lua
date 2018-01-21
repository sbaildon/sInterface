local _, ns = ...
local E, C = ns.E, ns.C

if not C.actionbars.enabled then return end

local NUM_ACTIONBAR_BUTTONS = NUM_ACTIONBAR_BUTTONS
local NUM_OVERRIDE_BUTTONS = NUM_OVERRIDE_BUTTONS
local BUTTON_SPACING = 6
local BUTTON_SIZE = ActionButton1:GetHeight()

local bar1 = ns.sInterfaceBars.bar1
local bar2 = ns.sInterfaceBars.bar2
local bar3 = ns.sInterfaceBars.bar3
local bar4 = ns.sInterfaceBars.bar4
local bar5 = ns.sInterfaceBars.bar5

for _, bar in next, {bar1, bar2, bar3, bar4, bar5} do
	bar:SetSize(BUTTON_SIZE*NUM_ACTIONBAR_BUTTONS, BUTTON_SIZE)
end

bar1:SetPoint(unpack(C.actionbars.bar1.position))
bar2:SetPoint(unpack(C.actionbars.bar2.position))
bar3:SetPoint(unpack(C.actionbars.bar3.position))
bar4:SetPoint(unpack(C.actionbars.bar4.position))
bar5:SetPoint(unpack(C.actionbars.bar5.position))

-- BAR 1
for i = 1, NUM_ACTIONBAR_BUTTONS do
	RegisterStateDriver(_G["ActionButton"..i], "visibility", C.actionbars.bar1.visibility or "show")
end
ActionButton1:ClearAllPoints()
ActionButton1:SetPoint("TOPLEFT", bar1, "TOPLEFT", 0, 0)
if C.actionbars.bar1.two_rows then
	ActionButton7:SetPoint("TOPLEFT", ActionButton1, "BOTTOMLEFT", 0, -BUTTON_SPACING)
	bar1:SetWidth((BUTTON_SIZE*6) + (BUTTON_SPACING*5))
	bar1:SetHeight((BUTTON_SIZE*2) + BUTTON_SPACING)
end


-- BAR 2
MultiBarBottomLeft.ignoreFramePositionManager = true
MultiBarBottomLeft:ClearAllPoints()
MultiBarBottomLeft:SetPoint("TOPLEFT", bar2, "TOPLEFT")
MultiBarBottomLeft:SetParent(bar2)
if C.actionbars.bar2.two_rows then
	MultiBarBottomLeftButton7:SetPoint("TOPLEFT", MultiBarBottomLeftButton1, "BOTTOMLEFT", 0, -BUTTON_SPACING)
	bar2:SetWidth((BUTTON_SIZE*6) + (BUTTON_SPACING*5))
	bar2:SetHeight((BUTTON_SIZE*2) + BUTTON_SPACING)
end
RegisterStateDriver(bar2, "visibility", C.actionbars.bar2.visibility or "show")


-- BAR 3
MultiBarBottomRight:ClearAllPoints()
MultiBarBottomRight:SetPoint("TOPLEFT", bar3, "TOPLEFT")
MultiBarBottomRight:SetParent(bar3)
if C.actionbars.bar3.two_rows then
	MultiBarBottomRightButton7:SetPoint("TOPLEFT", MultiBarBottomRightButton1, "BOTTOMLEFT", 0, -BUTTON_SPACING)
	bar3:SetWidth((BUTTON_SIZE*6) + (BUTTON_SPACING*5))
	bar3:SetHeight((BUTTON_SIZE*2) + BUTTON_SPACING)
end
RegisterStateDriver(bar3, "visibility", C.actionbars.bar3.visibility or "show")


-- BAR 4
MultiBarRight.ignoreFramePositionManager = true
MultiBarRight:SetSize(MultiBarBottomLeft:GetWidth(), MultiBarBottomLeft:GetHeight())
MultiBarRight:ClearAllPoints()
MultiBarRight:SetParent(bar4)
MultiBarRight:SetPoint("TOPLEFT", bar4, "TOPLEFT")

MultiBarRightButton1:ClearAllPoints()
MultiBarRightButton1:SetPoint("TOPLEFT", MultiBarRight, "TOPLEFT", 0, 0)
for i = 2, NUM_ACTIONBAR_BUTTONS do
	_G["MultiBarRightButton"..i]:SetPoint("TOPLEFT", _G["MultiBarRightButton"..i-1], "TOPRIGHT", BUTTON_SPACING, 0)
end
if C.actionbars.bar4.two_rows then
	MultiBarRightButton7:SetPoint("TOPLEFT", MultiBarRightButton1, "BOTTOMLEFT", 0, -BUTTON_SPACING)
	bar4:SetWidth((BUTTON_SIZE*6) + (BUTTON_SPACING*5))
	bar4:SetHeight((BUTTON_SIZE*2) + BUTTON_SPACING)
end
RegisterStateDriver(bar4, "visibility", C.actionbars.bar4.visibility or "show")


-- BAR 5
MultiBarLeft:SetSize(MultiBarBottomLeft:GetWidth(), MultiBarBottomLeft:GetHeight())
MultiBarLeft:ClearAllPoints()
MultiBarLeft:SetPoint("TOPLEFT", bar5, "TOPLEFT")
MultiBarLeft:SetParent(bar4)

MultiBarLeftButton1:ClearAllPoints()
MultiBarLeftButton1:SetPoint("TOPLEFT", MultiBarLeft, "TOPLEFT", 0, 0)
for i = 2, NUM_ACTIONBAR_BUTTONS do
	_G["MultiBarLeftButton"..i]:SetPoint("TOPLEFT", _G["MultiBarLeftButton"..i-1], "TOPRIGHT", BUTTON_SPACING, 0)
end
if C.actionbars.bar5.two_rows then
	MultiBarLeftButton7:SetPoint("TOPLEFT", MultiBarLeftButton1, "BOTTOMLEFT", 0, -BUTTON_SPACING)
	bar5:SetWidth((BUTTON_SIZE*6) + (BUTTON_SPACING*5))
	bar5:SetHeight((BUTTON_SIZE*2) + BUTTON_SPACING)
end
RegisterStateDriver(bar5, "visibility", C.actionbars.bar5.visibility or "show")
