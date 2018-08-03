
function FriendsWithBenefits_OnLoad(...)
	t_Template_OnLoad = time()
    FriendsWithBenefitsFrame:RegisterEvent("UNIT_SPELLCAST_START");
	print("FriendsWithBenefits_OnLoad()")
end


function FriendsWithBenefits_OnEvent(self,event,...)
	arg1 = select(1,...)
	arg2 = select(2,...)
	arg3 = select(3,...)
	arg4 = select(4,...)
	arg5 = select(5,...)
	arg6 = select(6,...)
	arg7 = select(7,...)
	arg8 = select(8,...)
	arg9 = select(9,...)
    
    if event=="UNIT_SPELLCAST_START" then
        -- multi person mount emote logic
        local function IsMultiPersonMount(val)
            -- list of multi person passanger mounts
            local listOfMultiPersonMounts = {
                "Obsidian Nightwing",
                "Traveler's Tundra Mammoth"
            }
            
            for i=1,#listOfMultiPersonMounts do
                if listOfMultiPersonMounts[i] == val then 
                    return true
                end
            end
            return false
        end

        if arg1 == "player" and IsMultiPersonMount(arg2) then
            randomMountEmote()
        end
    
    end
    
	--print(event)
end

recentMountEmotes = {
"","","","",
}

function randomMountEmote()
    -- list of emotes to do
    local mountEmotes = {
        "TRAIN",
        "BECKON",
        "BOUNCE",
        "CHARGE",
        "TRAIN",
        "CHICKEN",
        "FOLLOW",
        "MOO",
        "PURR",
        "TRAIN",
    }
    
    local lastEmotes = {}
    
    --print("Random Mount Emote")
    
    -- 0,1,2,3 is length 4
    for i=0,3 do
        lastEmote = recentMountEmotes[#recentMountEmotes-i]
        table.insert(lastEmotes,lastEmote)
    end
    
    -- subtract tables
    local function array_sub(t1, t2)
        local t = {}
        for i = 1, #t1 do
            t[t1[i]] = true;
        end
        local removeCount = 0
        for i = #t2, 1, -1 do
            if t[t2[i]] and removeCount==0 then
                table.remove(t2, i);
                removeCount = 1 + removeCount
                --continue
            end
        end
    end
    
    array_sub(lastEmotes,mountEmotes)
    
    --tprint(mountEmotes)
    
    rme = mountEmotes[ math.random( #mountEmotes ) ]
    
    table.insert(recentMountEmotes,rme)
    
    DoEmote(rme,"player")
end



function FriendsWithBenefits_OnUpdate(...)

end



function FriendKizraksCharacters()

    AddFriend("Rowyl-Medivh") -- druid
    AddFriend("Hokiê-Medivh") -- deathknight
    AddFriend("Hokiè-Medivh") -- priest
    AddFriend("Yobyeknom-Medivh") -- monk
    AddFriend("Kizrak-Medivh") -- warrior
    AddFriend("Hokie-Medivh") -- paladin
    AddFriend("Hokië-Medivh") -- hunter
    AddFriend("Greengear-Medivh")
    AddFriend("Sellbot-Medivh")
    AddFriend("Xkq-Medivh") -- priest
    AddFriend("Hokîe-Medivh") -- demonhunter

    AddFriend("Materials-Exodar")
    AddFriend("Fixmailbox-Exodar") -- monk
    AddFriend("Hokié-Exodar") -- priest
    AddFriend("Hokiê-Exodar") -- deathknight
    AddFriend("Hokíe-Exodar") -- shaman
    
    AddFriend("Darlane-Whisperwind")
    AddFriend("Ferringhi-Whisperwind") -- hunter
    AddFriend("Protector-Whisperwind") -- paladin
    AddFriend("Solusek-Whisperwind") -- mage
    AddFriend("Derringer-Whisperwind") -- hunter
    AddFriend("Etrade-Whisperwind") -- hunter
    AddFriend("Moospace-Whisperwind")
    AddFriend("Hokie-Whisperwind") -- demonhunter
    
end

