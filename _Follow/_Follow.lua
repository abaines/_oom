-- UIErrorsFrame:AddMessage( "msg" ,0,1,.5,1,2)
-- string.find( UnitDebuff("target",i ), sDebuffName )



function Follow_OnLoad()

	FollowFrame:RegisterEvent("PARTY_INVITE_REQUEST");
	FollowFrame:RegisterEvent("CHAT_MSG_SYSTEM");
	FollowFrame:RegisterEvent("CHAT_MSG_ADDON");

	FollowFrame:RegisterEvent("CHAT_MSG_WHISPER");
	FollowFrame:RegisterEvent("CHAT_MSG_SAY");

	FollowFrame:RegisterEvent("CHAT_MSG_PARTY");
	FollowFrame:RegisterEvent("CHAT_MSG_PARTY_LEADER");

	FollowFrame:RegisterEvent("CHAT_MSG_RAID");
	FollowFrame:RegisterEvent("CHAT_MSG_RAID_LEADER");

	FollowFrame:RegisterEvent("CHAT_MSG_INSTANCE_CHAT");
	FollowFrame:RegisterEvent("CHAT_MSG_INSTANCE_CHAT_LEADER");

	FollowFrame:RegisterEvent("CHAT_MSG");
	FollowFrame:RegisterEvent("CHAT_MSG_CHANNEL");

	DEFAULT_CHAT_FRAME:AddMessage("Follow_OnLoad()")
end





function Follow_OnEvent(self,event,...)

	if ( event=="CHAT_MSG_SYSTEM" or event=="PARTY_INVITE_REQUEST" or event=="CHAT_MSG_ADDON" ) then
		Event_AutoInviteParse(event,...)

	elseif ( event=="CHAT_MSG_WHISPER" ) then
		Event_ChatWhisper(arg1,arg2)

	elseif ( event=="CHAT_MSG_PARTY" or event=="CHAT_MSG_PARTY_LEADER" ) then
		Event_ChatWhisper(arg1,arg2)

	elseif ( event=="CHAT_MSG_RAID" or event=="CHAT_MSG_RAID_LEADER" ) then
		Event_ChatWhisper(arg1,arg2)

	elseif ( event=="CHAT_MSG_INSTANCE_CHAT" or event=="CHAT_MSG_INSTANCE_CHAT_LEADER" ) then
		Event_ChatWhisper(arg1,arg2)

	end

end



function Event_ChatWhisper(msg,sender)
	if not msg then
		return
	end

	local msg = strlower(msg)

	if string.find(msg,"#") and string.find(msg,"follow") and sender~=UnitName("player") then
		local dashIndex = string.find(sender,"-")
		local senderNameWithoutServer = string.sub(sender, 0, dashIndex-1)

		DEFAULT_CHAT_FRAME:AddMessage("Automatically Following: " .. senderNameWithoutServer)

		FollowUnit(senderNameWithoutServer)
	end

	if string.find(msg,"#") and string.find(msg,"ping") and sender~=UnitName("player") then
		SendChatMessage("#pong","WHISPER",nil,sender)
	end

  ScrollToBottom()
end




-- API_HOOK_INVITE
function hookInviteUnit(playerName)
	if playerName and xtimer("hookInviteUnit_broadcast:"..playerName,1.5) then
		Event_AutoInviteParse("API_HOOK_INVITE",playerName)
	end
end

hooksecurefunc("InviteUnit", hookInviteUnit)





function Event_AutoInviteParse(event,...)

    if true then
        -- this is active development code
        return
    end

	local argString = createColoredArgumentEventString(event,...)

	local lArgStr = string.lower( argString )

	if strfind( lArgStr , "group" ) or strfind( lArgStr , "invite" ) or strfind( lArgStr , "inviti" ) then
		if xtimer("group|invite|invit",120) then
			print(argString)
		end
	elseif xtimer("Event_AutoInviteParse_Freebie1",120) then
		print(argString)
	elseif xtimer("Event_AutoInviteParse_Freebie2",120) then
		print(argString)
	end


	-- SendAddonMessage("_Invite",playerName,"RAID")

end



