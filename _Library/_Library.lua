-- UIErrorsFrame:AddMessage( "msg" ,0,1,.5,1,2)
-- string.find( UnitDebuff("target",i ), sDebuffName )
-- DEFAULT_CHAT_FRAME:AddMessage( "woot!" )


---------------------------------------------------------------------------------------------------
--- Table Tools --- Table Tools --- Table Tools --- Table Tools --- Table Tools --- Table Tools ---
---------------------------------------------------------------------------------------------------


-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
function tprint (tbl, indent)
	if type(tbl) == "table" then
	else
		print(ColorText(0,1,0)..tostring(tbl)..ColorText())
		return
	end
	if not indent then indent = 0 end
	for k, v in pairs(tbl) do
		local formatting = string.rep("  ", indent) .. k .. ": "
		if type(v) == "table" then
			print(formatting)
			tprint(v, indent+1)
		else
			print(formatting .. tostring(v))
		end
	end
end


function initTable(itable,...)
	--print(itable)
	--print(type(itable))

	if "table"~=type(itable) then
		error("initTable(itable,...) was not passed a table")
	end

	local n = select("#", ...)

	if n>=1 and not itable[select(1,...)] then
		itable[select(1,...)] = {}
	end

	if n>=2 and not itable[select(1,...)][select(2,...)] then
		itable[select(1,...)][select(2,...)] = {}
	end

	if n>=3 and not itable[select(1,...)][select(2,...)][select(3,...)] then
		itable[select(1,...)][select(2,...)][select(3,...)] = {}
	end

	if n>=4 and not itable[select(1,...)][select(2,...)][select(3,...)][select(4,...)] then
		itable[select(1,...)][select(2,...)][select(3,...)][select(4,...)] = {}
	end

	if n>=5 and not itable[select(1,...)][select(2,...)][select(3,...)][select(4,...)][select(5,...)] then
		itable[select(1,...)][select(2,...)][select(3,...)][select(4,...)][select(5,...)] = {}
	end

	if n>=6 and not itable[select(1,...)][select(2,...)][select(3,...)][select(4,...)][select(5,...)][select(6,...)] then
		itable[select(1,...)][select(2,...)][select(3,...)][select(4,...)][select(5,...)][select(6,...)] = {}
	end

	if n>=7 and not itable[select(1,...)][select(2,...)][select(3,...)][select(4,...)][select(5,...)][select(6,...)][select(7,...)] then
		itable[select(1,...)][select(2,...)][select(3,...)][select(4,...)][select(5,...)][select(6,...)][select(7,...)] = {}
	end

	if n>=8 and not itable[select(1,...)][select(2,...)][select(3,...)][select(4,...)][select(5,...)][select(6,...)][select(7,...)][select(8,...)] then
		itable[select(1,...)][select(2,...)][select(3,...)][select(4,...)][select(5,...)][select(6,...)][select(7,...)][select(8,...)] = {}
	end

	if n>=9 and not itable[select(1,...)][select(2,...)][select(3,...)][select(4,...)][select(5,...)][select(6,...)][select(7,...)][select(8,...)][select(9,...)] then
		itable[select(1,...)][select(2,...)][select(3,...)][select(4,...)][select(5,...)][select(6,...)][select(7,...)][select(8,...)][select(9,...)] = {}
	end

	--[[
	for i=1, n do
		local arg = select(i, ...)

		print(arg)
		itable
	end
	]]--

end


function tablelength(T)
	local count = 0
	for _ in pairs(T) do
		count = count + 1
	end
	return count
end




