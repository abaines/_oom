-- Kizrak



-- /fstack


function Auction_OnLoad(...)
	t_Auction_OnLoad = time()
	print("Auction_OnLoad()")
end


function Auction_OnEvent(self,event,...)
	arg1 = select(1,...)
	arg2 = select(2,...)
	arg3 = select(3,...)
	arg4 = select(4,...)
	arg5 = select(5,...)
	arg6 = select(6,...)
	arg7 = select(7,...)
	arg8 = select(8,...)
	arg9 = select(9,...)

	print(event)
end


function Auction_OnUpdate(...)

end



function mouseHelper()
	DEFAULT_CHAT_FRAME:AddMessage(ColorText(1,0,0).."mouseHelper()")
	local frame = EnumerateFrames()
	while frame do
		if frame:IsVisible() and MouseIsOver(frame) then
			DEFAULT_CHAT_FRAME:AddMessage(frame:GetName())
		end
		frame = EnumerateFrames(frame)
	end
end


function kiddos()
	DEFAULT_CHAT_FRAME:AddMessage(ColorText(1,0,0)..GetMouseFocus():GetName());
	local kiddos2 = { GetMouseFocus():GetChildren() };
	for _, child in ipairs(kiddos2) do
		DEFAULT_CHAT_FRAME:AddMessage(child:GetName());
	end
end


function pp()
	local gmf = GetMouseFocus()
	while gmf do
		DEFAULT_CHAT_FRAME:AddMessage(gmf:GetName());
		gmf = gmf:GetParent()
	end
end


--for a,n in pairs(UIParent:GetChildren()) do print(a) end



--print(UIParent:GetChildren())


--[[
local x = 0
for a,n in pairs(UIParent:GetChildren()) do
	if x~=0 then
		print(a.. "  " .. tostring( n:GetName() ))
	end
	x = 1 + x
end
]]--


-- /fstack

