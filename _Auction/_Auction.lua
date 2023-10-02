
function Auction_OnLoad(...)
	t_Auction_OnLoad = time()

	AuctionFrame:RegisterEvent("AUCTION_HOUSE_NEW_RESULTS_RECEIVED");
	AuctionFrame:RegisterEvent("COMMODITY_SEARCH_RESULTS_UPDATED");
	AuctionFrame:RegisterEvent("ITEM_SEARCH_RESULTS_UPDATED");

	print("Auction_OnLoad()")
end


function Auction_OnEvent(self,event,...)
	arg1 = select(1,...)
	arg2 = select(2,...)
	arg3 = select(3,...)
	arg4 = select(4,...)
	arg5 = select(5,...)
	arg6 = select(6,...)
	arg7 = select(7,...)
	arg8 = select(8,...)
	arg9 = select(9,...)

	print(event)
	tprint(arg1)
	printif(arg2)
	printif(arg3)
	printif(arg4)
	printif(arg5)
	printif(arg6)

	if event=="COMMODITY_SEARCH_RESULTS_UPDATED" or event=="ITEM_SEARCH_RESULTS_UPDATED" then
		SearchResultsUpdated(event,arg1)
	end

--[[
	local itemID = arg1

	print(itemID)
	local num = C_AuctionHouse.GetNumCommoditySearchResults(itemID)
	print(num)
	for i = 1, C_AuctionHouse.GetNumCommoditySearchResults(itemID) do
		local result = C_AuctionHouse.GetCommoditySearchResultInfo(itemID, i)
		print(event, itemID, i, result.quantity, result.auctionID, result.unitPrice)
	end
]]--
end

function GetSearchResultsUpdatedNumber(event,itemID)
	if event=="COMMODITY_SEARCH_RESULTS_UPDATED" then
		return C_AuctionHouse.GetNumCommoditySearchResults(itemID)
	elseif event=="ITEM_SEARCH_RESULTS_UPDATED" then
		return C_AuctionHouse.GetNumItemSearchResults(itemID)
	else
		error("unexpected event type")
	end
end

function SearchResultsUpdated(event,itemID)
	local num = GetSearchResultsUpdatedNumber(event,itemID)
	print("!! ".. num)

end

function Commodity(itemID)
	print(itemID)
	local num = C_AuctionHouse.GetNumCommoditySearchResults(itemID)
	print(num)
	for i = 1, C_AuctionHouse.GetNumCommoditySearchResults(itemID) do
		local result = C_AuctionHouse.GetCommoditySearchResultInfo(itemID, i)
		print(event, itemID, i, result.quantity, result.auctionID, result.unitPrice)
	end
end




function Auction_OnUpdate(...)

end
