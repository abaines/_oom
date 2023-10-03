

function logic1(argString)

	if true then
		return false
	end

	if strfind( argString , "SPELL_CAST_FAILED" ) then
		-- continue
	elseif strfind( argString , "SPELL_INTERRUPT" ) then
		-- continue
	elseif strfind( argString , "UNIT_SPELLCAST_INTERRUPTED" ) then
		-- continue
	else
		-- did not find something important, so we exit
		return
	end

	if strfind( argString , "Not yet recovered" ) then
		return
	elseif strfind( argString , "Another action is in progress" ) then
		return
	elseif strfind( argString , "Can't do that while moving" ) then
		return
	elseif strfind( argString , "No target" ) then
		return
	elseif strfind( argString , "Invalid target" ) then
		return
	elseif strfind( argString , "You are mounted" ) then
		return
	elseif strfind( argString , "That ability requires combo points" ) then
		return
	elseif strfind( argString , "Not enough energy" ) then
		return
	elseif strfind( argString , "Not enough rage" ) then
		return
	elseif strfind( argString , "Not enough focus" ) then
		return
	elseif strfind( argString , "Target needs to be in front of you" ) then
		return
	end


	if strfind( argString , "Out of range" ) and not xtimer("EventFinder".."Out of range",2*60) then
		return
	elseif strfind( argString , "Target not in line of sight" ) and not xtimer("EventFinder".."Target not in line of sight",2*60) then
		return
	end

	return true
end



function logic2(argString)
	local lArgString = string.lower(argString)

	if true then
		return false
	end

	if not strfind( argString, "raid" ) then
		return false

	end

	if not strfind( argString, "UNIT_SPELLCAST_SUCCEEDED" ) then
		return false

	end

	if strfind( argString, "Love Ray" ) then
		return true

	end

	if strfind( argString, "Cascade of Roses" ) then
		return true

	end

	return false
end



function logic3(argString)
	local lArgString = string.lower(argString)
	if strfind(lArgString, "_BankerSearch" ) then
		--return true
	end
end



function logic4(argString)

	if true then
		return false
	end

	if not strfind( argString, "COMBAT_LOG_EVENT_UNFILTERED" ) then
		return false
	end
	if not strfind( argString, "SPELL_CAST_SUCCESS" ) then
		return false
	end

	if strfind(argString, "Path of Frost" ) then
		return true
	end
	if strfind(argString, "Horn of Winter" ) then
		return true
	end
	if strfind(argString, "Mark of the Wild" ) then
		return true
	end
	if strfind(argString, "Rejuvenation" ) then
		return true
	end
end


function logic5(argString)

	local lArgString = string.lower(argString)

	if strfind(argString, "astranaar") or strfind(argString, "whisperwind grove") or strfind(argString, "ramakhen") or strfind(argString, "gadgetzan") or strfind(argString, "lor'danel") or strfind(argString, "nighthaven") or strfind(argString, "feathermoon stronghold") or strfind(argString, "the crossroads") then
		return true
	end

	return false

end

function logic6(argString,event)
	local lArgString = string.lower(argString)

	if true then
		return false
	end

	if event=="AUCTION_HOUSE_NEW_RESULTS_RECEIVED" or event=="COMMODITY_SEARCH_RESULTS_UPDATED" or event=="ITEM_SEARCH_RESULTS_UPDATED" then
		return false
	end

	if strfind(lArgString,"auction") or strfind(lArgString,"result") or strfind(lArgString,"receiv") or strfind(lArgString,"new") then
		return true
	end
end




function EventFinder_OnEvent(self,event,...)
	if event=="COMBAT_LOG_EVENT" then
		--return
	elseif strfind( event, "CHAT_MSG_" ) and not strfind( event, "CHAT_MSG_ADDON" ) then
		--return
	end

	local argString = createColoredArgumentEventString(event,...)

    if strfind(argString, "_BankerSearch" ) then
        print(argString)
    end


