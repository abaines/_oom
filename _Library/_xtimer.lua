-- Timer number , time between true returns (in seconds)

_xtimer_table_data = {}

--- timer name, timer delay in seconds
function xtimer(timerName,timerDelay)
	if not _xtimer_table_data then
		_xtimer_table_data = {}
	end

	if _xtimer_table_data[timerName]==nil then
		_xtimer_table_data[timerName] = time()
		return true

	elseif time() - _xtimer_table_data[timerName] > timerDelay then
		_xtimer_table_data[timerName] = time()
		return true

	end
end



--[[
	xtime = {}
	xvarname = {}

function xtimer(tnum,ctime)
  if not xtimeset then
    xtime = {}
    xvarname = {}
    xtimeset=true
  end

  if type(tnum)=="string" then
    tnum=addx(tnum)
  elseif type(tnum)=="number" then
    xvarname[tnum]=tnum
  end

  if tnum and not xtime[tnum] then
    xtime[tnum]=time()
    return -1
  end

  if not ctime or type(ctime)~="number" then
    DEFAULT_CHAT_FRAME:AddMessage(tnum .. " does not have numerical time value")
    return -2
  end

  if ( tnum and time()-xtime[tnum] > ctime ) then
    local xtimer_rvalue=time()-xtime[tnum]
    xtime[tnum]=time()
    if xtimer_rvalue <=0 or not xtimer_rvalue then
      DEFAULT_CHAT_FRAME:AddMessage( xtimer_rvalue ,1,0,1)
      return -4
    end
    return xtimer_rvalue
  end

  if tnum and not xtime[tnum] then
    xtime[tnum]=time()
    return -3
  end

  return false
end

function addx(tnum)
  if not( type(tnum)=="string" ) then return nil
  elseif not xtimermaxindex then xtimermaxindex=1
  end

  while (true) do

    for xindex=1,xtimermaxindex do
      if xvarname[xindex] and xvarname[xindex]==tnum then
        return xindex
      elseif xvarname[xindex] then
        --nil
      else
        xvarname[xindex]=tnum
--      DEFAULT_CHAT_FRAME:AddMessage("$"..xindex .. " made " .. xvarname[xindex] )
        return xindex
      end
    end

     xtimermaxindex=xtimermaxindex+1
   --DEFAULT_CHAT_FRAME:AddMessage("xtimermaxindex increased to " .. xtimermaxindex)
   end

   xvarname[xtimermaxindex]=tnum
   DEFAULT_CHAT_FRAME:AddMessage("%"..xtimermaxindex .. " made " .. xvarname[xtimermaxindex] )
   return xtimermaxindex
end


--adds time to xtimer value, may only work for xtimers defined by strings, CRAZY!
--positive values speed up the next xtimer, passing zero will return delta from last xtimer
--2009 November
function xtimerpass(tnum,ctime)
  if type(tnum)=="string" and type(ctime)=="number" then
		for key1,val1 in pairs(xvarname) do
			if val1==tnum then
				xtime[key1] = xtime[key1] - ctime
				return time() - xtime[key1]
			end
		end
	end
end

function round(fnumber,rnum)
  if not fnumber then return fnumber end
  if not rnum then rnum=0 end
  divnum=10^rnum
  returnval=fnumber/divnum
  returnval=floor(returnval)
  returnval=returnval*divnum
  returnval=tonumber(returnval)
  return (returnval)
end

]]--

