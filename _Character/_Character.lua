
-- Initialize the variables
local _CurrentRealm = GetRealmName();
local _CurrentPlayerName = UnitName("player");



function Character_OnLoad()
	initializeCharacterRecord()

	CharacterRecordFrame:RegisterEvent("BANKFRAME_OPENED");
	CharacterRecordFrame:RegisterEvent("PLAYERBANKBAGSLOTS_CHANGED");
	CharacterRecordFrame:RegisterEvent("PLAYERBANKSLOTS_CHANGED");
	--CharacterRecordFrame:RegisterEvent("BANKFRAME_CLOSED");

	CharacterRecordFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	CharacterRecordFrame:RegisterEvent("PLAYER_LOGOUT");

	-- TODO: Mail in different add-on
	CharacterRecordFrame:RegisterEvent("MAIL_SHOW");
	CharacterRecordFrame:RegisterEvent("MAIL_CLOSED");

	cRecordTimeOfEvent("Character_OnLoad()")

	t_CharacterLoadTime = time()
	print("Character_OnLoad()")
end


	-- Initialize the variables
function initializeCharacterRecord()

	if not CharacterRecord then
		CharacterRecord = {}
	end

	initTable(CharacterRecord,_CurrentRealm,_CurrentPlayerName,"EVENTS")
	initTable(CharacterRecord,_CurrentRealm,_CurrentPlayerName,"GENERAL")
	initTable(CharacterRecord,_CurrentRealm,_CurrentPlayerName,"PROFESSIONS")
	initTable(CharacterRecord,_CurrentRealm,_CurrentPlayerName,"CONTAINERS")

end




function Character_OnEvent(self,event,...)
	cRecordTimeOfEvent(event)

	if event=="PLAYER_LOGOUT" or event=="PLAYER_ENTERING_WORLD" then
		UpdateGeneralInfo(event)
		UpdateProfessionInfo()
	end

	if event=="BANKFRAME_OPENED" or event=="PLAYERBANKSLOTS_CHANGED" or event=="PLAYERBANKBAGSLOTS_CHANGED" then
		if BankFrameIsVisible() and xtimer("Character_OnEvent" .. event,3) then
			UpdateGeneralInfo(event)
			UpdateContainerInfo()
			UpdateHeirloomInfo()
		end
	end

end


local cr_eventIdNumber = 0

function cRecordTimeOfEvent(event)
	initializeCharacterRecord()

	CharacterRecord[_CurrentRealm][_CurrentPlayerName]["EVENTS"][event] = {}

	CharacterRecord[_CurrentRealm][_CurrentPlayerName]["EVENTS"][event]["time"] = time()
	CharacterRecord[_CurrentRealm][_CurrentPlayerName]["EVENTS"][event]["Event ID Number"] = cr_eventIdNumber;

	cr_eventIdNumber = cr_eventIdNumber + 1
end



function UpdateProfessionInfo()
	local toProf = TableOfProfessions()
	local sizeTable = tablelength(toProf)

	if sizeTable>0 then
		CharacterRecord[_CurrentRealm][_CurrentPlayerName]["PROFESSIONS"] = toProf
        if xtimer("UpdateProfessionInfo",45) then
            tprint(toProf)
        end

	else
		print("No Professions Found")

	end
end


function UpdateHeirloomInfo()
	if BankFrameIsVisible() and xtimer("UpdateHeirloomInfo",30) then
		initTable(CharacterRecord,_CurrentRealm,_CurrentPlayerName,"HEIRLOOMS")

		local heirT,count = parseTableForHeirlooms()
		local size = tablelength(heirT)

		if count==0 and size==0 then
			CharacterRecord[_CurrentRealm][_CurrentPlayerName]["HEIRLOOMS"] = nil
			print("No Heirlooms found.")


		else
			CharacterRecord[_CurrentRealm][_CurrentPlayerName]["HEIRLOOMS"] = heirT
			print("Heirlooms found: " .. ColorText(0,255,0) .. count .. ColorText() .. "   " .. ColorText(0,0,255) .. size .. ColorText())
			for k, v in pairs(heirT) do
				print(k .. " " .. ColorText(255,102,0) .. v .. ColorText() )
			end

		end

	end