function buildarray(...)
	local arr = {}
	for v in ... do
		---arr[#arr + 1] = v
		table.insert(arr, v)
	end
	return arr
end


---------------------------------------------------------------------------------------------------
------- Text Chat Color ----- Text Chat Color -----  Text Chat Color -----  Text Chat Color -------
---------------------------------------------------------------------------------------------------



 function ColorText(red,green,blue)

	-- string representation of colors converted
	if red and not green and not blue then

		if string.lower(red) == "orange" then
			red = 255
			green = 102
			blue = 0

		elseif string.lower(red) == "maroon" then
			red = 102
			green = 0
			blue = 0


		elseif string.lower(red) == "poor" then
			red = 157
			green = 157
			blue = 157

		elseif string.lower(red) == "common" then
			red = 255
			green = 255
			blue = 255

		elseif string.lower(red) == "uncommon" then
			red = 30
			green = 255
			blue = 0

		elseif string.lower(red) == "rare" then
			red = 0
			green = 112
			blue = 221

		elseif string.lower(red) == "epic" then
			red = 163
			green = 53
			blue = 238

		elseif string.lower(red) == "legendary" then
			red = 255
			green = 128
			blue = 0

		elseif string.lower(red) == "artifact" or string.lower(red) == "heirloom" then
			red = 230
			green = 204
			blue = 128

		end
	end

	local red = tonumber( red )
	local green = tonumber( green )
	local blue = tonumber( blue )

	if type(red)=="number" and type(green)=="number" and type(blue)=="number" then
		if red<=0 then red=0 end
		if green<=0 then green=0 end
		if blue<=0 then blue=0 end

		if red<=1 and green<=1 and blue<=1 then
			red = red*256
			green = green*256
			blue = blue*256
		end

		red = round( red )
		green = round( green )
		blue = round( blue )

		if red>=255 then red=255 end
		if green>=255 then green=255 end
		if blue>=255 then blue=255 end

		return "\124cFF"..string.format("%02x%02x%02x", red, green, blue)
	else
		return "\124r"
	end
end


function round(fnumber,rnum)
	if not fnumber then return fnumber end
	if not rnum then rnum=0 end
	local rnum = -1 * rnum

	local divnum=10^rnum
	local returnval
	returnval=fnumber/divnum
	returnval=floor(returnval)
	returnval=returnval*divnum
	returnval=tonumber(returnval)

	return (returnval)
end



function ScrollToBottom()
    DEFAULT_CHAT_FRAME:ScrollToBottom()
end


function addMsg(...)
	DEFAULT_CHAT_FRAME:AddMessage(...)
end



-- /script SendChatMessage("Hello Bob!", "WHISPER", "Common", "Bob");

function SendChatMessageInstance(pmsg)
	local inInstance, instanceType = IsInInstance()
	if inInstance then
		SendChatMessage(pmsg,"INSTANCE_CHAT")
	else
		SendChatMessageParty(pmsg)
	end
end

function SendChatMessageParty(pmsg)
	SendChatMessage(pmsg,"PARTY")
end


function SendChatMessageWhisper(pmsg,person)
	SendChatMessage(pmsg,"WHISPER",nil,person)
end






function trim(s)
  return s:match'^()%s*$' and '' or s:match'^%s*(.*%S)'
end






function createColoredArgumentEventString(event,...)

	local argN = select("#",...)

	local eventColor

	if event=="COMBAT_LOG_EVENT_UNFILTERED" then
		eventColor = ColorText(0.75,1,0.5)
	else
		eventColor = ColorText(0.5,0.5,1)
	end

	local argString = eventColor .. event .. ColorText() .. " "

	for i = 1, argN do
		argString = buildEventFinderString(argString,i,...)
	end

	return argString

end



function buildEventFinderString(argString, index, ...)

	local s = select(index,...)

	if index==1 and type(s)=='number' and strfind( argString, "COMBAT_LOG_EVENT" ) then
		s=nil
	end

	if s or type(s)=='boolean' then
		return argString .. ColorText(255,0,0).."arg"..index.."="..ColorText() .. stringify(s) .. " "
	else
		return argString
	end

end


function stringify(s)

	if type(s)=='boolean' then
		if s then
			return "true"
		else
			return "false"
		end
	elseif type(s)=='nil' then
		return "nil"
	elseif type(s)=='table' then
		return "<TABLE>"
	else
		return s
	end

end

---------------------------------------------------------------------------------------------------
---- Character ----- Character ----- Character ----- Character ----- Character ----- Character ----
---------------------------------------------------------------------------------------------------

function DisplayCharacterGold()
	for serverName,serverData in pairs(CharacterRecord) do
		local gold = 0

		local goldTable = {}

		for characterName,characterData in pairs(serverData) do
			local cgold = characterData['GENERAL']['Gold']
			gold = gold + cgold
			--goldTable[characterName]=cgold
			table.insert(goldTable,{name=characterName,gold=cgold})
		end

		print("  " .. ColorText(255,102,0) .. serverName .. "  " .. ColorText(102,255,0) .. round(gold))


		table.sort(goldTable,function(a,b) return a['gold']>b['gold'] end)

		--tprint(goldTable)

		for k, v in pairs(goldTable) do
			local name = v['name']
			local gold = v['gold']
			print( "  " .. "  " .. name .. ColorText(1,1,0) .. " " .. round(gold) )
		end

		for characterName,characterData in pairs(serverData) do
			--print( "  " .. "  " .. characterName .. ColorText(1,0,0) .. " " .. round(characterData['GENERAL']['Gold']))
		end

	end
end



--- /run DisplayCharacters()
function DisplayCharacters()
	print(ColorText(255,102,0) .."Character Info:")

	local function ColorCodeTimePassed(oldest)
		local blue = ColorText(0.1,1,1)
		local green = ColorText(0.1,1,0.1)
		local yellow = ColorText(1,1,0.1)
		local orange = ColorText(1,1,0.1)
		local red = ColorText(1,0.1,0.1)

		local timepassed = time() - oldest[1]
		local oldestType = oldest[2]

		if oldestType~='mailbox' then
			return red .. " check mailbox"
		end

		if (timepassed < 10) then
			return blue .. " few seconds ago"
		elseif (timepassed < 90) then
			return blue .. round(timepassed) .. " seconds"
		end

		local minutes = timepassed / 60.0
		if (minutes < 10) then
			return blue .. round(minutes,1) .. " minutes"
		elseif (minutes < 90) then
			return blue .. round(minutes,0) .. " minutes"
		end

		local hours = minutes / 60.0
		if (hours < 10) then
			return blue .. round(hours,1) .. " hours"
		elseif (hours < 24*3) then
			return green .. round(hours,0) .. " hours"
		end

		local days = hours / 24.0
		if (days < 10) then
			return yellow .. round(days,1) .. " days"
		elseif (days < 20) then
			return orange .. round(days,0) .. " days"
		else -- days > 20
			return red .. round(days,0) .. " days"
		end
	end

	local function getEventTime(events,eventName)
		if events and events[eventName] and events[eventName]['time'] then
			return events[eventName]['time']
		end
	end

	for serverName,serverData in pairs(CharacterRecord) do
		print("  " .. ColorText(255,102,0) .. serverName)

		local sortedServerData = {}
		local sortedServerKeys = {}
		for characterName,characterData in pairs(serverData) do
			if characterData and characterData['GENERAL'] then
				local fullname = characterData['GENERAL']['Full-Name']
				local level = characterData['GENERAL']['Level']
				local class = characterData['GENERAL']['Class']
				local guild = characterData['GENERAL']['Guild Name'] or "<NONE>"
				local race = characterData['GENERAL']['Race']

				local events = characterData['EVENTS']

				local oldest = {time(),""}

				local logout = getEventTime(events,'PLAYER_LOGOUT')
				local enterWorld = getEventTime(events,'PLAYER_ENTERING_WORLD')
				local mailbox = getEventTime(events,'MAIL_CLOSED')
				--local bankframe = getEventTime(events,'BANKFRAME_CLOSED')

				if logout and logout<oldest[1] then
					oldest[1] = logout
					oldest[2] = 'logout'
				end
				if enterWorld and enterWorld<oldest[1] then
					oldest[1] = enterWorld
					oldest[2] = 'enterWorld'
				end
				if mailbox then
					oldest[1] = mailbox
					oldest[2] = 'mailbox'
				end


				local printString = "  " .. "  " .. tostring(characterName) .. ColorText(1,0,0) .. " " .. tostring(round(level)) .. ColorText(0,1,0) .. " " .. tostring(class) .. ColorText(0.5,1,0) .. " " .. tostring(race) .. ColorText(1,1,1) .. " " .. tostring(guild) .. " " .. ColorCodeTimePassed(oldest)
				--print(printString)
				local ssd = oldest[1]
				sortedServerData[ssd] = printString
				table.insert(sortedServerKeys,ssd)
			else
				local ssd = math.huge
				sortedServerData[ssd] = "  " .. "  " .. characterName .. ColorText(1,0,0) .. " Missing data"
				table.insert(sortedServerKeys,ssd)
			end
		end

		table.sort(sortedServerKeys,function(a,b) return a>b end)

		for k,v in pairs(sortedServerKeys) do
			local toPrint = sortedServerData[v]
			print(toPrint)
		end
	end
end



--- /run DisplayProfessions()
function DisplayProfessions()
    print(ColorText(255,102,0) .."Profession Info:")

    local function getProfessions(characterName,characterData)
        local fullname = characterData['GENERAL']['Full-Name']
        local level = characterData['GENERAL']['Level']
        local class = characterData['GENERAL']['Class']
        local guild = characterData['GENERAL']['Guild Name'] or "<NONE>"
        local race = characterData['GENERAL']['Race']

        local professions = characterData['PROFESSIONS']

        if not professions then
            return
        end

        local profs = {}

        for profession,value in pairs(professions) do
            local curr, _, cap = strsplit(" ", value)

            local current = tonumber(curr)

            if (current >= 75) then
                table.insert(profs,{characterName,profession,current,tonumber(cap)})
            end
        end

        if table.getn(profs)>0 then
            print("  " .. "  " .. characterName .. ColorText(1,0,0) .. " " .. round(level) .. ColorText(0,1,0) .. " " .. class)

            for key,value in pairs(profs) do
                local c = ColorText(0.5,0.5,1.0)
                if (value[4] - value[3] <= 25) then
                    c = ColorText(1,0.5,1.0)
                end

                print("  " .. "  " .. "  " .. ColorText(1,0.75,0.50) .. value[2] .. " " .. c .. value[3] .. "  ")
            end
        end

        ---tprint(characterData['PROFESSIONS'])
        ---print("  " .. "  " .. characterName .. ColorText(1,0,0) .. " " .. round(level) .. ColorText(0,1,0) .. " " .. class .. ColorText(0.5,1,0) )
    end

    for serverName,serverData in pairs(CharacterRecord) do
        print("  " .. ColorText(255,102,0) .. serverName)
        for characterName,characterData in pairs(serverData) do
            getProfessions(characterName,characterData)
        end
    end
end





---------------------------------------------------------------------------------------------------
----- Start Combat Aggro --- Start Combat Aggro --- Start Combat Aggro --- Start Combat Aggro -----
---------------------------------------------------------------------------------------------------




function numberPartyInCombat()
	local s = 0
	local who = nil

	for i = 0, 8 do
		local partyI = "party"..i
		local affectingCombat = UnitAffectingCombat(partyI);
		if affectingCombat then
			s = s + 1

			if who==nil then
				who = GetUnitName(partyI,true)
			else
				who = who .. ", " .. GetUnitName(partyI,true)
			end
		end
	end

	local partyI = "player"
	local affectingCombat = UnitAffectingCombat(partyI);
	if affectingCombat then
			s = s + 1

			if who==nil then
				who = GetUnitName(partyI,true)
			else
				who = who .. ", " .. GetUnitName(partyI,true)
			end
	end

	return s, who
end










---------------------------------------------------------------------------------------------------
------- Group Roles ----- Group Roles ----- Group Roles ----- Group Roles ----- Group Roles -------
---------------------------------------------------------------------------------------------------


function whoHealer()
	local s = 0
	local who = {}

	for i = 0, 8 do
		local partyI = "party"..i
		local role = UnitGroupRolesAssigned(partyI);
		if "HEALER"==role then
			s = s + 1
			table.insert(who,partyI)
		end
	end

		local partyI = "player"
		local role = UnitGroupRolesAssigned(partyI);
		if "HEALER"==role then
			s = s + 1
			table.insert(who,partyI)
		end

	return s, who
end



function whoTank()
	local s = 0
	local who = {}

	for i = 0, 8 do
		local partyI = "party"..i
		local role = UnitGroupRolesAssigned(partyI);
		if "TANK"==role then
			s = s + 1
			table.insert(who,partyI)
		end
	end

		local partyI = "player"
		local role = UnitGroupRolesAssigned(partyI);
		if "TANK"==role then
			s = s + 1
			table.insert(who,partyI)
		end

	return s, who
end



function GetNumMembers()

	--[[
	local members = GetNumRaidMembers();

	if members==nil then
		members = -1
	end

	local partyMembers = GetNumPartyMembers()

	if partyMembers==nil then
		partyMembers = -1
	end

	if members > partyMembers then
		return members
	else
		return partyMembers
	end
	]]--

	return GetNumGroupMembers();

end





---------------------------------------------------------------------------------------------------
----- Party Raid Markers --- Party Raid Markers --- Party Raid Markers --- Party Raid Markers -----
---------------------------------------------------------------------------------------------------



-- /script if not GetRaidTargetIndex("target") then SetRaidTarget("target",7) end

function AutoPartyRaidTargetMarkers()

	for i = 0, 8 do
		local partyI = "party"..i
		AutoRaidTargetMarkMember(partyI)
	end

		AutoRaidTargetMarkMember("player")

end



function AutoRaidTargetMarkMember(memberID)

	if UnitExists(memberID) and not GetRaidTargetIndex(memberID) then

		local role = UnitGroupRolesAssigned(memberID);

		local name, realm = UnitName(memberID)

		local fullname = name.."-"..(realm or "null")

		local xname = "AutoRaidTargetMarkMember:"..fullname..":"..role

		if "TANK" == role and xtimer(xname,15*60) then

			SetRaidTarget(memberID,1)

		elseif "HEALER" == role and xtimer(xname,15*60) then

			SetRaidTarget(memberID,5)

		end

	end

end




function CycleRaidTargetMarker(unit)

	cycleRaidTargetMarkerIndex = cycleRaidTargetMarkerIndex or 1

	if UnitExists(unit) then

		SetRaidTarget(unit,cycleRaidTargetMarkerIndex)

		cycleRaidTargetMarkerIndex = 1 + cycleRaidTargetMarkerIndex

		if cycleRaidTargetMarkerIndex>6 then
			cycleRaidTargetMarkerIndex = nil
		end

	end

end



---------------------------------------------------------------------------------------------------
------- Unit Raid Party Target ------- Unit Raid Party Target ------ Unit Raid Party Target -------
---------------------------------------------------------------------------------------------------


function RepresentativeUnitPercentHealth(unitId,notExistCost,rangeCost,notFriendlyCost,deadCost)
	rangeCost = rangeCost or             1000;
	deadCost = deadCost or               10000;
	notExistCost = notExistCost or       100000;
	notFriendlyCost = notFriendlyCost or 1000000;

	local exists = UnitExists(unitId);
	if not exists then
		return notExistCost;
	end

	local cost = 0;

	local dead = UnitIsDead(unitId)
	if dead then
		cost = deadCost + cost
	end

	local inRange, checkedRange = UnitInRange(unitId)
	if not inRange and checkedRange then
		cost = rangeCost + cost
	end

	local friendly = UnitCanAssist("player", unitId)
	if not friendly then
		cost = notFriendlyCost + cost
	end

	local percent = 100*UnitHealth(unitId) / UnitHealthMax(unitId);

	return percent + cost;
end


-- /run print( LowestTeamHealth() )

--minimum hp health among all raid party unit members
function LowestTeamHealth()

	local lowest = RepresentativeUnitPercentHealth("player")

	for i=0,5 do
		local unitId = "party"..i;

		ruph = RepresentativeUnitPercentHealth(unitId)

		lowest = math.min(lowest,ruph);
	end

	for i=0,40 do
		local unitId = "raid"..i;

		ruph = RepresentativeUnitPercentHealth(unitId)

		lowest = math.min(lowest,ruph);
	end

	return lowest;
end




---------------------------------------------------------------------------------------------------
---- Zone Info Text --- Zone Info Text --- Zone Info Text --- Zone Info Text --- Zone Info Text ---
---------------------------------------------------------------------------------------------------


function zoneInfo()

	local zoneName = GetZoneText();
	local subzone = GetSubZoneText();
	local minimapzonetext = GetMinimapZoneText();

	return ( zoneName .. " | " .. subzone .. " | " .. minimapzonetext )
end












---------------------------------------------------------------------------------------------------
---- Macro Helpers ---- Macro Helpers ---- Macro Helpers ---- Macro Helpers ---- Macro Helpers ----
---------------------------------------------------------------------------------------------------


function xtarget(markNumber)
	if not markNumber then
		markNumber = 7
	end
	if UnitExists("target") and not GetRaidTargetIndex("target") then
		SetRaidTarget("target",markNumber)
	end
end





function DoEmoteOOM()
	DoEmote("OOM")
end







function QuadSafeEndCinematic()

	if xtimer("TripleSafeEndCinematic_1",2) then
		return 1
	end
	if xtimer("TripleSafeEndCinematic_2",2) then
		return 2
	end
	if xtimer("TripleSafeEndCinematic_3",2) then
		return 3
	end

	if xtimer("QuadSafeEndCinematic() StopCinematic()",3) then
		print( "QuadSafeEndCinematic()  " .. stringify(InCinematic()) )

		StopCinematic()
	end

end







local waitTable = {};
local waitFrame = nil;

function oom__wait(delay, func, ...)
	if(type(delay)~="number" or type(func)~="function") then
		return false;
	end

	if(waitFrame == nil) then
		waitFrame = CreateFrame("Frame","WaitFrame", UIParent);
		waitFrame:SetScript("onUpdate",
			function (self,elapse)
				local count = #waitTable;
				local i = 1;
				while(i<=count) do
					local waitRecord = tremove(waitTable,i);
					local d = tremove(waitRecord,1);
					local f = tremove(waitRecord,1);
					local p = tremove(waitRecord,1);
					if(d>elapse) then
						tinsert(waitTable,i,{d-elapse,f,p});
						i = i + 1;
					else
						count = count - 1;
						f(unpack(p));
					end
				end
			end
		);
	end
	tinsert(waitTable,{delay,func,{...}});
	return true;
end



function cycleGuildBankTab()

	if not curTab then
		curTab = 1
	end

	if curTab==1 then
		GuildBankTab1Button:Click()

	elseif curTab==2 then
		GuildBankTab2Button:Click()

	elseif curTab==3 then
		GuildBankTab3Button:Click()

	elseif curTab==4 then
		GuildBankTab4Button:Click()

	elseif curTab==5 then
		GuildBankTab5Button:Click()

	elseif curTab==6 then
		GuildBankTab6Button:Click()

	end

	curTab = 1 + curTab

	if curTab>6 then
		curTab = nil
	end

end


---------------------------------------------------------------------------------------------------
--- Professions --- Professions --- Professions --- Professions --- Professions --- Professions ---
---------------------------------------------------------------------------------------------------

function printProfessions()

	local prof1, prof2, archaeology, fishing, cooking, firstAid = GetProfessions();

	if not firstAid then
		firstAid = ""
	end

	if not archaeology then
		archaeology = ""
	end

	print(prof1 .. " " .. prof2 .. " " .. archaeology .. " " .. fishing .. " " .. cooking .. " " .. firstAid )

	local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier, specializationIndex, specializationOffset = GetProfessionInfo(prof1)
	print(name .. " " .. skillLevel .. " " .. maxSkillLevel )


	local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier, specializationIndex, specializationOffset = GetProfessionInfo(prof2)
	print(name .. " " .. skillLevel .. " " .. maxSkillLevel )

end




function TableOfProfessions()

	local profTable = {}

	local prof1, prof2, archaeology, fishing, cooking, firstAid = GetProfessions();

	if prof1 then
		local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier, specializationIndex, specializationOffset = GetProfessionInfo(prof1)
		profTable[name] = skillLevel .. " / " .. maxSkillLevel
	end

	if prof2 then
		local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier, specializationIndex, specializationOffset = GetProfessionInfo(prof2)
		profTable[name] = skillLevel .. " / " .. maxSkillLevel
	end

	if archaeology then
		local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier, specializationIndex, specializationOffset = GetProfessionInfo(archaeology)
		profTable[name] = skillLevel .. " / " .. maxSkillLevel
	end

	if fishing then
		local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier, specializationIndex, specializationOffset = GetProfessionInfo(fishing)
		profTable[name] = skillLevel .. " / " .. maxSkillLevel
	end

	if cooking then
		local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier, specializationIndex, specializationOffset = GetProfessionInfo(cooking)
		profTable[name] = skillLevel .. " / " .. maxSkillLevel
	end

	if firstAid then
		local name, icon, skillLevel, maxSkillLevel, numAbilities, spelloffset, skillLine, skillModifier, specializationIndex, specializationOffset = GetProfessionInfo(firstAid)
		profTable[name] = skillLevel .. " / " .. maxSkillLevel
	end

	return profTable

--	if table.getn(profTable)>0 then
--		return profTable
--	else
--		return nil
--	end
end




---------------------------------------------------------------------------------------------------
------- Frames --- Frames --- Frames --- Frames --- Frames --- Frames --- Frames --- Frames -------
---------------------------------------------------------------------------------------------------


--- PrintFramesRegisteredForEvent("PLAYERBANKSLOTS_CHANGED")
--- PrintFramesRegisteredForEvent("PLAYERBANKBAGSLOTS_CHANGED")

function PrintFramesRegisteredForEvent(evt)

	local num = select( "#", GetFramesRegisteredForEvent(evt) )
	print(ColorText(1,0,0)..num)
	for i = 1, num do
		local s = select( i, GetFramesRegisteredForEvent(evt) )
		print(ColorText(0,1,0)..i)
		print( s:GetName() )
	end

end



function BankFrameIsVisible()
	return BankFrame:IsVisible()
end


function LossOfControlFrameIsVisible()
	return LossOfControlFrame:IsVisible()
end


--[[
/run PrintParentFrameList(CharacterBag0Slot)
--]]

function PrintParentFrameList(frm)

	local f = frm

	for i =1, 100 do

		if f then
			print( i .. "  " .. ColorText(1,.5,.5) .. f:GetName() )
		end

		if f:GetParent() then
			f = f:GetParent()
		else
			break
		end
	end

	print( "^" .. "  " .. ColorText(1,.5,.5) .. f:GetName() )
end

--[[
/run PrintChildFrame(LossOfControlFrame)
--]]

function PrintChildFrame(frm,depth)

	if not frm then
		return
	end

	if not frm:GetName() then
		print( tostring(frm) .. "  " .. ColorText(0.5,1,0.5) .. select('#', frm:GetChildren() ) )
		return
	end

	if not depth then
		depth = 0
	end

	if depth > 2 then
		return
	end

	print( depth .. "  " .. ColorText(1,0.5,0.5) .. frm:GetName() .. ColorText() .. "  " .. ColorText(0.5,1,0.5) .. select('#', frm:GetChildren()) .. ColorText() )

	PrintChildFrameR( depth, frm:GetChildren() )
	--[[
	for cf in frm:GetChildren() do
		PrintChildFrame( cf, depth+1 )
	end
	]]--
end



function PrintChildFrameR(depth, ...)

	local s = select("#",...)
	--print("select# = " .. ColorText(0.5,0.5,1) .. s )

	for i = 1, s do

		local f = select(i,...)

		PrintChildFrame( f, depth+1 )

	end

end





---------------------------------------------------------------------------------------------------
------- Quests --- Quests --- Quests --- Quests --- Quests --- Quests --- Quests --- Quests -------
---------------------------------------------------------------------------------------------------




function DICQ(questid)

	-- remove all non-digit characters from string
	local numbersOnly = string.gsub(questid,"[^%d]","")

	return DidICompleteQuest(numbersOnly)
end

function DidICompleteQuest(questid)

	local questid = tonumber(questid)

	local questtable = { GetQuestsCompleted() }

	--print(type(questtable))

	if questid then
		print("Looking for Quest ID: " .. ColorText(0.5,0.5,1) .. questid)

		for key1,value1 in pairs(questtable) do
			--print( "key1 " .. key1 )
			for key2,value2 in pairs(value1) do
				--print("key2 " ..key2)

				if key2 == questid then
					print("Quest Completed: " .. ColorText(0.5,1,0.5).. key2)
					return true
				end

			end
		end

		print("Quest Not found: " .. ColorText(1,0.5,0.5).. tostring(questid))

	else

		print("Displaying All Quests:")

		local questCount = 0

		local bigstring = ""

		for key1,value1 in pairs(questtable) do
			for key2,value2 in pairs(value1) do
				--print(key2)

				bigstring = bigstring .. " " .. key2

				if string.len(bigstring) > 255 then
					print(bigstring)
					bigstring = ""
				end

				questCount = 1 + questCount

			end
		end

		print( bigstring )

		print("Number Quests Completed: " .. ColorText(0.5,0.5,1) .. questCount)

	end

	ScrollToBottom()

end



--[[

#showtooltip Healing Wave
/script UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
/cast reinforce
/cast empower
/script UIErrorsFrame:RegisterEvent("UI_ERROR_MESSAGE")
/cast healing wave
]]--


function shareAllQuests(delay)
	delay = delay or 0.075

	print(ColorText(255,102,0).."Sharing All Quests...")

	local questGreenRange = UnitLevel("player") - GetQuestGreenRange()

	local questTable = {}

	local i = 1;
	while true do

		if GetQuestLogTitle(i)==nil then
			break
		end

		local title, level, tag, header = GetQuestLogTitle(i);

		if not header and level >= questGreenRange then

			SelectQuestLogEntry(i);

			if GetQuestLogPushable() then
				table.insert(questTable, {i,level,title} )
				--print(i .. "  " .. level .. "  " .. title)
			end

		end

		i = i + 1;
	end


	local function compare(a,b)
		return a[2] > b[2]
	end

	table.sort(questTable,compare)

	local j = 0
	for key,value in pairs(questTable) do
		local v_i = value[1]
		local v_level = value[2]
		local v_title = value[3]

		local title, level, tag, header = GetQuestLogTitle(v_i);

		print("  " .. v_level .. "  " .. v_title )

		local function delayShareQuest()
			SelectQuestLogEntry(v_i);
			QuestLogPushQuest();
		end

		oom__wait(j,delayShareQuest)
		j = delay + j
	end

	ScrollToBottom()

end

shareallquests = shareAllQuests


---- /run ListQuestsByLevel()
function ListQuestsByLevel()
    print(ColorText('orange') .."Quests by Level:")
    local data = {}
    local keys = {}

    local questIndex = 1
    local lastHeader = nil
    while GetQuestLogTitle(questIndex) do
        local questTitle, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isStory, isHidden = GetQuestLogTitle(questIndex)

        if isHeader then
            lastHeader = questTitle
            --print(lastHeader)
        else
            local fuzzyLevel = tonumber(level + suggestedGroup / 1000)
            if not data[fuzzyLevel] then
                data[fuzzyLevel] = {}
            end

            local questObject = {}
            questObject['questTitle'] = questTitle
            questObject['level'] = level
            questObject['suggestedGroup'] = suggestedGroup
            questObject['header'] = lastHeader

            table.insert(data[fuzzyLevel],questObject)
            keys[fuzzyLevel] = true

            --DEFAULT_CHAT_FRAME:AddMessage(questTitle .. " [" .. level .. "] " .. questID)
            -- tprint(questObject)
        end

        questIndex = questIndex + 1
    end

    local levels = {}

    for k,v in pairs(keys) do
        table.insert(levels,k)
    end

    table.sort(levels,function(a,b) return a>b end)

    ----tprint(levels)

    for k1,lvl in pairs(levels) do
        local color = GetQuestDifficultyColor(lvl)

        print(ColorText(color.r,color.g,color.b) .. "Level: " .. ColorText(200,200,200) .. lvl)

        for k2,questObj in pairs(data[lvl]) do
            local questTitle = questObj['questTitle']
            local header = questObj['header']
            print(ColorText(color.r,color.g,color.b) .. '  ' .. questTitle .. "  " .. ColorText(200,200,200) .. header)
        end
    end
end



---------------------------------------------------------------------------------------------------
--------- Mount Speed ---- Mount Speed ---- Mount Speed ---- Mount Speed ---- Mount Speed ---------
---------------------------------------------------------------------------------------------------


function GetMountSpeed()

    if GetSpellInfo("Flight Master's License") then
        Flight_Masters_License = "Flight Master's License"
    end

    if GetSpellInfo("Cold Weather Flying") then
        Cold_Weather_Flying = "Cold Weather Flying"
    end

    if GetSpellInfo("Wisdom of the Four Winds") or GetSpellInfo("Grimoire of the Four Winds") then
        Wisdom_of_the_Four_Winds = "Wisdom of the Four Winds"
    end

    maxRiding = nil

    if GetSpellInfo("Master Riding") then
        maxRiding = "Master Riding"
    elseif GetSpellInfo("Artisan Riding") then
        maxRiding = "Artisan Riding"
    elseif GetSpellInfo("Expert Riding") then
        maxRiding = "Expert Riding"
    elseif GetSpellInfo("Journeyman Riding") then
        maxRiding = "Journeyman Riding"
    elseif GetSpellInfo("Apprentice Riding") then
        maxRiding = "Apprentice Riding"
    else
        maxRiding = nil
    end

    return maxRiding, Flight_Masters_License, Cold_Weather_Flying, Wisdom_of_the_Four_Winds
end



---------------------------------------------------------------------------------------------------
------- Macros --- Macros --- Macros --- Macros --- Macros --- Macros --- Macros --- Macros -------
---------------------------------------------------------------------------------------------------

function HasStealableBuffs()
    return table.getn( StealableBuffs() ) >0
end

function StealableBuffs()
    ---- /run tprint( StealableBuffs() )
    if not UnitExists("target") then
        return {}
    end

    local function BuffIndexData(i)
        local buffName, _, _, _, _, _, expireTime, _, isStealable = UnitAura("target", i, "HELPFUL")
        return buffName, expireTime, isStealable
    end

    local i = 1
    local stealableBuffs = {}
    local buffName, expireTime, isStealable = BuffIndexData(i)

    local function round(num, idp)
        local mult = 10^(idp or 0)
        return math.floor(num * mult + 0.5) / mult
    end

    while buffName do
        if (isStealable == true) then
            if (expireTime) then
                expireTime = round(expireTime - time(),1)
                if (expireTime > 60) then
                    expireTime = ""
                else
                    expireTime = expireTime .. "s"
                end
            end
            table.insert(stealableBuffs,buffName .. " " .. expireTime)
        end
        i = i + 1
        buffName, expireTime, isStealable = BuffIndexData(i)
    end

    return stealableBuffs
end




---------------------------------------------------------------------------------------------------
------- Notes & TODO ---- Notes & TODO ---- Notes & TODO ---- Notes & TODO ---- Notes & TODO ------
---------------------------------------------------------------------------------------------------


-- fix "escape key" to exit cinematic
-- list gear by ilvl



-- share all quests (share highest lvl first) (bonus to group quests?)



-- BattleGround assist add-on

-- add slash commands for listgear and shareallquests functions

-- add ignore list for shareAllQuests


-- fading chat text duration visible time delay chatframe
-- Chat frame : SetFadeDuration
-- Chat frame : SetTimeVisible


