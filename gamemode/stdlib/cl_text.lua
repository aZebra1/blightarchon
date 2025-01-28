local symbols_of_great_power = {
	'@',
	'#',
	'!',
	'$',
	'%',
	'&',
	'*'
}
for k, v in pairs({
	stutter = function(text, types, chance)
		if types == nil then
			types = {
				'upper'
			}
		end
		if chance == nil then
			chance = 5
		end
		local text_tab = string.split(text, "")
		local effects = {
			upper = function(text)
				return string.upper(text)
			end,
			scramble = function(text)
				return symbols_of_great_power[_ud83c_udfb2(#symbols_of_great_power)]
			end
		}
		local new_text = ""
		for _index_0 = 1, #text_tab do
			local t = text_tab[_index_0]
			if _ud83c_udfb2(1, 100) <= chance then
				local key = types[_ud83c_udfb2(#types)]
				t = effects[key](t)
			end
			new_text = new_text .. t
		end
		return new_text
	end
}) do
	string[k] = v
end
