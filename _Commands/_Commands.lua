
function Commands_OnLoad(...)
	t_Commands_OnLoad = time()
	print("Commands_OnLoad()")
end


function Commands_OnEvent(self,event,...)
	print(event)
end


function Commands_OnUpdate(...)

end



--- make new slash command for reloading UI
SLASH_OOMADDONCOMMANDRELOADUI1 = '/reloadui';
SLASH_OOMADDONCOMMANDRELOADUI2 = '/rlui';
SLASH_OOMADDONCOMMANDRELOADUI3 = '/rlu';
function SlashCmdList.OOMADDONCOMMANDRELOADUI(msg, editbox)
	ReloadUI();
end



--- setup the various slash commands
SLASH_OOMADDONCOMMANDUNDERSCORE1 = '/_';
SLASH_OOMADDONCOMMANDUNDERSCORE2 = '/_oom';
function SlashCmdList.OOMADDONCOMMANDUNDERSCORE(msg, editbox)
	CommandHandler(msg,editbox,"UNDERSCORE")
end


SLASH_OOMADDONCOMMANDOOM1 = '/oom';
function SlashCmdList.OOMADDONCOMMANDOOM(msg, editbox)
	CommandHandler(msg,editbox,"OOM")
end

--[[
SLASH_OOMADDONCOMMANDK1 = '/k';
function SlashCmdList.OOMADDONCOMMANDK(msg, editbox)
	CommandHandler(msg,editbox,"K")
end
]]--



function CommandHandler(msg, editbox, source)
	local oom_help_display_string = "To get Help from _OOM Addon use: " .. ColorText("orange") .. "/oom help" .. ColorText()
	local oom_emote_display_string = "To preform OOM emote use: " .. ColorText("orange") .. "/oom emote" .. ColorText()

	local lmsg = string.lower(msg)

	local function cont(...)
		local fmsg = string.lower(lmsg)
		local count = 0

		for i = 1, select("#",...) do

			local carg = string.lower( select(i,...) )
			if strfind(lmsg,carg) then
				count = 1 + count
				fmsg = string.gsub(fmsg, carg, "")
			end

		end

		return count, fmsg
	end


	if source=="OOM" and ( lmsg=="emote" or lmsg=="doemote" or lmsg=="do emote") then
		DoEmoteOOM()
		return

	elseif source=="OOM" and ( lmsg=="" ) then
		print(oom_help_display_string .. "  " .. oom_emote_display_string)
		DoEmoteOOM()
		return

	end

	-- we are doing more than OOM emote, so we want to Scroll To Bottom
	ScrollToBottom()

	if ( strfind(lmsg,"help") ) then
		PrintOOMHelpSlashCommands(editbox)
		return
	end

	local pbg_count, pbg_final = cont("pet","battle","guide","counter")
	if pbg_count>=2 then
		displayPetBattleGuide(lmsg)
		return
	end


	if strfind(lmsg,"pet") and strfind(lmsg,"list") then
		scanBattlePets(true)
		return
	end

	if strfind(lmsg,"gear") then
		listgear()
		return
	end


	if strfind(lmsg,"quest") and strfind(lmsg,"share") then
		shareallquests()
		return
	end

	if strfind(lmsg,"quest") and ( strfind(lmsg,"?") or FindAnyDigit(lmsg) ) then
		DICQ(lmsg)
		return
	end

    if strfind(lmsg,"quest") and ( strfind(lmsg,"list") or strfind(lmsg,"level") or strfind(lmsg,"lvl") ) then
        ListQuestsByLevel()
        return
    end

    if strfind(lmsg,"dark") and strfind(lmsg,"moon") and ( strfind(lmsg,"storage") or strfind(lmsg,"box") or strfind(lmsg,"container") or strfind(lmsg,"bag") ) then
        DarkmoonStorageBox()
        return
    end


    if strfind(lmsg,"char") and ( strfind(lmsg,"list") or strfind(lmsg,"info") ) then
        DisplayCharacters()
        return
    end

    if strfind(lmsg,"char") and ( strfind(lmsg,"prof") or strfind(lmsg,"skill") ) then
        DisplayProfessions()
        return
    end

	if strfind(lmsg,"gold") or strfind(lmsg,"money") then
		DisplayCharacterGold()
		return
	end


	if strfind(lmsg,"soulbound") or strfind(lmsg,"soul bound") then
		global_oom_soulbound_hooker_toggle = not global_oom_soulbound_hooker_toggle
		print('Soulbound hiding is ' .. (global_oom_soulbound_hooker_toggle and (ColorText(0,1,0)..'enabled') or (ColorText(1,0,0)..'disabled'))..ColorText().."." )
		return
	end



	--[[
	local contains_pet = strfind(lmsg,"pet")
	local contains_battle = strfind(lmsg,"battle")
	local contains_guide = strfind(lmsg,"guide")

	print(contains_pet)
	print(contains_battle)
	print(contains_guide)

	cont("hello world")

	print( cont("pet","battle","guide") )
	]]--


	if ( strfind(lmsg,"?") or strfind(lmsg,"help") ) then
		PrintOOMHelpSlashCommands(editbox)
		return
	end
	print("OOM Command Not Found: " .. ColorText('orange') .. lmsg)
	print(oom_help_display_string)
