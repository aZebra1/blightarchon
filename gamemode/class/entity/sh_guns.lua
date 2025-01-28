local SLOT_FIREARM_MAGAZINE = 1
local Firearm
do
	local _class_0
	local _parent_0 = THING
	local _base_0 = {
		IName = 'firearm',
		Element = 'metal/iron',
		Durability = 100,
		Initialize = function(self)
			_class_0.__parent.__base.Initialize(self)
			if SERVER then
				return INVENTORY(self)
			end
		end,
		HolsterSequence = 'weapon_holster_gesture',
		UnholsterSequence = 'UNHOLSTER_Pistol',
		HasMagazine = function(self)
			return self:GetInventory():HasItem(SLOT_FIREARM_MAGAZINE)
		end,
		GetMagazine = function(self)
			return self:GetInventory():GetItem(SLOT_FIREARM_MAGAZINE)
		end,
		SetMagazine = function(self, mag)
			return self:GetInventory():AddItem(mag, SLOT_FIREARM_MAGAZINE)
		end,
		GetInventoryPosition = function(self)
			return self:GetPos(), self:GetAngles()
		end,
		AttackAct = ACT.SHOOT,
		ImpactSound = 'weapon.impacthard',
		GetMuzzlePos = function(self)
			local pos, ang = self:GetPos(), self:GetAngles()
			local offset = self.MuzzleOffset.Pos
			pos = pos + (ang:Right() * offset.y)
			pos = pos + (ang:Forward() * offset.x)
			pos = pos + (ang:Up() * offset.z)
			ang = ang + (self.MuzzleOffset.Ang or Angle(0, 0, 0))
			return pos, ang
		end,
		FiringEffects = function(self)
			local edata = EffectData()
			edata:SetEntity(self)
			return util.Effect("muzzleflash", edata)
		end,
		Shoot = function(self)
			local mag = self:GetMagazine()
			if not (IsValid(mag) and mag:GetRounds() > 0) then
				return
			end
			self:FiringEffects()
			if SERVER then
				self:EmitSound(self.AttackSound.Shoot)
			end
			mag:AddRounds(-1)
			local pos, ang = self:GetMuzzlePos()
			local bullet = {
				Num = 1,
				Src = pos,
				Dir = ang:Forward(),
				Spread = 0.01,
				Damage = 40,
				Force = 4,
				Tracer = 1,
				TracerName = "bullettracer"
			}
			self:FireBullets(bullet)
			if SERVER then
				local gun_burn = DamageInfo()
				gun_burn:SetDamageType(DMG_BURN)
				gun_burn:SetDamage(1)
				gun_burn:SetAttacker(self)
				self:TakeDamageInfo(gun_burn)
				return mag:TakeDamageInfo(gun_burn)
			end
		end,
		PhysicsCollide = function(self, data)
			_class_0.__parent.__base.PhysicsCollide(self, data)
			if data.Speed > 256 then
				return self:Shoot()
			end
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
		__name = "Firearm",
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
	Firearm = _class_0
end
local Pistol
do
	local _class_0
	local _parent_0 = Firearm
	local _base_0 = {
		AttackSequence = 'range_pistol',
		AttackDelay = 0.3
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
		__name = "Pistol",
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
	Pistol = _class_0
end
local Pacifier
do
	local _class_0
	local _parent_0 = Pistol
	local _base_0 = {
		IName = 'Pacifier',
		Model = Model("models/weapons/act3/pistol_m9.mdl"),
		Animations = {
			prime = ANIMS.pistol_aim,
			throw = ANIMS.throwing
		},
		HandOffset = {
			Pos = Vector(1.64, -0.27, -2.18),
			Ang = Angle(-4.651, 0, 0)
		},
		BeltOffset = {
			Pos = Vector(0.22, -2.74, -0.56),
			Ang = Angle(180, 0, -90)
		},
		MuzzleOffset = {
			Pos = Vector(11.482, 0, 6.936),
			Ang = Angle(0, 0, 0)
		},
		MagazineOffset = {
			Pos = Vector(3, 0, 0),
			Ang = Angle(20, 0, 0)
		},
		AttackSound = {
			Shoot = 'Weapon_Elite.Single'
		},
		Manufacturer = "Blackheart",
		AcceptableMagazines = {
			'thing/magazine/pacifier15rd'
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
		__name = "Pacifier",
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
	Pacifier = _class_0
end
local Reaper
do
	local _class_0
	local _parent_0 = Pistol
	local _base_0 = {
		Model = Model("models/weapons/act3/pistol_blackhawk.mdl"),
		Animations = {
			prime = ANIMS.pistol_aim,
			throw = ANIMS.throwing
		},
		HandOffset = {
			Pos = Vector(-3, -2, -2),
			Ang = Angle(-4.651, 0, 0)
		},
		MuzzleOffset = {
			Pos = Vector(11.482, 0, 6.936),
			Ang = Angle(0, 0, 0)
		},
		MagazineOffset = {
			Pos = Vector(3, 0, 0),
			Ang = Angle(20, 0, 0)
		},
		AttackSound = 'Weapon_357.Single',
		IName = "Reaper",
		IDesc = "A 5-shot revolver that is not for the weak-wristed or indecisive; The Reaper shoots first and asks questions never. This valuable antique is prized for its immense stopping power and intimidation factor, instantly executing even the meanest targets.",
		Manufacturer = "Boneyard Collective"
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
		__name = "Reaper",
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
	Reaper = _class_0
end
local Rifle
do
	local _class_0
	local _parent_0 = Firearm
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
		__name = "Rifle",
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
	Rifle = _class_0
end
local Sg66
local _class_0
local _parent_0 = Rifle
local _base_0 = {
	Model = Model("models/weapons/act3/rifle_g3.mdl"),
	HandOffset = {
		Pos = Vector(10.44, -1.34, -3.69),
		Ang = Angle(0, 0, 0)
	},
	Animations = {
		prime = ANIMS.rifle_aim,
		throw = ANIMS.throwing
	},
	IName = "Sanitargewehr-66",
	IDesc = "A rare, but fearsome sight in the hands of Sanitars when the Kommandant declares martial law for any reason. Maybe it will be used by the state of Liver Failure to defend you or murder you.",
	AttackSound = {
		Shoot = 'Weapon_G3SG1.Single'
	},
	Manufacturer = "Einhesna",
	
	AcceptableMagazines = {
		"thing/magazine",
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
	__name = "Sg66",
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
Sg66 = _class_0
return _class_0
