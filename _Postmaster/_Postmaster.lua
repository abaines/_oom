
postmasterevents = false

function Postmaster_OnEvent(self,event,...)
	local argString = createColoredArgumentEventString(event,...)

	if not postmasterevents then
		return
	end

	if xtimer(argString,60) and ( xtimer("PM1",5) or xtimer("PM2",5) or xtimer("PM3",5) or xtimer("PM4",5) or xtimer("PM5",5) ) then
		print(argString)
	end
end






function Postmaster_OnUpdate()
end