end


function FindAnyDigit(text)
    if ( strfind(text,"0") or strfind(text,"1") or strfind(text,"2") or strfind(text,"3") or strfind(text,"4") or strfind(text,"5") or strfind(text,"6") or strfind(text,"7") or strfind(text,"8") or strfind(text,"9") ) then
		return true
    else
        return false
	end
end


function PrintOOMHelpSlashCommands(topic)

	print("Listed below are list of "..ColorText("orange") .. "/oom" .. ColorText() .." slash commands:")

	print("  " .. ColorText("orange") .. "/oom emote " .. ColorText() .." perform OOM emote")

	print("  " .. ColorText("orange") .. "/oom pet battle guide " .. ColorText(1,0,0) .. "<type>" .. ColorText() .." displays which pets types do wells against others")
	print("  " .. ColorText("orange") .. "/oom list pets " .. ColorText() .." displays overpopulated pets (aka pets you have three or more of)")

	print("  " .. ColorText("orange") .. "/rlui " .. ColorText() .." shortcut for /reload ui")

	print("  " .. ColorText("orange") .. "/oom gear " .. ColorText() .." displays gear sorted by ilevel")

	print("  " .. ColorText("orange") .. "/oom share quest " .. ColorText() .." shares all of your quest with party")
	print("  " .. ColorText("orange") .. "/oom quest " .. ColorText(1,0,0) .. "<questID>" .. ColorText("orange") .. " ?" .. ColorText() .." displays status of if you completed that quest")

    print("  " .. ColorText("orange") .. "/oom darkmoon bag " .. ColorText() .." lists all characters without Darkmoon Storage Box")

	print("  " .. ColorText("orange") .. "/banker " .. ColorText(1,0,0) .. "<search>" .. ColorText() .." scan banker information for items matching search")

	print("  " .. ColorText("orange") .. "/oom soulbound " .. ColorText() .." toggle soulbound search overlay always (not just mailbox)")

	ScrollToBottom()
end









---------------------------------------------------------------------------------------------------
-------- Macro Spam Prevention ------- Macro Spam Prevention ------- Macro Spam Prevention --------
---------------------------------------------------------------------------------------------------


--- UI Error Messages Off
SLASH_OOMADDONUIERRORMESSAGEOFF1 = '/urm_off';
SLASH_OOMADDONUIERRORMESSAGEOFF2 = '/uem_off';
function SlashCmdList.OOMADDONUIERRORMESSAGEOFF(msg, editbox)
	UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
end



--- UI Error Messages On
SLASH_OOMADDONUIERRORMESSAGEON1 = '/urm_on';
SLASH_OOMADDONUIERRORMESSAGEON2 = '/uem_on';
function SlashCmdList.OOMADDONUIERRORMESSAGEON(msg, editbox)
	UIErrorsFrame:RegisterEvent("UI_ERROR_MESSAGE")
end

--[[

#showtooltip Healing Wave
/script UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")
/cast reinforce
/cast empower
/script UIErrorsFrame:RegisterEvent("UI_ERROR_MESSAGE")
/cast healing wave
]]--


SLASH_OOMADDONAUTOSHIFTOFF1 = '/as_off';
function SlashCmdList.OOMADDONAUTOSHIFTOFF(msg, editbox)
	SetCVar("autoUnshift",0)
end

SLASH_OOMADDONAUTOSHIFTON1 = '/as_on';
function SlashCmdList.OOMADDONAUTOSHIFTON(msg, editbox)
	SetCVar("autoUnshift",1)
end








---------------------------------------------------------------------------------------------------
------- Soulbound ------- Soulbound ------- Soulbound -------- Soulbound -------- Soulbound -------
---------------------------------------------------------------------------------------------------

global_oom_soulbound_hooker_toggle = false

-- semlar https://www.wowinterface.com/forums/showpost.php?s=dc51a67b7426c67a157da8004ba9e131&p=303943&postcount=5

