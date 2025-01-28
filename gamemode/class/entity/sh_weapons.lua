local Weapon
do
	local _class_0
	local _parent_0 = THING
	local _base_0 = {
		IName = 'weapon',
		Spawnable = true,
		Model = Model('models/weapons/w_crowbar.mdl'),
		ImpactSound = Sound('physics/metal/metal_grenade_impact_soft1.wav')
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
		__name = "Weapon",
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
	Weapon = _class_0
end
local Knife
do
	local _class_0
	local _parent_0 = Weapon
	local _base_0 = {
		IName = 'sharp metal',
		Model = Model('models/props_debris/metal_panelshard01c.mdl'),
		Element = 'metal/scrap',
		HandOffset = {
			Pos = Vector(7, -20, 8),
			Ang = Angle(0, 45, -9)
		},
		AttackEnabled = true,
		AttackDamage = 15,
		AttackDamageType = DMG_SLASH,
		AttackDelay = 0.5,
		AttackRange = 70,
		AttackSound = {
			Swing = 'WeaponFrag.Throw',
			Hit = Sound('physics/metal/metal_computer_impact_bullet1.wav')
		},
		AttackSequence = {
			'melee_1h_stab'
		},
		ThrowVelocity = 800,
		PlaceAngle = Angle(90, 0, 0)
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
		__name = "Knife",
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
	Knife = _class_0
end
local Long
do
	local _class_0
	local _parent_0 = Knife
	local _base_0 = {
		IName = 'long knife',
		Model = Model('models/props_wasteland/prison_throwswitchlever001.mdl'),
		Element = 'metal/scrap',
		HandOffset = {
			Pos = Vector(0, 0, 6),
			Ang = Angle(180, 0, 0)
		},
		SizeClass = SIZE_LARGE,
		Animations = {
			prime = ANIMS.melee_2hand,
			throw = ANIMS.throwing
		},
		AttackSound = {
			Hit = Sound('ambient/machines/slicer4.wav')
		},
		AttackSequence = {
			'melee_2h_left',
			'melee_2h_overhead'
		},
		AttackDamage = 30,
		AttackDelay = 1
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
		__name = "Long",
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
	Long = _class_0
end
local Wrench
do
	local _class_0
	local _parent_0 = Weapon
	local _base_0 = {
		IName = 'wrench',
		Model = Model('models/props_c17/tools_wrench01a.mdl'),
		Element = 'metal/scrap',
		HandOffset = {
			Pos = Vector(0, 0, 0),
			Ang = Angle(0, -90, 90)
		},
		HandOffset = {
			Pos = Vector(7, -20, 8),
			Ang = Angle(0, 45, -9)
		},
		AttackEnabled = true,
		AttackDamage = 15,
		AttackDamageType = DMG_CLUB,
		AttackDelay = 1,
		AttackRange = 70,
		AttackSound = {
			Swing = 'WeaponFrag.Throw',
			Hit = Sound('physics/metal/metal_computer_impact_bullet1.wav')
		},
		AttackSequence = {
			'melee_1h_overhead',
			'melee_1h_left'
		},
		ThrowVelocity = 800,
		PlaceAngle = Angle(0, 0, 0)
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
		__name = "Wrench",
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
	Wrench = _class_0
end
local Pliers
do
	local _class_0
	local _parent_0 = Wrench
	local _base_0 = {
		IName = 'pliers',
		Model = Model('models/props_c17/tools_pliers01a.mdl')
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
		__name = "Pliers",
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
	Pliers = _class_0
end
local Shovel
do
	local _class_0
	local _parent_0 = Weapon
	local _base_0 = {
		IName = 'shovel',
		Model = Model('models/props_junk/Shovel01a.mdl'),
		Element = 'metal/scrap',
		HandOffset = {
			Pos = Vector(0, 0, 12),
			Ang = Angle(180, 0, -0)
		},
		ImpactSound = Sound('physics/metal/metal_grenade_impact_soft1.wav'),
		SizeClass = SIZE_LARGE,
		Animations = {
			prime = ANIMS.melee_2hand,
			throw = ANIMS.throwing
		},
		AttackEnabled = true,
		AttackDamage = 35,
		AttackDamageType = DMG_CLUB,
		AttackDelay = 1.5,
		AttackRange = 70,
		AttackSound = {
			Swing = 'WeaponFrag.Throw',
			Hit = Sound('physics/metal/metal_computer_impact_bullet1.wav')
		},
		AttackSequence = {
			'melee_2h_left',
			'melee_2h_overhead'
		},
		ThrowVelocity = 200,
		PlaceAngle = Angle(-90, 0, 0)
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
		__name = "Shovel",
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
	Shovel = _class_0
end
local Spear
local _class_0
local _parent_0 = Weapon
local _base_0 = {
	IName = 'spear',
	Model = Model('models/props_junk/harpoon002a.mdl'),
	Element = 'metal/iron',
	ImpactSound = Sound('physics/concrete/concrete_block_impact_hard1.wav'),
	SizeClass = SIZE_LARGE,
	Animations = {
		prime = ANIMS.shotgun,
		throw = ANIMS.throwing
	},
	AttackEnabled = true,
	AttackDamage = 30,
	AttackDamageType = DMG_SLASH,
	AttackDelay = 1.5,
	AttackRange = 80,
	AttackSound = {
		Swing = 'WeaponFrag.Throw',
		Hit = Sound('physics/concrete/concrete_block_impact_hard1.wav')
	},
	AttackSequence = {
		'melee_2h_left',
		'melee_2h_overhead'
	},
	ThrowVelocity = 300,
	PlaceAngle = Angle(90, 0, 0)
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
	__name = "Spear",
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
Spear = _class_0
return _class_0