end



function isFiniteNumber(object)
	if object~=object then
		return false,"object~=object"
	end
	local n = tonumber(object)
	if n>=math.huge or math.huge<=n then
		return false,"n>=math.huge"
	end
	if n<=-math.huge or -math.huge>=n then
		return false,"n<=-math.huge"
	end
	local s = string.lower(tostring(n))
	if string.match(s, "nan") then
		return false,"nan"
	end
	local m = string.match(s, "%d*.?%d*")
	return s==m,n
end


function UpdateGeneralInfo(cause)
	initializeCharacterRecord()

	if CharacterRecord and CharacterRecord[_CurrentRealm] and CharacterRecord[_CurrentRealm][_CurrentPlayerName] and CharacterRecord[_CurrentRealm][_CurrentPlayerName]["GENERAL"] then
		local cr_cr_cpn_g = CharacterRecord[_CurrentRealm][_CurrentPlayerName]["GENERAL"]
		local beforeLevel = cr_cr_cpn_g['Level']

		local togci = TableOfGeneralCharacterInfo(cr_cr_cpn_g)
		local afterLevel = togci['Level']

		if beforeLevel and not afterLevel then
			print("afterLevel",afterLevel,"beforeLevel",beforeLevel)
			togci['Level'] = beforeLevel
		end

		local function isnan(x) return x ~= x end

		local level = getLastKnownLevel()
		if level>0 then
			togci['Level'] = round(level,3)
		end

		if not togci['Guild Name'] or not togci['Guild Rank'] or true then
			--print(g_lastKnownGuildInfo)

			togci['Guild Name'] = g_lastKnownGuildInfo[1]
			togci['Guild Rank'] = g_lastKnownGuildInfo[2]
		end

		CharacterRecord[_CurrentRealm][_CurrentPlayerName]["GENERAL"] = togci
	end
end



function UpdateContainerInfo()

	if BankFrameIsVisible() then
		CharacterRecord[_CurrentRealm][_CurrentPlayerName]["CONTAINERS"] = TableOfContainerInfo()
	end

end


g_lastKnownPlayerLevel = -1
function getLastKnownLevel()
	local calclevel, baselevel = getDecimalPlayerLevel()

	calclevel = tonumber(calclevel)

	if tostring(calclevel) == "nan" or (calclevel ~= calclevel) then
		-- ignore --- skip NAN!

	elseif calclevel>0 and 0<calclevel and calclevel<math.huge and math.huge>calclevel then
		if calclevel and type(calclevel)=='number' and calclevel>=g_lastKnownPlayerLevel then
			g_lastKnownPlayerLevel = calclevel
		end

	end

	return g_lastKnownPlayerLevel
end


g_lastKnownGuildInfo = {"","",""}

g_needEchoedCharacterInfo = false

function Character_OnUpdate()
    if not t_CharacterLoadTime then
        return
    end

    local calclevel, baselevel = getDecimalPlayerLevel()

    local guildName, guildRankName, guildRankIndex = GetGuildInfo("player");

    if not UnitAffectingCombat('player') and guildName and guildRankName and guildRankIndex and xtimer("g_lastKnownGuildInfo",120) then
        g_lastKnownGuildInfo = {guildName, guildRankName, guildRankIndex}
        --tprint(g_lastKnownGuildInfo)
        --print( g_lastKnownGuildInfo[1], g_lastKnownGuildInfo[2] )

    elseif ( IsResting() or not UnitAffectingCombat('player') ) and xtimer("UpdateCharacterData",4*60) then
        UpdateGeneralInfo("OnUpdate")

    elseif ( IsResting() and not UnitAffectingCombat('player') ) and xtimer("UpdateProfessionInfo",3*60) then
        UpdateProfessionInfo()

    end

	if not g_needEchoedCharacterInfo and t_CharacterLoadTime and time()-t_CharacterLoadTime > 1.2 then
		g_needEchoedCharacterInfo = true
		DisplayCharacters()
	end
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

