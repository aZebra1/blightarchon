do
	local _class_0
	local _base_0 = {
		SharpDamageMult = 1,
		BluntDamageMult = 1,
		DelayMult = 1,
		Flamability = 0,
		DurabilityMult = 1,
		Attributes = {
			Material = ""
		},
		Color = "",
		ThrowMult = 1
	}
	if _base_0.__index == nil then
		_base_0.__index = _base_0
	end
	_class_0 = setmetatable({
		__init = function() end,
		__base = _base_0,
		__name = "ELEMENT"
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
	self.registered = { }
	self.__inherited = function(self, child)
		child.__barcode = tostring(self.__barcode and self.__barcode .. '/' or '') .. tostring(string.lower(child.__name))
		self.registered[child.__barcode] = child
	end
	ELEMENT = _class_0
end
local Bone
do
	local _class_0
	local _parent_0 = ELEMENT
	local _base_0 = {
		IName = 'bone',
		Flamability = 0,
		DurabilityMult = 0.5,
		SharpDamageMult = 0.8,
		BluntDamageMult = 0.9,
		ThrowMult = 1.2,
		Attributes = {
			'solid',
			'brittle'
		},
		Material = 'models/gibs/hgibs/spine'
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
		__name = "Bone",
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
	Bone = _class_0
end
local Wood
do
	local _class_0
	local _parent_0 = ELEMENT
	local _base_0 = {
		IName = 'wood',
		Flamability = 100,
		DurabilityMult = 0.7,
		SharpDamageMult = 0.3,
		BluntDamageMult = 0.9,
		ThrowMult = 1.5,
		Attributes = {
			'solid',
			'woody'
		},
		Material = 'models/gibs/woodgibs/woodgibs01'
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
		__name = "Wood",
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
	Wood = _class_0
end
local Stone
do
	local _class_0
	local _parent_0 = ELEMENT
	local _base_0 = {
		IName = 'stone',
		Flamability = 0,
		DurabilityMult = 3,
		SharpDamageMult = 0.6,
		BluntDamageMult = 1,
		DelayMult = 1.4,
		ThrowMult = 0.75,
		Attributes = {
			'solid',
			'stony'
		},
		Material = 'models/props_canal/rock_riverbed01a',
		ImpactSounds = {
			[SIZE_TINY] = 'physics/concrete/rock_impact_soft1.wav',
			[SIZE_SMALL] = 'physics/concrete/concrete_impact_soft1.wav',
			[SIZE_MEDIUM] = 'physics/concrete/concrete_impact_hard2.wav',
			[SIZE_LARGE] = 'physics/concrete/concrete_impact_hard1.wav',
			[SIZE_HUGE] = 'physics/concrete/concrete_block_impact_hard3.wav',
			[SIZE_IMMOBILE] = 'physics/concrete/concrete_block_impact_hard3.wav'
		},
		AttackSounds = {
			[SIZE_TINY] = 'physics/concrete/rock_impact_hard6.wav',
			[SIZE_SMALL] = 'physics/concrete/rock_impact_hard3.wav',
			[SIZE_MEDIUM] = 'physics/concrete/rock_impact_hard1.wav',
			[SIZE_LARGE] = 'physics/concrete/concrete_block_impact_hard3.wav',
			[SIZE_HUGE] = 'physics/concrete/concrete_block_impact_hard2.wav',
			[SIZE_IMMOBILE] = 'physics/concrete/boulder_impact_hard3.wav'
		}
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
		__name = "Stone",
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
	Stone = _class_0
end
local Concrete
do
	local _class_0
	local _parent_0 = Stone
	local _base_0 = {
		IName = 'concrete',
		DurabilityMult = 4,
		SharpDamageMult = 0.4,
		ThrowMult = 0.5,
		Material = 'models/props_debris/concretedebris_chunk01'
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
		__name = "Concrete",
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
	Concrete = _class_0
end
local Glass
do
	local _class_0
	local _parent_0 = ELEMENT
	local _base_0 = {
		IName = 'glass',
		Flamability = 0,
		DurabilityMult = 0.05,
		SharpDamageMult = 1.5,
		BluntDamageMult = 1.1,
		Attributes = {
			'solid',
			'brittle',
			'shatters'
		},
		Material = 'models/props_lab/suitcase_glass'
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
		__name = "Glass",
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
	Glass = _class_0
end
local Metal
do
	local _class_0
	local _parent_0 = ELEMENT
	local _base_0 = {
		IName = 'metal',
		Flamability = 0,
		DurabilityMult = 1.5,
		Attributes = {
			'metallic',
			'solid'
		},
		ImpactSounds = {
			[SIZE_TINY] = 'popcan.impacthard',
			[SIZE_SMALL] = 'physics/metal/metal_grenade_impact_hard2.wav',
			[SIZE_MEDIUM] = 'physics/metal/metal_box_impact_soft3.wav',
			[SIZE_LARGE] = 'physics/metal/metal_canister_impact_soft1.wav',
			[SIZE_HUGE] = 'physics/metal/metal_barrel_impact_soft3.wav',
			[SIZE_IMMOBILE] = 'physics/metal/metal_barrel_impact_soft3.wav'
		},
		AttackSounds = {
			[SIZE_TINY] = 'physics/metal/paintcan_impact_hard1.wav',
			[SIZE_SMALL] = 'physics/metal/metal_solid_impact_soft3.wav',
			[SIZE_MEDIUM] = '',
			[SIZE_LARGE] = 'physics/metal/metal_canister_impact_hard3.wav',
			[SIZE_HUGE] = 'physics/metal/metal_sheet_impact_hard6.wav',
			[SIZE_IMMOBILE] = 'physics/metal/metal_sheet_impact_hard6.wav'
		}
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
		__name = "Metal",
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
	Metal = _class_0
end
local Scrap
do
	local _class_0
	local _parent_0 = Metal
	local _base_0 = {
		IName = 'scrap',
		DurabilityMult = 0.9,
		SharpDamageMult = 0.7,
		BluntDamageMult = 0.9,
		Material = 'models/props_canal/canal_bridge_railing_01b'
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
		__name = "Scrap",
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
	Scrap = _class_0
end
local Copper
do
	local _class_0
	local _parent_0 = Metal
	local _base_0 = {
		IName = 'copper',
		DurabilityMult = 0.6,
		SharpDamageMult = 0.8,
		BluntDamageMult = 0.8,
		DelayMult = 1,
		ThrowMult = 1,
		Material = 'models/props_pipes/pipemetal001a'
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
		__name = "Copper",
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
	Copper = _class_0
end
local Tin
do
	local _class_0
	local _parent_0 = Metal
	local _base_0 = {
		IName = 'tin',
		DurabilityMult = 0.2,
		SharpDamageMult = 0.4,
		BluntDamageMult = 0.6,
		DelayMult = 1,
		ThrowMult = 1.5,
		Material = 'models/props_wasteland/fence_sheet01'
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
		__name = "Tin",
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
	Tin = _class_0
end
local Bronze
do
	local _class_0
	local _parent_0 = Metal
	local _base_0 = {
		IName = 'bronze',
		DurabilityMult = 1.5,
		SharpDamageMult = 1,
		BluntDamageMult = 1,
		DelayMult = 1,
		ThrowMult = 1,
		Material = 'models/props_wasteland/grainelevator01'
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
		__name = "Bronze",
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
	Bronze = _class_0
end
local Iron
do
	local _class_0
	local _parent_0 = Metal
	local _base_0 = {
		IName = 'iron',
		DurabilityMult = 2.5,
		SharpDamageMult = 1.2,
		BluntDamageMult = 1.2,
		DelayMult = 0.7,
		Material = 'models/props_canal/metalwall005b'
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
		__name = "Iron",
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
	Iron = _class_0
end
local Steel
do
	local _class_0
	local _parent_0 = Metal
	local _base_0 = {
		IName = 'steel',
		DurabilityMult = 10,
		SharpDamageMult = 1.5,
		BluntDamageMult = 1.5,
		DelayMult = 1,
		ThrowMult = 0.6,
		Material = 'models/props_combine/Combine_Citadel001'
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
		__name = "Steel",
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
	Steel = _class_0
end
local Pewter
do
	local _class_0
	local _parent_0 = Metal
	local _base_0 = {
		IName = 'pewter',
		DurabilityMult = 0.25,
		SharpDamageMult = 0.4,
		BluntDamageMult = 0.6,
		DelayMult = 1,
		ThrowMult = 1
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
		__name = "Pewter",
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
	Pewter = _class_0
end
local Lead
do
	local _class_0
	local _parent_0 = Metal
	local _base_0 = {
		IName = 'lead',
		DurabilityMult = 0.2,
		SharpDamageMult = 0.5,
		BluntDamageMult = 0.6,
		DelayMult = 0.5,
		ThrowMult = 0.5
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
		__name = "Lead",
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
	Lead = _class_0
	return _class_0
end
