if SERVER then
	local _list_0 = {
		'dev_sp',
		'dev_rs',
		'dev_rs_confirm',
		'dev_chmap',
		'dev_chmap_confirm'
	}
	for _index_0 = 1, #_list_0 do
		local netstr = _list_0[_index_0]
		util.AddNetworkString(netstr)
	end
	net.Receive("dev_sp", function(len, ply)
		if not ply:IsAdmin() then
			return
		end
		local barcode = net.ReadString()
		local cls = ENTITY.registered[barcode]
		if not (cls and cls.Spawnable) then
			return
		end
		return cls(ply)
	end)
	net.Receive("dev_rs", function(len, ply)
		if not ply:IsAdmin() then
			return
		end
		if (not ply.restart_expiry) or ply.restart_expiry < CurTime() then
			ply.restart_expiry = CurTime() + 5
			net.Start("dev_rs_confirm")
			return net.Send(ply)
		else
			return RunConsoleCommand("changelevel", game.GetMap())
		end
	end)
	net.Receive("dev_chmap", function(len, ply)
		if not ply:IsAdmin() then
			return
		end
		local map = net.ReadString()
		if (not ply.chmap_expiry) or ply.chmap_expiry < CurTime() then
			ply.chmap_expiry = CurTime() + 5
			net.Start("dev_chmap_confirm")
			net.WriteString(map)
			return net.Send(ply)
		else
			return RunConsoleCommand("changelevel", map)
		end
	end)
else
	net.Receive("dev_rs_confirm", function(len)
		return MsgC(Color(255, 0, 0), "You have entered the command to restart the server.\n", Color(172, 0, 0), "If you're sure you want to do this, input the same command within five seconds.\n")
	end)
	net.Receive("dev_chmap_confirm", function(len)
		local map = net.ReadString()
		return MsgC(Color(255, 0, 0), "You have entered the command to change the map to ", Color(0, 200, 0), tostring(map) .. ".\n", Color(172, 0, 0), "If you're sure you want to do this, input the same command within five seconds.\n")
	end)
end
local spawn_callback
spawn_callback = function(ply, cmd, args, argstr)
	if CLIENT then
		if not ply:IsAdmin() then
			if CLIENT then
				MsgC(Color(200, 0, 0), "You're too curious for your own good. This incident will be reported.\n")
			end
			return
		end
		local cls = ENTITY.registered[argstr]
		if not cls then
			if CLIENT then
				MsgC(Color(200, 0, 0), "No ENTITY class registered named " .. tostring(argstr) .. ".\n")
			end
			return
		elseif not cls.Spawnable then
			if CLIENT then
				MsgC(Color(200, 0, 0), "ENTITY '" .. tostring(argstr) .. "' is not spawnable.")
			end
			return
		end
		net.Start("dev_sp")
		net.WriteString(argstr)
		return net.SendToServer()
	end
end
local spawn_autocomplete
spawn_autocomplete = function(cmd, input)
	local keys
	do
		local _accum_0 = { }
		local _len_0 = 1
		for key, cls in pairs(ENTITY.registered) do
			if cls.Spawnable then
				_accum_0[_len_0] = key
				_len_0 = _len_0 + 1
			end
		end
		keys = _accum_0
	end
	local options = { }
	input = input:Trim():lower()
	for _index_0 = 1, #keys do
		local key = keys[_index_0]
		if key:lower():find(input) then
			options[#options + 1] = key
		end
	end
	local _accum_0 = { }
	local _len_0 = 1
	for _index_0 = 1, #options do
		local key = options[_index_0]
		_accum_0[_len_0] = "sp " .. tostring(key)
		_len_0 = _len_0 + 1
	end
	return _accum_0
end
concommand.Add('sp', spawn_callback, spawn_autocomplete)
local restart_callback
restart_callback = function(ply, cmd, args, argstr)
	if CLIENT then
		if not ply:IsAdmin() then
			if CLIENT then
				MsgC(Color(200, 0, 0), "You're too curious for your own good. This incident will be reported.\n")
			end
			return
		end
		net.Start("dev_rs")
		return net.SendToServer()
	end
end
concommand.Add('rs', restart_callback)
local chmap_callback
chmap_callback = function(ply, cmd, args, argstr)
	if CLIENT then
		if not ply:IsAdmin() then
			if CLIENT then
				MsgC(Color(200, 0, 0), "You're too curious for your own good. This incident will be reported.\n")
			end
			return
		end
		net.Start("dev_chmap")
		net.WriteString(argstr)
		return net.SendToServer()
	end
end
return concommand.Add('chmap', chmap_callback)
