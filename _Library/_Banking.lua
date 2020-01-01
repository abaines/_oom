

function TableOfContainerInfo()

	local table_bagData = {}

	for bagID = 1 , NUM_BAG_SLOTS+NUM_BANKBAGSLOTS do
		local numberOfSlots = GetContainerNumSlots(bagID);
		local invID = ContainerIDToInventoryID(bagID)
		local itemId = GetInventoryItemID("player", invID);

		if itemId then
			local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo( itemId )

			if itemName then
				--print(bagID.. "  " .. itemName .. "  "
				table_bagData[bagID] = {}
				table_bagData[bagID]["Bag Name"] = itemName
				table_bagData[bagID]["Bag Size"] = numberOfSlots
			end
		end
	end

	--tprint(table_bagData)
	return table_bagData
end


function getDecimalPlayerLevel()
	local XP = UnitXP("player")
	local XPMax = UnitXPMax("player")

	local baselevel = UnitLevel("player") ;
	local calclevel = baselevel + XP / XPMax ;

    return calclevel, baselevel
end


function TableOfGeneralCharacterInfo(table_charInfo)
    --print('TableOfGeneralCharacterInfo')
    --tprint(table_charInfo)

	table_charInfo = table_charInfo or {}

	local localizedClass, englishClass, classIndex = UnitClass("player");

	local copper = GetMoney()

	local race, raceEn = UnitRace("player");

	local calclevel, baselevel = round(getDecimalPlayerLevel(),3)

	table_charInfo["Class"] = localizedClass

	if calclevel and calclevel>0 then
		table_charInfo["Level"] = calclevel

	elseif baselevel and baselevel>0 then
		table_charInfo["Level"] = baselevel

	else
		print("calclevel:", calclevel )

	end

	if copper ~= 0 then
		local gold = copper / 10000.0
		table_charInfo["Gold"] = gold
	end

	table_charInfo["Race"] = race

	local _CurrentRealm = GetRealmName();
	local _CurrentPlayerName = UnitName("player");

	-- str = str:gsub("%s+", "")
	local fullname = _CurrentPlayerName .. "-" .. _CurrentRealm:gsub("%s+", "")
	table_charInfo["Full-Name"] = fullname
	--print("fullname = " .. fullname)

	-- guild name/rank
    table_charInfo["Guild Name"] = ""
    table_charInfo["Guild Rank"] = ""
	local guildName, guildRankName, guildRankIndex = GetGuildInfo("player");
	if guildName then
		table_charInfo["Guild Name"] = guildName
		if guildRankName then
			table_charInfo["Guild Rank"] = guildRankName
		end
	end

    maxRiding, Flight_Masters_License, Cold_Weather_Flying, Wisdom_of_the_Four_Winds = GetMountSpeed()

    table_charInfo["Riding"] = {}

    table.insert(table_charInfo["Riding"],maxRiding)
    if Flight_Masters_License then
        table.insert(table_charInfo["Riding"],Flight_Masters_License)
    end
    if Cold_Weather_Flying then
        table.insert(table_charInfo["Riding"],Cold_Weather_Flying)
    end
    if Wisdom_of_the_Four_Winds then
        table.insert(table_charInfo["Riding"],Wisdom_of_the_Four_Winds)
    end

	--tprint(table_charInfo)
	return table_charInfo
end




---------------------------------------------------------------------------------------------------
----- Experimental ----  Experimental ----  Experimental ----  Experimental ----  Experimental ----
---------------------------------------------------------------------------------------------------










-- numSlots, full = GetNumBankSlots();

function something(slotId)

	local invSlot = slotId
	local count = GetInventoryItemCount("player", slotId)
	local itemId = GetInventoryItemID("player", invSlot);
	local quality = GetInventoryItemQuality("player", slotId)

	if count and itemId and quality then
		print(count .. " # " .. itemId .. " $ " .. quality)
	end

end

-- itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemID or ...)

function scanSomething()

	for i=1,65536 do
		something(i)
	end

end







function strItemDetails(itemId,count,i)

	if not itemId then
		return
	end

	if not count or type(count)~="number" then
		count = 1
	end


	if not i then
		 i = ""
	end

	local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo( itemId )

	if not itemName then
		return
	end

	return (i .. " > " .. itemName .. " # " .. count)

