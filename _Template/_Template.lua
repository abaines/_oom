
function Template_OnLoad(...)
	t_Template_OnLoad = time()
	print("Template_OnLoad()")
end


function Template_OnEvent(self,event,...)
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


function Template_OnUpdate(...)

end
