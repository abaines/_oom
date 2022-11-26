


---------------------------------------------------------------------------------------------------
------ Bank Inventory Containers --- Bank Inventory Containers --- Bank Inventory Containers ------
---------------------------------------------------------------------------------------------------

function scanContainers()

	-- numberOfSlots = C_Container.GetContainerNumSlots(bagID);

	for bagID = 0, NUM_BAG_SLOTS do
		scanContainer(bagID)
	end

	--numberOfSlots = C_Container.GetContainerNumSlots(BANK_CONTAINER);
	--print(numberOfSlots)
	scanContainer(BANK_CONTAINER)

	for bagID = NUM_BAG_SLOTS+1, NUM_BAG_SLOTS+NUM_BANKBAGSLOTS do
		--numberOfSlots = C_Container.GetContainerNumSlots(bagID);
		--print(numberOfSlots)
		scanContainer(bagID)
	end
end


function scanItems()
	for i=1,65536 do
		--itemId = GetInventoryItemID("unit", invSlot);
		local itemId = GetInventoryItemID("player", i)

		processItemId(itemId,"{"..i.."}")
	end
end


function scanContainer(bagID)
	local numberOfSlots = C_Container.GetContainerNumSlots(bagID);
	--print(numberOfSlots)

	for slotID = 1, numberOfSlots do
		local itemId = C_Container.GetContainerItemID(bagID, slotID);

		processItemId(itemId, "[" .. bagID .. "," .. slotID .. "]")
	end
end



function processItemId(itemId,msg)
	if itemId then
		local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemId)

		if itemRarity==1 or itemRarity==2 or itemRarity==3 or itemRarity==4 then
			-- ignore
		elseif itemRarity==0 then
			print(msg .. "  " .. itemName .. "   <" .. itemRarity .. ">")
		else
			print(ColorText(255,0,0) .. msg .. "  " .. itemName .. "   <" .. itemRarity .. ">" .. ColorText())
		end
	end

end




function createInventoryObject(containerIndex, slotIndex)
	-- iconFileID,stackCount,isLocked,quality,isReadable,hasLoot,hyperlink,isFiltered,hasNoValue,itemID,isBound
	-- texture,itemCount,locked,quality,readable,lootable,itemLink
	local itemInfo = C_Container.GetContainerItemInfo(containerIndex, slotIndex);

	local inventoryObj = {
		itemId=itemInfo.itemID,
		count=itemInfo.stackCount,
		itemLink=itemInfo.hyperlink,
		isBound=itemInfo.isBound,
	}

	return inventoryObj
end





function TableOfInventory()

	local inventoryTable = {}

	-- character equipped gear
	for i=1,39 do
		local itemId = GetInventoryItemID("player", i)

		if itemId then
			local itemLink = GetInventoryItemLink("player", i)
			inventoryTable["{"..i.."}"] = { itemId=itemId , count=1, itemLink=itemLink }
		end
	end

	-- character inventory
	for bagID = 0, NUM_BAG_SLOTS do
		local numberOfSlots = C_Container.GetContainerNumSlots(bagID);
		for slotID = 1, numberOfSlots do
			local itemId = C_Container.GetContainerItemID(bagID, slotID);
			if itemId then
				local inventoryObj = createInventoryObject(bagID, slotID);
				inventoryTable["[" .. bagID .. "," .. slotID .. "]"] = inventoryObj
			end
		end
	end

	-- bank main slots
	local bagID = BANK_CONTAINER
	local numberOfSlots = C_Container.GetContainerNumSlots(bagID);
	for slotID = 1, numberOfSlots do
		local itemId = C_Container.GetContainerItemID(bagID, slotID);
		if itemId then
			local inventoryObj = createInventoryObject(bagID, slotID);
			inventoryTable["[" .. bagID .. "," .. slotID .. "]"] = inventoryObj
		end
	end

	-- bank containers
	for bagID = NUM_BAG_SLOTS+1, NUM_BAG_SLOTS+NUM_BANKBAGSLOTS do
		local numberOfSlots = C_Container.GetContainerNumSlots(bagID);
		for slotID = 1, numberOfSlots do
			local itemId = C_Container.GetContainerItemID(bagID, slotID);
			if itemId then
				local inventoryObj = createInventoryObject(bagID, slotID);
				inventoryTable["[" .. bagID .. "," .. slotID .. "]"] = inventoryObj
			end
		end
	end

	-- bank reagent slots
	local bagID = -3
	local numberOfSlots = C_Container.GetContainerNumSlots(bagID);
	for slotID = 1, numberOfSlots do
		local itemId = C_Container.GetContainerItemID(bagID, slotID);
		if itemId then
			local inventoryObj = createInventoryObject(bagID, slotID);
			inventoryTable["[" .. bagID .. "," .. slotID .. "]"] = inventoryObj
		end
	end

	return inventoryTable
end


function string:startswith(start)
	return self:sub(1, #start) == start
end


-- /run searchUnboundItems()
function searchUnboundItems()
	print("searchUnboundItems()")

	local toi = TableOfInventory()

	local output = {}

	for k,v in pairs(toi) do
		if not k:startswith("[-3,") then
			local isBound = v['isBound']
			if isBound==false then
				local hyperlink = v['itemLink']
				table.insert(output,{k,hyperlink,isBound})
			end
		end
	end

	table.sort(output, function (i1, i2) return i1[1] < i2[1] end)

	for k,v in pairs(output) do
		print(v[1],v[2],v[3])
	end
end



function parseTableForHeirlooms()

	local toInventory = TableOfInventory()

	local heirTable = {}

	local count = 0

	--tprint(toInventory)

	for k in pairs(toInventory) do
		local data = toInventory[k]
		--tprint(data)
		local itemId = data.itemId
		local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemId)

		if itemRarity==0 or itemRarity==1 or itemRarity==2 or itemRarity==3 or itemRarity==4 then
			-- ignore

		else
			--print( k .. "  " .. itemLink .. "   <" .. itemRarity .. ">" )
			count = count + 1
			heirTable[k] = itemName

		end
	end

	--print("Heirlooms found: " .. ColorText(255,0,0) .. count .. ColorText())

	return heirTable, count

end





function listGear()

	print(ColorText(255,102,0).."Listing Gear by Level:")

	local gearTable = {}

	for i=0,18 do

		if i ~= 4 then -- skip shirt
			local iitemLink = GetInventoryItemLink("player", i)

			if iitemLink then
				local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(iitemLink)

				table.insert(gearTable,{itemLink,itemLevel + itemRarity/10 , itemLevel})
			end
		end

	end


	local function compare(a,b)
		return a[2] > b[2]
	end

	table.sort(gearTable,compare)


	--tprint(gearTable)


	for key,value in pairs(gearTable) do

		print("  " .. value[3] .. "  " .. value[1])

	end

	ScrollToBottom()

end


listgear = listGear



