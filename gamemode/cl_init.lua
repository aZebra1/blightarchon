local included = { }
local sh_luas = {
	'shared',
	'stdlib/',
	'extension',
	'animtable',
	'class/',
	'class/act/',
	'class/entity/sh_things',
	'class/entity/',
	'class/entity/stack/',
	'class/effect/',
	'class/weapon/',
	'class/caste/',
	'class/fate/',
	'modules/',
	'playerclass',
	'status/'
}
local cl_luas = {
	'stdlib/',
	'class/cl_font',
	'class/cl_bubble',
	'class/font/',
	'class/cl_vgui',
	'modules/',
	'class/vgui/'
}
for _index_0 = 1, #sh_luas do
	local sh_lua = sh_luas[_index_0]
	local _continue_0 = false
	repeat
		local ending = string.sub(sh_lua, -1)
		if ending == "/" then
			local files = file.Find("blightarchon/gamemode/" .. tostring(sh_lua) .. "*.lua", "LUA")
			for _index_1 = 1, #files do
				local f = files[_index_1]
				local _continue_1 = false
				repeat
					if not (string.sub(f, 1, 3) == "sh_") then
						_continue_1 = true
						break
					end
					local path = tostring(sh_lua) .. tostring(f)
					if (#included > 0 and (function()
						for _index_2 = 1, #included do
							if included[_index_2] == path then
								return true
							end
						end
						return false
					end)()) then
						_continue_1 = true
						break
					end
					included[#included + 1] = path
					include(path)
					_continue_1 = true
				until true
				if not _continue_1 then
					break
				end
			end
		else
			local path = tostring(sh_lua) .. ".lua"
			if (#included > 0 and (function()
				for _index_1 = 1, #included do
					if included[_index_1] == path then
						return true
					end
				end
				return false
			end)()) then
				_continue_0 = true
				break
			end
			included[#included + 1] = path
			include(path)
		end
		_continue_0 = true
	until true
	if not _continue_0 then
		break
	end
end
for _index_0 = 1, #cl_luas do
	local cl_lua = cl_luas[_index_0]
	local _continue_0 = false
	repeat
		local ending = string.sub(cl_lua, -1)
		if ending == "/" then
			local files = file.Find("blightarchon/gamemode/" .. tostring(cl_lua) .. "*.lua", "LUA")
			for _index_1 = 1, #files do
				local f = files[_index_1]
				local _continue_1 = false
				repeat
					if not (string.sub(f, 1, 3) == "cl_") then
						_continue_1 = true
						break
					end
					local path = tostring(cl_lua) .. tostring(f)
					if (#included > 0 and (function()
						for _index_2 = 1, #included do
							if included[_index_2] == path then
								return true
							end
						end
						return false
					end)()) then
						_continue_1 = true
						break
					end
					included[#included + 1] = path
					include(path)
					_continue_1 = true
				until true
				if not _continue_1 then
					break
				end
			end
		else
			local path = tostring(cl_lua) .. ".lua"
			if (#included > 0 and (function()
				for _index_1 = 1, #included do
					if included[_index_1] == path then
						return true
					end
				end
				return false
			end)()) then
				_continue_0 = true
				break
			end
			included[#included + 1] = path
			include(path)
		end
		_continue_0 = true
	until true
	if not _continue_0 then
		break
	end
end
