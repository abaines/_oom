


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
	local texture, itemCount, locked, quality, readable, lootable, itemLink = C_Container.GetContainerItemInfo(containerIndex, slotIndex);
	
	local inventoryObj = {
		itemId=itemId,
		count=itemCount,
		itemLink=itemLink,
	}
	
	tprint(inventoryObj)

	return inventoryObj
end





function TableOfInventory()
	print("TableOfInventory()")

	local inventoryTable = {}

	for i=1,39 do
		local itemId = GetInventoryItemID("player", i)

		if itemId then
			local itemLink = GetInventoryItemLink("player", i)
			print("inv",itemLink)
			inventoryTable["{"..i.."}"] = { itemId=itemId , count=1, itemLink=itemLink }
		end
	end

	print("NUM_BAG_SLOTS",NUM_BAG_SLOTS)
	for bagID = 0, NUM_BAG_SLOTS do
		local numberOfSlots = C_Container.GetContainerNumSlots(bagID);
		for slotID = 1, numberOfSlots do
			local itemId = C_Container.GetContainerItemID(bagID, slotID);
			if itemId then
				local inventoryObj = createInventoryObject(bagID, slotID);
				tprint(inventoryObj)
				inventoryTable["[" .. bagID .. "," .. slotID .. "]"] = inventoryObj
			end
		end
	end

	print("Bank main")
	local bagID = BANK_CONTAINER
	local numberOfSlots = C_Container.GetContainerNumSlots(bagID);
	for slotID = 1, numberOfSlots do
		local itemId = C_Container.GetContainerItemID(bagID, slotID);
		if itemId then
			local inventoryObj = createInventoryObject(bagID, slotID);
			tprint(inventoryObj)
			inventoryTable["[" .. bagID .. "," .. slotID .. "]"] = inventoryObj
		end
	end

	print("Bank containers")
	for bagID = NUM_BAG_SLOTS+1, NUM_BAG_SLOTS+NUM_BANKBAGSLOTS do
		local numberOfSlots = C_Container.GetContainerNumSlots(bagID);
		for slotID = 1, numberOfSlots do
			local itemId = C_Container.GetContainerItemID(bagID, slotID);
			if itemId then
				local inventoryObj = createInventoryObject(bagID, slotID);
				tprint(inventoryObj)
				inventoryTable["[" .. bagID .. "," .. slotID .. "]"] = inventoryObj
			end
		end
	end

	print("reagent")
	-- reagent bank slots
	local bagID = -3
	local numberOfSlots = C_Container.GetContainerNumSlots(bagID);
	for slotID = 1, numberOfSlots do
		local itemId = C_Container.GetContainerItemID(bagID, slotID);
		if itemId then
			local inventoryObj = createInventoryObject(bagID, slotID);
			tprint(inventoryObj)
			inventoryTable["[" .. bagID .. "," .. slotID .. "]"] = inventoryObj
		end
	end

	return inventoryTable
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



