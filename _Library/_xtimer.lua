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

