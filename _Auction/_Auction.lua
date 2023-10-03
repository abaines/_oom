
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

	if total<=0 then
		return
	end

	DisplayAllData(data,sortedKeys)

	print(ColorText(0,1,0.5)..total..ColorText())

	DisplayPercentile(data,sortedKeys,total,0.01)
	DisplayPercentile(data,sortedKeys,total,0.05)
	DisplayPercentile(data,sortedKeys,total,0.10)
	DisplayPercentile(data,sortedKeys,total,0.50)
end

function TextMoney(value)
	local gold = math.floor(value/(100*100))
	local silver = math.floor(value/(100)%100)

	local text = ColorText(1,1,0.5)..string.format("%02d",gold).."  " .. ColorText(1,1,1)..string.format("%02d",silver)..ColorText()
	return text
end

function DisplayAllData(data,sortedKeys)
	for _,key in ipairs(sortedKeys) do
		local count = data[key]
		print(TextMoney(key).."  "..ColorText(0.5,0.5,1)..count)
	end
end

function DisplayPercentile(data,sortedKeys,total,percentile)
	local p, desired = Percentile(data,sortedKeys,total,percentile)

	--print(desired)
	print(ColorText(1,0,0)..string.format("%02d",percentile*100).."% Percentile " ..TextMoney(p))
end


function Percentile(data,sortedKeys,total,percentile)
	local desired = math.floor(total*percentile)

	local lastKey = nil
	local running = 0
	for _,key in ipairs(sortedKeys) do

		local count = data[key]

		running = running + count

		if running>desired then
			return key, desired
		end
		lastKey = key
	end

	return lastKey, desired
end


function Auction_OnUpdate(...)

end
