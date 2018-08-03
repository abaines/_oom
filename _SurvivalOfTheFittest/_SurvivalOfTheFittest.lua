
function SurvivalOfTheFittest_OnLoad(...)
	SurvivalOfTheFittestFrame:RegisterEvent("PET_BATTLE_CAPTURED")
	--SurvivalOfTheFittestFrame:RegisterEvent("PET_BATTLE_FINAL_ROUND")
	--SurvivalOfTheFittestFrame:RegisterEvent("PET_BATTLE_OVER")
	SurvivalOfTheFittestFrame:RegisterEvent("PET_BATTLE_CLOSE")
	SurvivalOfTheFittestFrame:RegisterEvent("CHAT_MSG_SYSTEM")

	t_SurvivalOfTheFittest_OnLoad = time()
	print("SurvivalOfTheFittest_OnLoad()")
end


function SurvivalOfTheFittest_OnEvent(self,event,...)

	if event=="PET_BATTLE_CAPTURED" then
		t_PET_BATTLE_CAPTURED = time()
		
	elseif event=="CHAT_MSG_SYSTEM" and strfind(select(1,...),"has been added to your pet journal") and xtimer("scanBattlePets",10) then
		--scanBattlePets(true,false)
		t_schedule_scanBattlePets = time()
		
	elseif event=="PET_BATTLE_CLOSE" and ( not t_PET_BATTLE_CAPTURED or time()-t_PET_BATTLE_CAPTURED > 15 )  and xtimer("scanBattlePets",10) then
		scanBattlePets(true,false)

	end
end


function SurvivalOfTheFittest_OnUpdate(...)

	if t_schedule_scanBattlePets and time()-t_schedule_scanBattlePets>0.15 then
		scanBattlePets(true,false)
		t_schedule_scanBattlePets = false

	elseif UnitCreatureType("target")=="Wild Pet" and not GetRaidTargetIndex("target") and xtimer("RandomMarkCritters",10) then
		xtarget(math.random(1,6))
	end
	
end


