
function Holiday_OnLoad(...)
    t_Holiday_OnLoad = time()

    HolidayFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
    HolidayFrame:RegisterEvent("PLAYER_TARGET_CHANGED")

    print("Holiday_OnLoad()")
end


function Holiday_OnEvent(self,event,...)
	arg1 = select(1,...)
	arg2 = select(2,...)
	arg3 = select(3,...)
	arg4 = select(4,...)
	arg5 = select(5,...)
	arg6 = select(6,...)
	arg7 = select(7,...)
	arg8 = select(8,...)
	arg9 = select(9,...)

    
	if (event == "UPDATE_MOUSEOVER_UNIT") then
		checkUnit("mouseover")
	end
	if (event == "PLAYER_TARGET_CHANGED") then
		checkUnit("target")
	end
end

function checkUnit(unit)
    local racesToIcon = {
        draenei=1,
        dwarf=2,
        gnome=3,
        human=4,
        nightelf=5,
        worgen=6,
        bloodelf=1,
        goblin=2,
        orc=3,
        tauren=4,
        troll=5,
        scourge=6
    }

    local guid = UnitGUID(unit)
    if guid==nil then
        return
    end
    
    local name = UnitName(unit)
    if name==nil then
        return
    end

    local locClass, engClass, locRace, engRace, gender = GetPlayerInfoByGUID(guid)
    if engClass==nil or engRace==nil or gender==nil then
        return
    end

    local class = string.lower(engClass)
    if class=='rogue' then
        local race = string.lower(engRace)
        local iconToUse = racesToIcon[race]

        if not iconToUse and xtimer("TurkeyLurkey-iconToUse-error"..iconToUse,60*60) then
            -- print("! " .. race)
            return
        end
        
        if xtimer("TurkeyLurkey"..name..class..race,60) then
            print(name,class,race)
        end
        
        local currTargetIcon = GetRaidTargetIndex(unit)
        if currTargetIcon ~= iconToUse then
            SetRaidTargetIcon(unit,iconToUse)
        end
    end
end


function Holiday_OnUpdate(...)

end
