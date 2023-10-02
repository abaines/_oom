
function Auction_OnLoad(...)
	t_Auction_OnLoad = time()

	AuctionFrame:RegisterEvent("AUCTION_HOUSE_NEW_RESULTS_RECEIVED");

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
	tprint(arg1)
	print(arg2)
	print(arg3)
	print(arg4)
	print(arg5)
	print(arg6)
end


function Auction_OnUpdate(...)

end
