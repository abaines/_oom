


-- create our OOMSoulboundScanningTooltip for scanning for soulbound-ness of items
CreateFrame( "GameTooltip", "OOMSoulboundScanningTooltip", nil, "GameTooltipTemplate" );
OOMSoulboundScanningTooltip:SetOwner( WorldFrame, "ANCHOR_NONE" );
OOMSoulboundScanningTooltip:AddFontStrings(
	OOMSoulboundScanningTooltip:CreateFontString( "$parentTextLeft1", nil, "GameTooltipText" ),
	OOMSoulboundScanningTooltip:CreateFontString( "$parentTextRight1", nil, "GameTooltipText" )
);



function is_soulbound_item(bagID,slotID,dbug)
	if not GetContainerItemLink(bagID, slotID) then
		return
	end

	if dbug then
		print(GetContainerItemLink(bagID, slotID))
	end

	OOMSoulboundScanningTooltip:SetOwner(UIParent,"ANCHOR_NONE")
	OOMSoulboundScanningTooltip:ClearLines()
	OOMSoulboundScanningTooltip:SetBagItem(bagID, slotID)
	--[[
	local status, err = pcall( OOMSoulboundScanningTooltip:SetBagItem(bagID, slotID) )
	if status then
		-- all good
	else
		-- SetBagItem raised an error !
		print("ERROR",bagID,slotID,err)
		return
	end
	]]--

	if dbug then
		print( "OOMSoulboundScanningTooltip:NumLines() ", OOMSoulboundScanningTooltip:NumLines() )
	end

	for i=2, OOMSoulboundScanningTooltip:NumLines() do
		local left = _G["OOMSoulboundScanningTooltipTextLeft"..i]
		local right = _G["OOMSoulboundScanningTooltipTextRight"..i]

		if dbug then
			print(i,left:GetText())
			if right and right:GetText() then
				print(i,right:GetText())
			end
		end

		if left and left:GetText() then
			if ITEM_BIND_QUEST==left:GetText() or ITEM_SOULBOUND==left:GetText() then
				return true
			end
		end

	end
end






function scanNonSoulboundItems()
	for bagID = -3 , NUM_BAG_SLOTS+NUM_BANKBAGSLOTS do
		local numberOfSlots = C_Container.GetContainerNumSlots(bagID);
		for slotID = 0, numberOfSlots do


			local itemLink = GetContainerItemLink(bagID, slotID)
			if itemLink then
				print(itemLink)
				local soulboundness = is_soulbound_item(bagID, slotID)
				--local stats = GetItemStats(itemLink)
				--tprint(stats)
				if not soulboundness then
					print(bagID, slotID, itemLink)
				end
			end


		end
	end
end


function isSoulboundItem(bag,slot)
	local b = is_soulbound_item(bag, slot)
	print("Soulbound: " .. bag .. " " .. slot .. " : " .. stringify( b ) )
	return b
end
