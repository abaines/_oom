
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

	if not xtimer("Auction_OnEvent",0.5) then
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
		data[result.unitPrice]=result.quantity
	end
	ProcessData(data)
end

function ItemSearchResultsUpdated(itemKey)
	local data = {}
	for index = 1, C_AuctionHouse.GetNumItemSearchResults(itemKey) do
		local result = C_AuctionHouse.GetItemSearchResultInfo(itemKey, index)
		local current = data[result.buyoutAmount] or 0
		data[result.buyoutAmount]=1+current
	end
	ProcessData(data)
end


function ProcessData(data)
	local sortedKeys = {}
	local total = 0
	for key, value in pairs(data) do
		table.insert(sortedKeys, key)
		total = total + value
	end
	table.sort(sortedKeys)

	for _,key in ipairs(sortedKeys) do
		print(key, data[key])
	end
	print(total)
end




function Auction_OnUpdate(...)

end
