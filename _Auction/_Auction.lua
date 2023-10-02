
function Auction_OnLoad(...)
	local t_Auction_OnLoad = time()

	-- AuctionFrame:RegisterEvent("AUCTION_HOUSE_NEW_RESULTS_RECEIVED");
	AuctionFrame:RegisterEvent("COMMODITY_SEARCH_RESULTS_UPDATED");
	AuctionFrame:RegisterEvent("ITEM_SEARCH_RESULTS_UPDATED");

	print("Auction_OnLoad()")
end


function Auction_OnEvent(self,event,...)
	local arg1 = select(1,...)
	local arg2 = select(2,...)
	local arg3 = select(3,...)
	local arg4 = select(4,...)
	local arg5 = select(5,...)
	local arg6 = select(6,...)
	local arg7 = select(7,...)
	local arg8 = select(8,...)
	local arg9 = select(9,...)

	if not xtimer("Auction_OnEvent",1) then
		return
	end

	if event=="COMMODITY_SEARCH_RESULTS_UPDATED" then
		CommoditySearchResultsUpdated(arg1)
	elseif event=="ITEM_SEARCH_RESULTS_UPDATED" then
		ItemSearchResultsUpdated(arg1)
	else
		print(event)
		tprint(arg1)
		printif(arg2)
		printif(arg3)
		printif(arg4)
		printif(arg5)
		printif(arg6)
	end
end

function CommoditySearchResultsUpdated(itemID)
	local data = {}
	for index = 1, C_AuctionHouse.GetNumCommoditySearchResults(itemID) do
		local result = C_AuctionHouse.GetCommoditySearchResultInfo(itemID, index)
		ProcessData(data, result.unitPrice, result.quantity)
	end
end

function ItemSearchResultsUpdated(itemKey)
	local data = {}
	for index = 1, C_AuctionHouse.GetNumItemSearchResults(itemKey) do
		local result = C_AuctionHouse.GetItemSearchResultInfo(itemKey, index)
		ProcessData(data, result.buyoutAmount)
	end
end


function ProcessData(data,unitPrice,quantity)
	quantity = quantity or 1
	print(unitPrice,quantity)
end


--[[
function C_AuctionHouse_GetNumSearchResults(event,itemID)
	if event=="COMMODITY_SEARCH_RESULTS_UPDATED" then
		return C_AuctionHouse.GetNumCommoditySearchResults(itemID)

	elseif event=="ITEM_SEARCH_RESULTS_UPDATED" then
		return C_AuctionHouse.GetNumItemSearchResults(itemID)

	else
		error("unexpected event type")
	end
end

function C_AuctionHouse_GetSearchResultInfo(event,itemIDKey, index)
	if event=="COMMODITY_SEARCH_RESULTS_UPDATED" then
		local result = C_AuctionHouse.GetCommoditySearchResultInfo(itemIDKey, index)
		return result.quantity, result.unitPrice

	elseif event=="ITEM_SEARCH_RESULTS_UPDATED" then
		local result = C_AuctionHouse.GetItemSearchResultInfo(itemIDKey, i)
		return 1, result.buyoutAmount

	else
		error("unexpected event type")
	end
end


function GetEventShort(event)
	local b,f = string.find(event,"_")
	local s = string.sub(event,0,f-1)
	return string.sub(event,0,4)
end

function SearchResultsUpdated(event,itemIDKey)
	local num = C_AuctionHouse_GetNumSearchResults(event,itemIDKey)
	local eventType = GetEventShort(event)

	print("!! ".. num.."  "..eventType)

	for index = 1, num do
		local result = C_AuctionHouse_GetSearchResultInfo(event,itemIDKey,index)
	end

end


function ProcessCommodity(itemID)
	print(itemID)
	local num = C_AuctionHouse.GetNumCommoditySearchResults(itemID)
	print(num)
	for i = 1, C_AuctionHouse.GetNumCommoditySearchResults(itemID) do
		local result = C_AuctionHouse.GetCommoditySearchResultInfo(itemID, i)
		print(event, itemID, i, result.quantity, result.auctionID, result.unitPrice)
	end
end

function ProcessItem(
]]--



function Auction_OnUpdate(...)

end