end


function characterSheetDetails()

	if true then
		return false
	end

	for invSlot=1,65536 do
		local itemId = GetInventoryItemID("player", invSlot);
		local s = strItemDetails(itemId,nil,invSlot)
		if s then
			print(s)
		end
	end

	return true
end








function printBagInfos()

	for bagID = 1 , NUM_BAG_SLOTS+NUM_BANKBAGSLOTS do
		printBagInfo(bagID)
	end

end

function printBagInfo(bagID)

	local invID = ContainerIDToInventoryID(bagID)

	local bagLink = GetInventoryItemLink("player",invID)

	if not bagLink then
		return
	end

	print("Bag slot "..bagID.." is inventory slot "..invID..", a "..bagLink)
end



















function bagSizes()


	for bagID = 0, NUM_BAG_SLOTS+NUM_BANKBAGSLOTS do
		local numberOfSlots = GetContainerNumSlots(bagID);
		print(numberOfSlots)
		--scanContainer(bagID)
	end

	local numberOfSlots = GetContainerNumSlots(BANK_CONTAINER);
	print(numberOfSlots)
	--scanContainer(BANK_CONTAINER)

end











function forceful()
	for bagID = 0, NUM_BAG_SLOTS+NUM_BANKBAGSLOTS do
		for slotID = 0,40 do

			local itemId = GetContainerItemID(bagID, slotID);

			if (itemId) then

				print(bagID .. "  " .. slotID .. " > " .. itemId )

			elseif xtimer("forceful:bagID:"..bagID,1) then

				print(bagID .. "  " .. slotID .. " > empty")

			end

		end
	end
end











function printItemStats()

	for bagID = 0, NUM_BAG_SLOTS+NUM_BANKBAGSLOTS do
		local numberOfSlots = GetContainerNumSlots(bagID);

		for slotID = 0, numberOfSlots do

			local itemLink = GetContainerItemLink(bagID, slotID)

			if itemLink then

				print(itemLink)

				local stats = GetItemStats(itemLink)

				tprint(stats)

			end

		end
	end

end



--itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemID or "itemString" or "itemName" or "itemLink")

-- Disenchant search Disenchanting DE
-- Enchanting DE
function printLowLevelItems()

	local leveltable = {}

	for bagID = 0, NUM_BAG_SLOTS+NUM_BANKBAGSLOTS do
		local numberOfSlots = GetContainerNumSlots(bagID);

		for slotID = 0, numberOfSlots do

			local itemLink = GetContainerItemLink(bagID, slotID)

			if itemLink then

				local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(itemLink)

				if itemRarity==2 then

					if not leveltable[itemLevel] then
						leveltable[itemLevel] = {}
					end

					leveltable[itemLevel][itemName] = "["..bagID..","..slotID.."] " .. itemLink .. " <" .. itemLevel ..">"  ;

				end

			end

		end
	end

	local a = {}

	for n in pairs(leveltable) do
		table.insert(a, n)
	end

	--table.sort(a)
	table.sort(a, function(a,b) return a>b end)

	for i,n in pairs(a) do
		tprint(leveltable[n])
	end

	--tprint(leveltable)

end


--- /run DarkmoonStorageBox()
function DarkmoonStorageBox()
    print(ColorText(255,102,0) .."Darkmoon Storage Box:")

    for serverName,serverData in pairs(CharacterRecord) do
        for characterName,characterData in pairs(serverData) do

            local hasDarkmoonStorageBox = false

            for bagIndex,bagData in pairs(characterData['CONTAINERS']) do
                local bagName = bagData['Bag Name']

                if bagName == "Darkmoon Storage Box" then
                    hasDarkmoonStorageBox = true
                end

            end

            local fullname = characterData['GENERAL']['Full-Name']
            local level = characterData['GENERAL']['Level']
            local class = characterData['GENERAL']['Class']


            if hasDarkmoonStorageBox == false and level > 3.7 then
                print(fullname .. ColorText(1,0,0) .. " " .. round(level) .. ColorText(0,1,0) .. " " .. class)
            end

        end
    end

end



