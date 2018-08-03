
function CannotHeal_OnLoad(...)
	t_CannotHeal_OnLoad = time()
	print("CannotHeal_OnLoad()")
end


function CannotHeal_OnEvent(self,event,...)
	print(event)
end



function CannotHeal_OnUpdate(...)
	local role = UnitGroupRolesAssigned("player");
	
	if LossOfControlFrameIsVisible() and role~="TANK" and role~="DAMAGER" then
		if xtimer("LossOfControlFrameIsVisible"..tostring(LossOfControlFrame.startTime).."_"..tostring(LossOfControlFrame.spellID),60*60) then
		
			local msgString = "I cannot Heal because of " .. GetSpellLink(LossOfControlFrame.spellID) .. " for <" .. round(tonumber(LossOfControlFrame.TimeLeft.timeRemaining),1) .." seconds>" 
			
			if xtimer("CannotHeal_SpamGuard",1) then
				SendChatMessageInstance(msgString)
			else
				print(msgString)
			end
		end
		
		if xtimer("LossOfControlFrameIsVisible",1) then
			--printLossOfControlFrameStatus()
		end
	end

end

function printLossOfControlFrameStatus()
	print( ColorText(1,0.5,0) .. LossOfControlFrame:GetName() .. "  " .. ColorText() .. stringify(LossOfControlFrame:IsVisible()) )
	tprint( LossOfControlFrame )
	print( LossOfControlFrame.spellID )
	print( LossOfControlFrame.TimeLeft.timeRemaining )
	print( LossOfControlFrame.startTime )
	local name, rank, icon, castTime, minRange, maxRange = GetSpellInfo( LossOfControlFrame.spellID )
	print( name )
	
	
	--print( LossOfControlFrame:IsVisible() )
	--print( select(1,LossOfControlFrame:GetChildren() ) )
	--print( select(2,LossOfControlFrame:GetChildren() ):IsVisible() )
end