---------------------------------------------------------------------------------------------------

	if false and strfind(event,"COMBAT_LOG_EVENT_") then

		if select(2,...) == "SPELL_CAST_SUCCESS" then

			local caster = select(5,...)
			local spell = select(13,...)
			local receiver = stringify( select(9,...) )

			print("caster="..caster.."  spell="..spell.."  receiver="..receiver)

		end

	end


	if event=="UNIT_SPELLCAST_SUCCEEDED" and "Love Ray"==stringify( select(2,...) ) then
		if strfind( stringify( select(1,...) ) , "raid" ) then
			local casterUnit = stringify( select(1,...) )

			local casterName = GetUnitName(casterUnit, true)

			print("LOVE RAY!! " .. ColorText(0,1,0) .. casterName .. ColorText() .. "  " .. argString)

			CycleRaidTargetMarker(casterUnit)

		end
	end


---------------------------------------------------------------------------------------------------
------ Logic --- Logic --- Logic --- Logic --- Logic --- Logic --- Logic --- Logic --- Logic ------
---------------------------------------------------------------------------------------------------

	local logicText = ""

	if logic1(argString) then
		logicText = ColorText(0,1,0) .. "1" .. ColorText() .. " "

	elseif logic2(argString) then
		logicText = ColorText(0,1,0) .. "2" .. ColorText() .. " "

	elseif logic3(argString) then
		logicText = ColorText(0,1,0) .. "3" .. ColorText() .. " "

	elseif logic4(argString) then
		logicText = ColorText(0,1,0) .. "4" .. ColorText() .. " "

	elseif logic5(argString) then
		logicText = ColorText(0,1,0) .. "5" .. ColorText() .. " "

	elseif logic6(argString,event) then
		logicText = ColorText(0,1,0) .. "6" .. ColorText() .. " "

	else
		return
	end


---------------------------------------------------------------------------------------------------


	if xtimer(argString,60) then
		--[[
		if EventFinder_OnEvent_SpamGuard() then
			return
		end
		]]--
		print(logicText .. argString)
	end
end







-- arg2 = SPELL_CAST_FAILED
-- arg2 = SPELL_INTERRUPT
-- UNIT_SPELLCAST_INTERRUPTED


function EventFinder_OnEvent_SpamGuard()

	local numberGuards = 10
	local guardResetTime = 120

	for i = 1, numberGuards do
		if xtimer( "EventFinder_OnEvent_SpamGuard"..i , guardResetTime+i) then
			return false
		end
	end

	return true
end













EventFinder_CinematicFrame_Hook = nil

function EventFinder_OnUpdate()
--[[
	if InCinematic() then

		if xtimer("InCinematic()",10) then
			print("InCinematic()")


			if false then
				StopCinematic()
				print("StopCinematic()")
			end

			if false and EventFinder_CinematicFrame_Hook~=nil then
				EventFinder_CinematicFrame_Hook.closeDialog:Show();
			end


		end

	end
]]--

	if superGuildBankTabCycle and xtimer("superGuildBankTabCycle",0.2) then
		cycleGuildBankTab()
	end

end


--[[
function CinematicFrame_OnKeyDown(self, key)
	print("CinematicFrame_OnKeyDown: " .. key)
    local keybind = GetBindingFromClick(key);
	if ( key == "ESCAPE" ) then
		if ( self.isRealCinematic and IsGMClient() ) then
            StopCinematic();
        elseif ( self.isRealCinematic or CanExitVehicle() or CanCancelScene() ) then    --If it's not a real cinematic, we can cancel it by leaving the vehicle.
            self.closeDialog:Show();
        end
    elseif ( keybind == "TOGGLEGAMEMENU" ) then
        if ( self.isRealCinematic and IsGMClient() ) then
            StopCinematic();
        elseif ( self.isRealCinematic or CanExitVehicle() or CanCancelScene() ) then    --If it's not a real cinematic, we can cancel it by leaving the vehicle.
            self.closeDialog:Show();
        end
    elseif ( keybind == "SCREENSHOT" or keybind == "TOGGLEMUSIC" or keybind == "TOGGLESOUND" ) then
        RunBinding(keybind);
    end
end
]]--




--[[
function CinematicOnShowHook(self, ...)
  print("CinematicOnShowHook",...)
  if IsModifierKeyDown() then return end
  --print("Cinematic Canceled.")
  --CinematicFrame_CancelCinematic()

  EventFinder_CinematicFrame_Hook = self

  --self.closeDialog:Show();
end


CinematicFrame:HookScript("OnShow", CinematicOnShowHook)

CinematicFrame:HookScript("OnKeyDown", CinematicFrame_OnKeyDown)
]]--

