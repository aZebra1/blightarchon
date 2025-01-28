local PrecacheSound = util.PrecacheSound
SNDLVL_NONE = 0
SNDLVL_20dB = 20
SNDLVL_25dB = 25
SNDLVL_30dB = 30
SNDLVL_35dB = 35
SNDLVL_40dB = 40
SNDLVL_45dB = 45
SNDLVL_50dB = 50
SNDLVL_55dB = 55
SNDLVL_IDLE = 60
SNDLVL_60dB = 60
SNDLVL_65dB = 65
SNDLVL_STATIC = 66
SNDLVL_70dB = 70
SNDLVL_NORM = 75
SNDLVL_75dB = 75
SNDLVL_80dB = 80
SNDLVL_TALKING = 80
SNDLVL_85dB = 85
SNDLVL_90dB = 90
SNDLVL_95dB = 95
SNDLVL_100dB = 100
SNDLVL_105dB = 105
SNDLVL_110dB = 110
SNDLVL_120dB = 120
SNDLVL_130dB = 130
SNDLVL_GUNFIRE = 140
SNDLVL_140dB = 140
SNDLVL_150dB = 150
SNDLVL_180dB = 180
do
	local _class_0
	local _base_0 = {
		channel = CHAN_AUTO,
		level = SNDLVL_NORM,
		volume = 1,
		pitch = {
			95,
			105
		},
		sound = { }
	}
	if _base_0.__index == nil then
		_base_0.__index = _base_0
	end
	_class_0 = setmetatable({
		__init = function(self, where) end,
		__base = _base_0,
		__name = "SOUND"
	}, {
		__index = _base_0,
		__call = function(cls, ...)
			local _self_0 = setmetatable({ }, _base_0)
			cls.__init(_self_0, ...)
			return _self_0
		end
	})
	_base_0.__class = _class_0
	local self = _class_0;
	self.__inherited = function(self, child)
		local snd = {
			name = child.__name
		}
		local ancestor = child
		while ancestor do
			for k, v in pairs(ancestor.__base) do
				local _continue_0 = false
				repeat
					if string.sub(k, 1, 2) == "__" then
						_continue_0 = true
						break
					end
					if not snd[k] then
						snd[k] = v
					end
					_continue_0 = true
				until true
				if not _continue_0 then
					break
				end
			end
			if not ancestor.__parent then
				break
			end
			ancestor = ancestor.__parent
		end
		if istable(snd.sound) then
			local _list_0 = snd.sound
			for _index_0 = 1, #_list_0 do
				local s = _list_0[_index_0]
				PrecacheSound(s)
			end
		else
			PrecacheSound(snd.sound)
		end
		return sound.Add(snd)
	end
	SOUND = _class_0
end
