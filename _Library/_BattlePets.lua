




function scanBattlePets(shouldPrint,shouldFilter)

	C_PetJournal.SetAllPetSourcesChecked(true) -- Enables all pet sources in the filter menu.
	C_PetJournal.SetAllPetTypesChecked(true) -- Enables all pet types in the filter menu.
	C_PetJournal.ClearSearchFilter() -- Clears the search box in the pet journal.
	
	C_PetJournal.SetFilterChecked(LE_PET_JOURNAL_FILTER_COLLECTED, true)
	C_PetJournal.SetFilterChecked(LE_PET_JOURNAL_FILTER_NOT_COLLECTED, false)
	
	
	local function setPrinter(x)
		local function noop(...)
		end
	
		if x then
			return print
		else
			return noop
		end
	end
	
	local print = setPrinter(shouldPrint)
	
	local isFilteredCol = C_PetJournal.IsFilterChecked(LE_PET_JOURNAL_FILTER_COLLECTED)
	local isFilteredNotCol = C_PetJournal.IsFilterChecked(LE_PET_JOURNAL_FILTER_NOT_COLLECTED)
	
	--print(isFilteredCol)
	--print(isFilteredNotCol)
	
	--local isFilteredFav = C_PetJournal.IsFlagFiltered(LE_PET_JOURNAL_FLAG_FAVORITES)
	--print(isFilteredFav)

	local numPets = C_PetJournal.GetNumPets() 
	print(ColorText(0.3,0.3,1) .. "Number of Battle Pets: " .. ColorText() .. numPets)
	
	local petTable = {}
	
	local count = 0
	
	for petIndex=1, numPets do
	
		local petID, speciesID, owned, customName, level, favorite, isRevoked, speciesName, icon, petType, companionID, tooltip, description, isWild, canBattle, isTradeable, isUnique, obtainable = C_PetJournal.GetPetInfoByIndex(petIndex)
		
		local canRelease = C_PetJournal.PetCanBeReleased(petID)
		
		local health, maxHealth, power, speed, rarity = C_PetJournal.GetPetStats(petID)
		
		if obtainable and isWild and canRelease then
			--print(petID .. "  " .. speciesName .. "  " .. speciesID )
			
			if not petTable[speciesName] then
				petTable[speciesName] = {}
			end
			
			local str = string.format("%d.%02d", rarity, level)
			
			table.insert(petTable[speciesName],{tonumber(str),petIndex})
		end
		
		if owned then
			count = 1 + count
		end
	
	end
	
	if count ~= numPets then
		print(ColorText(1,0.3,0.3) .. "count = " .. ColorText() .. count)
	end
	
	
	--tprint(petTable)
	
	-- print(ColorText("orange").."Pack rat!")
	
	local function weakestMember(valueTable)
	
		--tprint(valueTable)
		local minPetIndex = nil
		local minRank = 1000
		
		for key1,value1 in pairs(valueTable) do
			--print(key1)
			--tprint(value1)
			--print(value1[1])
			
			if value1[1] < minRank then
				minRank = value1[1]
				minPetIndex = value1[2]
			end
		end
		
		--print(">"..minRank)
		--print(">"..minPetID)
	
		return {minRank,minPetIndex}
	end
	
	local weakTable = {}
	
	for key,value in pairs(petTable) do
		local l = table.getn(value)
		if l >= 3 then
			-- print("  " .. key .. "  " .. l )
			
			local weak = weakestMember( value ) 
			table.insert(weakTable,weak)
			
			--tprint(weak)
		end
	end
	
	if not shouldPrint and not shouldFilter then
		return table.getn(weakTable)
	end
	
	
	-- print(ColorText("orange").."Last Data!")
	
	local function pcompare(a,b)
		--print(ColorText(.3,1,.3).."compare")
		--print(a[1])
		--print(b[1])
		return a[1] > b[1]
	end
	
	table.sort(weakTable,pcompare)
	
	--tprint(weakTable)
	
	local function colorMap(rank)
		    if rank < 2 then
			return "poor"
			
		elseif rank < 3 then
			return "common"
			
		elseif rank < 4 then
			return "uncommon"
			
		elseif rank < 5 then
			return "rare"
			
		elseif rank < 6 then
			return "epic"
			
		else -- rank > 6
			return "legendary"
			
		end
	end
	

	local lastPet = nil
	for key,value in pairs(weakTable) do
		local rank = value[1]
		local petIndex = value[2]
		
		local petID, speciesID, owned, customName, level, favorite, isRevoked, speciesName, icon, petType, companionID, tooltip, description, isWild, canBattle, isTradeable, isUnique, obtainable = C_PetJournal.GetPetInfoByIndex(petIndex)
		
		local link = C_PetJournal.GetBattlePetLink(petID)
		
		print(ColorText(colorMap(rank)) .. rank .. ColorText() .. "  " .. link)
		
		lastPet = {speciesName, petType}
	end
	
	if lastPet and shouldFilter then
		C_PetJournal.ClearAllPetTypesFilter() -- Clears all pet types in the filter menu.
		C_PetJournal.SetSearchFilter(lastPet[1]) 
		C_PetJournal.SetPetTypeFilter(lastPet[2], true) -- Sets the pet type in the filter menu.
	end
	
	return table.getn(weakTable)
end








function displayPetBattleGuide(petType)
	function trim(s)
		return s:match'^%s*(.*%S)' or ''
	end

	local function isempty(s)
		return s == nil or trim(s) == ''
	end

	local petType = string.lower(petType)
	
	local typesFound = 0
	local petList = {"aqua", "beast", "crit", "dragon", "elem", "fly", "human", "magic", "mech", "dead"}
	for i, name in ipairs(petList) do
		if strfind(petType,name) then
			typesFound = 1 + typesFound
		end
	end

	local displayAll = strfind(petType,'all') or typesFound==0
	-- "aqua","beast","crit","dragon","elem", "fly","human","magic","mech","dead"
	
	local function displayCheat(pType,strong,weak)
	
		if strfind(petType,pType) or displayAll then
			print(pType .. "  " .. ColorText(0,1,0) .. strong .. " " .. ColorText(1,0,0) .. weak)
		end
	
	end

	--[[
	if strfind(petType,"aqua") or displayAll then
	
	end
	]]--
	
	displayCheat("aqua","elem undead","magic flying")
	displayCheat("beast","crit human","flying mech")
	displayCheat("crit","undead elem","human beast")
	displayCheat("dragon","magic flying","undead human")
	displayCheat("elem","mech mech","crit aqua")
	displayCheat("fly","aqua beast","dragon magic")
	displayCheat("human","dragon crit","beast undead")
	displayCheat("magic","flying aqua","mech dragon")
	displayCheat("mech","beast magic","elem elem")
	displayCheat("dead","human dragon","aqua crit")
	

end


-- /run print( injuredBattlePets() )
function injuredBattlePets()
	function missingHealth(index)
		local petID, speciesID, owned, customName, level, favorite, isRevoked, speciesName, icon, petType, companionID, tooltip, description, isWild, canBattle, isTradeable, isUnique, obtainable = C_PetJournal.GetPetInfoByIndex(index);
		local health, maxHealth, power, speed, rarity = C_PetJournal.GetPetStats(petID);
		local loss = maxHealth - health;
		return loss;
	end

	numPets, numOwned = C_PetJournal.GetNumPets();
	
	local sum = 0;
	
	for index = 1, math.max(numPets,numOwned) do

		local status, result = pcall(missingHealth,index);
		
		if status then
			sum = result + sum;
		else
			return -1;
		end
	end
	
	return sum;
end


