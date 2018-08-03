-- UIErrorsFrame:AddMessage( "msg" ,0,1,.5,1,2)
-- string.find( UnitDebuff("target",i ), sDebuffName )
-- DEFAULT_CHAT_FRAME:AddMessage( "woot!" )


local EscKeyOrangeText = ColorText("Orange") .. "Esc Key" .. ColorText()

function Esc_OnUpdate(arg1)
	if t_EscKeyLoaded then
		return
	end
	
	if UnitAffectingCombat("player") then
		t_UnitAffectingCombatPlayer = time()
		return
		
	elseif t_UnitAffectingCombatPlayer and time()-t_UnitAffectingCombatPlayer < 2 then
		return
		
	else
		SetBindingClick("ESCAPE","CLEARTARGET")
		-- (0,0.5,1)
		
		ChatFrame1:SetFadeDuration(600)
		ChatFrame2:SetFadeDuration(600)
		ChatFrame3:SetFadeDuration(600)
		ChatFrame4:SetFadeDuration(600)
		
		print(" Your " .. EscKeyOrangeText .. " is now \195\156ber! ")
		t_EscKeyLoaded = time()
		
	end
end





function Esc_CinematicFrame_Hook_OnKeyDown(self, key)
	--print("Esc_CinematicFrame_Hook_OnKeyDown: " .. key)
	--local keybind = GetBindingFromClick(key);
	
	if ( key == "ESCAPE" ) then
		if xtimer("Esc_CinematicFrame_Hook_OnKeyDown_Double",0.1) then
			print( "Detected " .. EscKeyOrangeText .. " during Cinematic." )
		end
		if ( self.isRealCinematic and IsGMClient() ) then
			StopCinematic();
			return
		elseif ( self.isRealCinematic or CanExitVehicle() or CanCancelScene() ) then    --If it's not a real cinematic, we can cancel it by leaving the vehicle.
			self.closeDialog:Show();
			return
		end
	end
end

CinematicFrame:HookScript("OnKeyDown", Esc_CinematicFrame_Hook_OnKeyDown)


