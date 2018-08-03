-- UIErrorsFrame:AddMessage( "msg" ,0,1,.5,1,2)
-- string.find( UnitDebuff("target",i ), sDebuffName )
-- DEFAULT_CHAT_FRAME:AddMessage( "woot!" )




function EnteredCombat_OnLoad(...)
	EnteredCombatFrame:RegisterEvent("CHAT_MSG_SYSTEM");
	EnteredCombatFrame:RegisterEvent("CHAT_MSG_ADDON");
	
	EnteredCombatFrame:RegisterEvent("CHAT_MSG_PARTY");
	EnteredCombatFrame:RegisterEvent("CHAT_MSG_PARTY_LEADER");

	EnteredCombatFrame:RegisterEvent("CHAT_MSG_INSTANCE_CHAT");
	EnteredCombatFrame:RegisterEvent("CHAT_MSG_INSTANCE_CHAT_LEADER");

	t_EnteredCombat_OnLoad = time()
	DEFAULT_CHAT_FRAME:AddMessage("EnteredCombat_OnLoad()")
end


function EnteredCombat_OnEvent(self,event,...)
	arg1 = select(1,...)
	arg2 = select(2,...)
	arg3 = select(3,...)
	arg4 = select(4,...)
	arg5 = select(5,...)
	arg6 = select(6,...)
	arg7 = select(7,...)
	arg8 = select(8,...)
	arg9 = select(9,...)

	--print(event,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9)
    
    local function starts(String,Start)
        return string.sub(String,1,string.len(Start))==Start
    end
     
    if starts(event,"CHAT_MSG_PARTY") or starts(event,"CHAT_MSG_INSTANCE_CHAT") then
        parseChatMessageForEnterCombat(event,arg1,arg2)
    end
end

enterCombatSelfIncriminationTable = {}

-- /run tprint(enterCombatSelfIncriminationTable)

function parseChatMessageForEnterCombat(event,msg,speakerName)
    --print('parseChatMessageForEnterCombat',event,msg,speakerName)

    local simpleName, serverName = speakerName:match("([^-]+)-([^-]+)")
    
    --print("serverName",serverName,'simpleName',simpleName)
    
    local playerName = UnitName("player")
    
    if playerName==simpleName then
        --print('playerName',playerName)
        return
    end
    
    local role1 = UnitGroupRolesAssigned(simpleName);
    local role2 = UnitGroupRolesAssigned(speakerName);

    -------print('roles',role1,role2,'simpleName',simpleName,'serverName',serverName)
    
    enterCombatSelfIncriminationTable[speakerName] = enterCombatSelfIncriminationTable[speakerName] or 0
    --tprint(enterCombatSelfIncriminationTable)
    
    if msg==createEnterCombatChatMessage(simpleName,role1) then
        enterCombatSelfIncriminationTable[speakerName] = 16
        --print("role1")
    elseif msg==createEnterCombatChatMessage(simpleName,role2) then
        enterCombatSelfIncriminationTable[speakerName] = 16
        --print("role2")
    end
   
end




function EnteredCombat_OnUpdate(...)
	
	checkCombatState()
	
	checkZoneText()
	
end


function createEnterCombatChatMessage(who,role)
    return "Entered Combat: " .. who .. "  <" .. role .. ">"
end

g_lastCount_NumberPartyInCombat = -1

g_timeEnteredCombat = -1
g_timeExitedCombat = -1


function checkCombatState()

	numPartyInCombat, who = numberPartyInCombat()
	if ( g_lastCount_NumberPartyInCombat ~= numPartyInCombat ) then
		
		--print(numPartyInCombat)
		if g_lastCount_NumberPartyInCombat==0 and numPartyInCombat==1 then
			g_timeEnteredCombat = time()
			
			-- first to enter combat !
			role = UnitGroupRolesAssigned(who);
			--emsg = "Entered Combat: " .. who .. "  <" .. role .. ">"
            emsg = createEnterCombatChatMessage(who,role)
            
            enterCombatSelfIncriminationTable[who] = enterCombatSelfIncriminationTable[who] or 0
            --tprint(enterCombatSelfIncriminationTable)
			
			if GetNumMembers() <= 5 and "TANK"~=role and "NONE"~=role and xtimer("EnterCombat:"..emsg,30) then
                if enterCombatSelfIncriminationTable[who]<0 then
                    SendChatMessageInstance(emsg)
                end
                enterCombatSelfIncriminationTable[who] = enterCombatSelfIncriminationTable[who] - 1
			else
				print(emsg)
			end
            
            -------print(who)
            -------tprint(enterCombatSelfIncriminationTable)
			
		elseif g_lastCount_NumberPartyInCombat==0 and numPartyInCombat>=1 then
			g_timeEnteredCombat = time()
			print("Multiple Entered Combat: " .. numPartyInCombat)
			print(who)
			
		elseif numPartyInCombat==0 and g_lastCount_NumberPartyInCombat>0 then
			g_timeExitedCombat = time()
			
			t_combatDelta = g_timeExitedCombat - g_timeEnteredCombat 
			
			local groupLeavingCombatMsg = "Group Leaving Combat: " .. round(t_combatDelta,1) .. " seconds"
			if xtimer(groupLeavingCombatMsg,2) then
				print(groupLeavingCombatMsg)
			end
			
			AutoPartyRaidTargetMarkers()
			
		end
		
		g_lastCount_NumberPartyInCombat = numPartyInCombat
	end

end



g_zoneInfoText = nil

function checkZoneText()

	currentZoneInfo = zoneInfo()
	
	if not g_zoneInfoText or g_zoneInfoText~=currentZoneInfo then
		
		if xtimer("ZoneInfo:" .. currentZoneInfo,3*60) then
			--if currentZoneInfo~= "" .. " | " .. "" .. " | " .. "" then
			if currentZoneInfo~= " |  | " then
				print(currentZoneInfo)
			end
			g_zoneInfoText = currentZoneInfo
		end
		
	end

end

