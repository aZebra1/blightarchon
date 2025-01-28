local GetSurfaceData, TraceLine = util.GetSurfaceData, util.TraceLine
local Trim = string.Trim
local Bomb
do
	local _class_0
	local _parent_0 = THING
	local _base_0 = {
		IName = 'bomb',
		Model = Model('models/weapons/w_grenade.mdl'),
		Spawnable = true,
		SetupDataTables = function(self)
			_class_0.__parent.__base.SetupDataTables(self)
			return self:AddNetworkVar('Bool', 'Armed')
		end,
		Damage = 175,
		Radius = 250,
		ImpactThreshold = 128,
		UseSound = 'weapons/crossbow/hit1.wav',
		Detonate = function(self)
			local pos = self:WorldSpaceCenter()
			util.ScreenShake(pos, 25, 150, 1, self.Radius)
			do
				local _with_0 = ents.Create('env_explosion')
				_with_0:SetOwner(self:GetOwner())
				_with_0:SetPos(pos)
				_with_0:SetKeyValue('iMagnitude', self.Damage)
				_with_0:SetKeyValue('iRadiusOverride', self.Radius)
				_with_0:Spawn()
				_with_0:Activate()
				_with_0:Fire('Explode')
			end
			return self:Remove()
		end,
		Used = function(self, ply)
			if CLIENT then
				return
			end
			if self:GetArmed() then
				return
			end
			self:SetArmed(true)
			return self:EmitSound(self.UseSound)
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
		__name = "Bomb",
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
	Bomb = _class_0
end
local Impact
do
	local _class_0
	local _parent_0 = Bomb
	local _base_0 = {
		IName = 'impact grenade',
		PhysicsCollide = function(self, data)
			_class_0.__parent.__base.PhysicsCollide(self, data)
			if CLIENT then
				return
			end
			if self:GetArmed() and data.Speed > self.ImpactThreshold then
				return self:Detonate()
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
		__name = "Impact",
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
	Impact = _class_0
end
local Fire
do
	local _class_0
	local _parent_0 = Impact
	local _base_0 = {
		IName = 'kommissar kocktail',
		Model = Model('models/props_junk/GlassBottle01a.mdl'),
		Damage = 40,
		Radius = 128,
		UseSound = 'ambient/fire/ignite.wav',
		Used = function(self, ply)
			_class_0.__parent.__base.Used(self)
			if CLIENT then
				return
			end
			return self:Ignite(30)
		end,
		Detonate = function(self)
			local fireEnt = ents.Create('env_fire')
			fireEnt:SetPos(self:GetPos())
			fireEnt:SetKeyValue('spawnflags', "1")
			fireEnt:SetKeyValue('attack', "10")
			fireEnt:SetKeyValue('firesize', "100")
			fireEnt:Spawn()
			fireEnt:Activate()
			fireEnt:Fire('Enable', '', 0)
			fireEnt:Fire('StartFire', '', 0)
			SafeRemoveEntityDelayed(fireEnt, 30)
			return _class_0.__parent.__base.Detonate(self)
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
		__name = "Fire",
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
	Fire = _class_0
end
local Timed
do
	local _class_0
	local _parent_0 = Bomb
	local _base_0 = {
		IName = 'timed grenade',
		Timer = 3,
		BlowUpTime = 0,
		ImpactThreshold = math.huge,
		Used = function(self, ply)
			_class_0.__parent.__base.Used(self)
			if CLIENT then
				return
			end
			if self:GetArmed() then
				return
			end
			self.BlowUpTime = CurTime() + self.Timer
		end,
		Think = function(self)
			_class_0.__parent.__base.Think(self)
			if CLIENT then
				return
			end
			if not self:GetArmed() then
				return
			end
			if CurTime() > self.BlowUpTime then
				return self:Detonate()
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
		__name = "Timed",
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
	Timed = _class_0
end
local Popper
local _class_0
local _parent_0 = Impact
local _base_0 = {
	IName = 'popper grenade',
	Damage = 30,
	Radius = 64
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
	__name = "Popper",
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
Popper = _class_0
return _class_0
