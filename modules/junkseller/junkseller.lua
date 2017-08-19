local addon, ns = ...
local E, C = ns.E, ns.C

if not C.junkseller.enabled then return end;

local function GreySell()
	for bag=0,4 do
		for slot=0,GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag, slot)
			if link and select(3, GetItemInfo(link)) == 0 then
				UseContainerItem(bag, slot)
			end
		end
	end
end

local f = CreateFrame("Frame")
f:RegisterEvent("MERCHANT_SHOW")
f:SetScript("OnEvent", GreySell)
if MerchantFrame:IsVisible() then GreySell() end
