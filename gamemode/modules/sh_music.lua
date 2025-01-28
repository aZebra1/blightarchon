AMBIENCE_COOLDOWN = AMBIENCE_COOLDOWN or 0
local Music
do
	local _class_0
	local _parent_0 = MODULE
	local _base_0 = {
		songs = {
			living = {
				{
					name = "apostate",
					artist = "spring lake",
					path = "dysphoria/music/idle/springlake/apostate.ogg",
					duration = 551
				},
				{
					name = "enoch",
					artist = "spring lake",
					path = "dysphoria/music/idle/springlake/enoch.ogg",
					duration = 421
				},
				{
					name = "execrate",
					artist = "spring lake",
					path = "dysphoria/music/idle/springlake/execrate.ogg",
					duration = 751
				},
				{
					name = "junk",
					artist = "spring lake",
					path = "dysphoria/music/idle/springlake/junk.ogg",
					duration = 841
				},
				{
					name = "macerator",
					artist = "spring lake",
					path = "dysphoria/music/idle/springlake/macerator.ogg",
					duration = 631
				},
				{
					name = "sick",
					artist = "spring lake",
					path = "dysphoria/music/idle/springlake/sick.ogg",
					duration = 916
				},
				{
					name = "tachycardia",
					artist = "spring lake",
					path = "dysphoria/music/idle/springlake/tachycardia.ogg",
					duration = 741
				}
			},
			dead = {
				{
					name = "Demon Engine",
					artist = "Ouroboros",
					path = "dysphoria/music/idle/springlake/tachycardia.ogg",
					duration = 481
				}
			}
		},
		CreateAmbient = function(self)
			local vol = 0.666
			local songs = self.songs.living
			local song = songs[math.random(1, #songs)]
			local path, duration = song.path, song.duration
			return sound.PlayFile("sound/" .. tostring(song.path), "noblock", function(amb)
				if IsValid(amb) then
					if IsValid(AMBIENCE) then
						AMBIENCE:Stop()
					end
					amb:SetVolume(vol)
					amb:Play()
					AMBIENCE = amb
					MsgC(Color(150, 150, 150), "Now playing ", Color(150, 220, 0), song.name, Color(150, 150, 150), ", by ", Color(150, 0, 150), song.artist, Color(150, 150, 150), "...\n")
					AMBIENCE_COOLDOWN = CurTime() + duration + 3
				end
			end)
		end,
		PlayerSpawn = function(self, ply)
			return NETMSG_MUSIC:Send(ply)
		end
	}
	for _key_0, _val_0 in pairs(_parent_0.__base) do
		if _base_0[_key_0] == nil and _key_0:match("^__") and not (_key_0 == "__index" and _val_0 == _parent_0.__base) then
			_base_0[_key_0] = _val_0
		end
	end
	if _base_0.__index == nil then
		_base_0.__index = _base_0
	end
	setmetatable(_base_0, _parent_0.__base)
	_class_0 = setmetatable({
		__init = function(self, ...)
			return _class_0.__parent.__init(self, ...)
		end,
		__base = _base_0,
		__name = "Music",
		__parent = _parent_0
	}, {
		__index = function(cls, name)
			local val = rawget(_base_0, name)
			if val == nil then
				local parent = rawget(cls, "__parent")
				if parent then
					return parent[name]
				end
			else
				return val
			end
		end,
		__call = function(cls, ...)
			local _self_0 = setmetatable({ }, _base_0)
			cls.__init(_self_0, ...)
			return _self_0
		end
	})
	_base_0.__class = _class_0
	if _parent_0.__inherited then
		_parent_0.__inherited(_parent_0, _class_0)
	end
	Music = _class_0
end
do
	local _class_0
	local _parent_0 = NETMSG
	local _base_0 = { }
	for _key_0, _val_0 in pairs(_parent_0.__base) do
		if _base_0[_key_0] == nil and _key_0:match("^__") and not (_key_0 == "__index" and _val_0 == _parent_0.__base) then
			_base_0[_key_0] = _val_0
		end
	end
	if _base_0.__index == nil then
		_base_0.__index = _base_0
	end
	setmetatable(_base_0, _parent_0.__base)
	_class_0 = setmetatable({
		__init = function(self, ...)
			return _class_0.__parent.__init(self, ...)
		end,
		__base = _base_0,
		__name = "NETMSG_MUSIC",
		__parent = _parent_0
	}, {
		__index = function(cls, name)
			local val = rawget(_base_0, name)
			if val == nil then
				local parent = rawget(cls, "__parent")
				if parent then
					return parent[name]
				end
			else
				return val
			end
		end,
		__call = function(cls, ...)
			local _self_0 = setmetatable({ }, _base_0)
			cls.__init(_self_0, ...)
			return _self_0
		end
	})
	_base_0.__class = _class_0
	local self = _class_0;
	self.Write = function(self) end
	self.Read = function(self) end
	self.Callback = function(self, ply)
		if not timer.Exists("mAmbientMusicChecker") then
			return timer.Create("mAmbientMusicChecker", 5, 0, function()
				if AMBIENCE_COOLDOWN > CurTime() then
					return
				end
				return hook.Run('CreateAmbient')
			end)
		end
	end
	if _parent_0.__inherited then
		_parent_0.__inherited(_parent_0, _class_0)
	end
	NETMSG_MUSIC = _class_0
end
if CLIENT then
	if not table.IsEmpty(Music.songs) then
		local _list_0 = Music.songs
		for _index_0 = 1, #_list_0 do
			local data = _list_0[_index_0]
			util.PrecacheSound(data.path)
		end
	end
end
