
-- Initialize the variables
local _CurrentRealm = GetRealmName();
local _CurrentPlayerName = UnitName("player");

--[[
CharRecords = {};
CharRecords[Server] = {};
CharRecords[Server][CurrentPlayerName] = {};


Inventory = {};
Inventory[Server] = {};
Inventory[Server][CurrentPlayerName] = {};
]]--

function Banker_OnLoad()

	BankerFrame:RegisterEvent("BANKFRAME_CLOSED");
	BankerFrame:RegisterEvent("BANKFRAME_OPENED");

	BankerFrame:RegisterEvent("PLAYER_LOGOUT");

	BankerFrame:RegisterEvent("MAIL_CLOSED");
	BankerFrame:RegisterEvent("MAIL_SHOW");
    
    --- look for other guildies searching for items
    BankerFrame:RegisterEvent("CHAT_MSG_ADDON");
    --RegisterAddonMessagePrefix('_BankerSearch')
	 BankerFrame:RegisterEvent("CHAT_MSG_ADDON_LOGGED");
	
	if not Inventory then
		Inventory = {}
	end
	initTable(Inventory,_CurrentRealm,_CurrentPlayerName,"Inventory")
	initTable(Inventory,_CurrentRealm,_CurrentPlayerName,"Time")
    
	Inventory[_CurrentRealm][_CurrentPlayerName]["Time"]["OnLoad"] = time();

	BankerLoadTime = time()
end



function Banker_OnEvent(self,event,...)

	recordTimeOfEvent(event)
	
	if "BANKFRAME_OPENED"==event then
		local toi = TableOfInventory()
		
		if not Inventory then
			Inventory = {}
		end
		initTable(Inventory,_CurrentRealm,_CurrentPlayerName,"Inventory")
		initTable(Inventory,_CurrentRealm,_CurrentPlayerName,"Time")
		
		Inventory[_CurrentRealm][_CurrentPlayerName]["Inventory"] = toi;
		Inventory[_CurrentRealm][_CurrentPlayerName]["Time"]["Updated"] = time();
		
		local size = tablelength(toi)
		
		print("Banker Updated: " .. ColorText(255,102,00) .. size .. ColorText() );
        
    elseif event=="CHAT_MSG_ADDON" and select(1,...)=="_BankerSearch" then
        local prefix = select(1,...)
        local msg = select(2,...)
        local channel = select(3,...)
        local fullName = select(4,...)
        
        ParseBankerSearchRequest(msg,fullName)
		
	end
	
end


function ParseBankerSearchRequest(msg,fullName)
    print('ParseBankerSearchRequest', fullName , msg )
    
    
end



local eventIdNumber = 0

function recordTimeOfEvent(event)

	local Server = GetRealmName();
	local CurrentPlayerName = UnitName("player");

	if not CharRecords then
		CharRecords = {};
	end
	
	if not CharRecords[Server] then
		CharRecords[Server] = {};
	end
	
	if not CharRecords[Server][CurrentPlayerName] then
		CharRecords[Server][CurrentPlayerName] = {};
	end
	
	if not CharRecords[Server][CurrentPlayerName][event] then
		CharRecords[Server][CurrentPlayerName][event] = {};
	end
	
	CharRecords[Server][CurrentPlayerName][event]["GetTime"] = time();
	CharRecords[Server][CurrentPlayerName][event]["time"] = time();
	
	CharRecords[Server][CurrentPlayerName][event]["eventIdNumber"] = eventIdNumber;

	eventIdNumber = eventIdNumber + 1
end


function Banker_OnUpdate()

end




SLASH_BANKERADDON_SEARCH1 = '/banker';
function SlashCmdList.BANKERADDON_SEARCH(msg, editbox) 
	BankerSlashHandler(msg,editbox,"BANKER")
end


function BankerSlashHandler(msg,editbox,source)

	msg = trim(msg)

	local lmsg = string.lower(msg)

	if string.len(msg)<=1 or lmsg=="help" or lmsg=="?" then

		print("Use "..ColorText(1,0,0).."/banker cloth]"..ColorText().." to search for various cloths")

	else
		-- TODO: SendAddonMessage("_BankerSearch", msg, "GUILD")
		DisplaySearchBanker(msg)

	end

end


---- /run DisplaySearchBanker("oom")
function DisplaySearchBanker(itemName)

    local searchData, totalData, linkLookupTable = GetTableSearchBanker(itemName)
    
    print("Searching for: " .. ColorText(255,102,0) .. itemName)
    
    for charName,items in pairs(searchData) do
    
        print(ColorText(1,0,1) .. charName)
        
        for link,count in pairs(items) do
        
            print("   " .. link .. "  " .. ColorText(0,1,0) .. count)
        end

    end
    
    print(ColorText(255,102,0) .. "Total")

    for itemName,count in pairs(totalData) do

        local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(itemName)
        local key = linkLookupTable[itemName] or linkLookupTable[name] or link or itemName or name
        print("   " .. key .. "  " .. ColorText(204,0,0) .. count)
    end
    
    ---tprint(linkLookupTable)

end


---- /run r,t = GetTableSearchBanker("oom"); tprint( r ); tprint(t)
function GetTableSearchBanker(itemName)

    local lmsg = string.lower(itemName)
    
    local results = {}
    local resultsTotal = {}
    local linkLookupTable = {}

    for charName, charInvData in pairs(Inventory[_CurrentRealm]) do

        for loc, itemInformation in pairs(charInvData["Inventory"]) do
        
            local count = itemInformation["count"]
            local itemLink = itemInformation["itemLink"]
            local id = itemInformation["itemId"]
            
            local llink = string.lower(itemLink)
            
            local matchAll = true
            
            for keyword in string.gmatch(lmsg, "%S+") do
                if not string.find(llink,keyword,1,true) then
                    matchAll = false
                end
            end
            
            if matchAll then
                if results[charName]==nil then
                    results[charName] = {}
                end
                
                if results[charName][itemLink]==nil then
                    results[charName][itemLink] = 0
                end

                results[charName][itemLink] = count + results[charName][itemLink]


                local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(itemLink)
                ---print(name,link)
                
                local key = name or link or itemLink
                if resultsTotal[key]==nil then
                    resultsTotal[key] = 0
                end                
                
                resultsTotal[key] = count + resultsTotal[key] 
                
                linkLookupTable[key] = link or itemLink
            end
        
        end

    end
    
    return results, resultsTotal, linkLookupTable
end



