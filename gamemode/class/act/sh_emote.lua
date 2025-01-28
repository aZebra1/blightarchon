BIND("cough", KEY_K, {
	Press = function(self, ply)
		if SERVER then
			return ply:Do(ACT.COUGH)
		end
	end
})
local Cough
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = (function()
			local _accum_0 = { }
			local _len_0 = 1
			for i = 1, 4 do
				_accum_0[_len_0] = "ambient/voices/cough" .. tostring(i) .. ".wav"
				_len_0 = _len_0 + 1
			end
			return _accum_0
		end)()
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
		__name = "Cough",
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
	Cough = _class_0
end
local COUGH
do
	local _class_0
	local _parent_0 = ACT
	local _base_0 = {
		Immobilizes = false,
		Do = function(self, fromstate)
			local _with_0 = self.ply
			if not _with_0:StanceIs(STANCE_RISEN) then
				return
			end
			local sequence = 'a_g_headinhds'
			local snd, cycle1 = "ambient/voices/cough" .. math.random(1, 4) .. ".wav", .43
			if (CLIENT and IsFirstTimePredicted()) or SERVER then
				self:Spasm({
					sequence = sequence
				})
			end
			self:CYCLE(cycle1, function(self)
				if IsFirstTimePredicted() and SERVER then
					local bone = 'ValveBiped.Bip01_Head1'
					return _with_0:EmitSound('Cough')
				end
			end)
			return _with_0
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
		__name = "COUGH",
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
	COUGH = _class_0
end
BIND("salute", KEY_L, {
	Press = function(self, ply)
		if SERVER then
			return ply:Do(ACT.SALUTE)
		end
	end
})
local SALUTE
do
	local _class_0
	local _parent_0 = ACT
	local _base_0 = {
		Immobilizes = false,
		Do = function(self, fromstate)
			local _with_0 = self.ply
			if not _with_0:StanceIs(STANCE_RISEN) then
				return
			end
			local sequence = 'gesture_salute'
			if (CLIENT and IsFirstTimePredicted()) or SERVER then
				self:Spasm({
					sequence = sequence
				})
			end
			return _with_0
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
		__name = "SALUTE",
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
	SALUTE = _class_0
end
BIND("hairbrush", KEY_P, {
	Press = function(self, ply)
		if SERVER then
			return ply:Do(ACT.HAIRBRUSH)
		end
	end
})
local HAIRBRUSH
local _class_0
local _parent_0 = ACT
local _base_0 = {
	Immobilizes = false,
	Do = function(self, fromstate)
		local _with_0 = self.ply
		if not _with_0:StanceIs(STANCE_RISEN) then
			return
		end
		local sequence = 'a_hairbrush'
		if (CLIENT and IsFirstTimePredicted()) or SERVER then
			self:Spasm({
				sequence = sequence
			})
		end
		return _with_0
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
	__name = "HAIRBRUSH",
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
HAIRBRUSH = _class_0
return _class_0
