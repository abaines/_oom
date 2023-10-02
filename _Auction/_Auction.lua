
function Auction_OnLoad(...)
	local t_Auction_OnLoad = time()

	AuctionFrame:RegisterEvent("AUCTION_HOUSE_NEW_RESULTS_RECEIVED");
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

	if event=="COMMODITY_SEARCH_RESULTS_UPDATED" or event=="ITEM_SEARCH_RESULTS_UPDATED" then
		SearchResultsUpdated(event,arg1)
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

function GetSearchResultsUpdatedNumber(event,itemID)
	if event=="COMMODITY_SEARCH_RESULTS_UPDATED" then
		return C_AuctionHouse.GetNumCommoditySearchResults(itemID)
	elseif event=="ITEM_SEARCH_RESULTS_UPDATED" then
		return C_AuctionHouse.GetNumItemSearchResults(itemID)
	else
		error("unexpected event type")
	end
end

function GetEventShort(event)
	local b,f = string.find(event,"_")
	local s = string.sub(event,0,f-1)
	return string.sub(event,0,4)
end

function SearchResultsUpdated(event,itemID)
	local num = GetSearchResultsUpdatedNumber(event,itemID)
	local eventType = GetEventShort(event)

	print("!! ".. num.."  "..eventType)

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