local function OOMADDON_SOULBOUND_HOOKER()
	local tip = CreateFrame('GameTooltip', 'MailBagScantip', nil, 'GameTooltipTemplate')

	local function scanTipForSoulbound(bag,name,index)
		local nameItemJ = name .. 'Item' .. index
		local itemButton = _G[nameItemJ]
		--print(bag,name,index,nameItemJ,itemButton)
		local slot = itemButton:GetID()
		tip:SetOwner(UIParent,'ANCHOR_NONE')
		tip:SetBagItem(bag, slot)

		local MerchantFrameVisible = MerchantFrame and MerchantFrame:IsVisible()
		local AuctionHouseFrameVisible = AuctionHouseFrame and AuctionHouseFrame:IsVisible()
		local MailFrameVisible = SendMailFrame:IsVisible() or MailFrame:IsVisible()
		if MailFrameVisible or global_oom_soulbound_hooker_toggle or MerchantFrameVisible or AuctionHouseFrameVisible then
			for t = 1, tip:NumLines() do
				local str = _G['MailBagScantipTextLeft' .. t]
				if str and (str:GetText() == ITEM_SOULBOUND or str:GetText() == ITEM_BIND_QUEST) then
					itemButton.searchOverlay:Show()
					return
				end
			end
		end
		itemButton.searchOverlay:Hide()
	end

	local function scannerUpdate(frame)
		--print("scannerUpdate  ".. frame.size .. "  " .. tostring(SendMailFrame:IsVisible()))
		local name, bag = frame:GetName(), frame:GetID()
		for index = 1, frame.size do
			scanTipForSoulbound(bag,name,index)
		end
	end

	local function scannerUpdateCombinedBagSlot(bagID,slotID,numberOfSlots,featureEnabled, invert)
		local inventoryObj = createInventoryObject(bagID, slotID);
		local isBound = inventoryObj['isBound']

		-- TODO figure out how 2FA bag locks affect logic
		if bagID==0 then
			slotOffset = 5
		else
			slotOffset = 1
		end
		local itemFrameName = "ContainerFrame" .. (bagID+1) .. "Item" .. (numberOfSlots-slotID+slotOffset)

		local itemFrameButton = _G[itemFrameName]

		--print(bagID, slotID, inventoryObj['itemLink'], inventoryObj['isBound'], itemFrameButton)

		if not itemFrameButton then
			print(bagID, slotID, inventoryObj['itemLink'])
			return
		end

		if not featureEnabled then
			itemFrameButton.searchOverlay:Hide()
			return
		end

		if not inventoryObj or not inventoryObj['itemLink'] then
			itemFrameButton.searchOverlay:Hide()
			return
		end

		local function inverter(_show)
			if _show then
				itemFrameButton.searchOverlay:Show()
			else
				itemFrameButton.searchOverlay:Hide()
			end
		end

		if isBound then
			inverter(not invert)
		else
			inverter(invert)
		end
	end

	local function scannerUpdateCombined(frame)
		local SMFV = ScrappingMachineFrame and ScrappingMachineFrame:IsVisible()
		local AHFV = AuctionHouseFrame and AuctionHouseFrame:IsVisible()
		local MerchantFrameVisible = MerchantFrame and MerchantFrame:IsVisible()
		local MailFrameVisible = SendMailFrame:IsVisible() or MailFrame:IsVisible()
		local featureEnabled = SMFV or MailFrameVisible or global_oom_soulbound_hooker_toggle or AHFV or MerchantFrameVisible
		local frameName, frameID = frame:GetName(), frame:GetID()
		local invert = SMFV
		--print("scannerUpdateCombined()",frameName,frameID)

		-- character inventory
		for bagID = 0, NUM_BAG_SLOTS do
			local numberOfSlots = C_Container.GetContainerNumSlots(bagID);
			for slotID = 1, numberOfSlots do
				scannerUpdateCombinedBagSlot(bagID,slotID,numberOfSlots,featureEnabled, invert)
			end
		end
	end

	local function setupHookForSoulbound()

		if not UIParent or not UIParent.ContainerFrames then
			print("MISSING UIParent.ContainerFrames !")
			return
		end
		if not global_oom_soulbound_Hook_Hooked then

			hooksecurefunc(ContainerFrameCombinedBags, "UpdateItems", scannerUpdateCombined)

			for _, containerFrame in ipairs(UIParent.ContainerFrames) do
				hooksecurefunc(containerFrame, "UpdateItems", scannerUpdate)
			end

			global_oom_soulbound_Hook_Hooked = true
		end
	end

	setupHookForSoulbound()

end

OOMADDON_SOULBOUND_HOOKER()

