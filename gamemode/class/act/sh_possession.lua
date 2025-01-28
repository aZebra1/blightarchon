local random = math.random
local Empty = table.Empty
local TraceHull, TraceLine, GetSurfaceData = util.TraceHull, util.TraceLine, util.GetSurfaceData
local PICK_UP
do
	local _class_0
	local _parent_0 = ACT
	local _base_0 = {
		Immobilizes = false,
		Impossible = function(self)
			if IsValid(self.thing) and self.ply:DistanceFrom(self.thing) <= 82 * 1.15 then
				local cls = self.thing:GetClass()
				if cls:starts('thing') or cls == "prop_ragdoll" then
					return false
				end
			end
			return true
		end,
		Do = function(self, fromstate)
			local sequence, snd, cycle = 'g_lookatthis', 'PickupThing', .23
			if self.ply:EyeAngles().p >= 45 then
				sequence, cycle = 'pickup_generic_offhand', .5
			end
			self:Spasm({
				sequence = sequence,
				SS = true
			})
			return self:CYCLE(cycle, function(self)
				do
					local _with_0 = self.thing
					if SERVER then
						_with_0:EmitSound(snd)
					end
					local cls = _with_0:GetClass()
					if cls:starts('thing') then
						if SERVER then
							_with_0:MoveTo(self.ply, self.ply:GetInventory(), SLOT_HAND)
						end
					elseif cls == "prop_ragdoll" then
						if SERVER then
							self.ply:PickupObject(self.thing)
						end
						self.thing.DraggedBy = self.ply
						self.ply:SetDragging(self.thing)
					end
				end
				return self:Kill()
			end)
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
		__init = function(self, ply, thing)
			self.ply = ply
			self.thing = thing
			return _class_0.__parent.__init(self, self.ply)
		end,
		__base = _base_0,
		__name = "PICK_UP",
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
	PICK_UP = _class_0
end
local _anon_func_0 = function(self)
	local _val_0 = self.thing
	return self.ply:Wielding() == _val_0 or self.ply:WieldingOffhand() == _val_0
end
local DROP
do
	local _class_0
	local _parent_0 = ACT
	local _base_0 = {
		Immobilizes = false,
		Impossible = function(self)
			if not (IsValid(self.thing) and _anon_func_0(self)) then
				return true
			end
		end,
		Do = function(self, fromstate)
			return self.ply:Release(self.thing)
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
		__init = function(self, ply, thing)
			self.ply = ply
			self.thing = thing
			return _class_0.__parent.__init(self, self.ply)
		end,
		__base = _base_0,
		__name = "DROP",
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
	DROP = _class_0
end
local _anon_func_1 = function(self)
	local _val_0 = self.thing
	return self.ply:Wielding() == _val_0 or self.ply:WieldingOffhand() == _val_0
end
local PLACE
do
	local _class_0
	local _parent_0 = ACT
	local _base_0 = {
		Immobilizes = false,
		Impossible = function(self)
			if not (IsValid(self.thing) and _anon_func_1(self)) then
				return true
			end
		end,
		Do = function(self, fromstate)
			local ang
			if self.alt then
				ang = self.thing.PlaceAngle2
			else
				ang = self.thing.PlaceAngle
			end
			local sequence, cycle, speed = 'range_slam', .23, 1
			if (CLIENT and IsFirstTimePredicted()) or SERVER then
				self:Spasm({
					sequence = sequence,
					speed = speed
				})
			end
			return self:CYCLE(cycle, function(self)
				if SERVER then
					self.thing:SetAngles(Angle(0, self.ply:GetAngles().y, 0) + ang)
					local tr = self.ply:TraceItem(self.thing, self.ply:GetInteractTrace().HitPos)
					self.thing:MoveToWorld(tr.HitPos, self.thing:GetAngles())
					local start = self.thing:GetPos()
					local endpos = start - Vector(0, 0, 3)
					tr = TraceLine({
						start = start,
						endpos = endpos,
						filter = self.thing
					})
					if not tr.Hit then
						tr = TraceLine({
							start = start,
							endpos = start
						})
					end
					local surfprop = GetSurfaceData(tr.SurfaceProps)
					surfprop = surfprop or GetSurfaceData(0)
					local snd = surfprop.impactSoftSound
					self.thing:EmitSound(snd)
				end
				return self:Kill()
			end)
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
		__init = function(self, ply, thing, alt)
			self.ply = ply
			self.thing = thing
			self.alt = alt
			return _class_0.__parent.__init(self, self.ply)
		end,
		__base = _base_0,
		__name = "PLACE",
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
	PLACE = _class_0
end
local _anon_func_2 = function(self)
	local _val_0 = self.thing
	return self.ply:Wielding() == _val_0 or self.ply:WieldingOffhand() == _val_0
end
local THROW
do
	local _class_0
	local _parent_0 = ACT
	local _base_0 = {
		Immobilizes = false,
		Impossible = function(self)
			if not (IsValid(self.thing) and _anon_func_2(self)) then
				return true
			end
		end,
		Do = function(self, fromstate)
			local sequence
			do
				local _exp_0 = self.thing
				if self.ply:Wielding() == _exp_0 then
					sequence = "gesture_throw_grenade"
				elseif self.ply:WieldingOffhand() == _exp_0 then
					sequence = "gesture_item_throw"
				end
			end
			local cycles
			if "gesture_throw_grenade" == sequence then
				cycles = {
					start = 0,
					throw = .25
				}
			elseif "gesture_item_throw" == sequence then
				cycles = {
					start = .45,
					throw = .65
				}
			end
			if (CLIENT and IsFirstTimePredicted()) or SERVER then
				self:Spasm({
					sequence = sequence,
					start = cycles.start
				})
			end
			return self:CYCLE(cycles.throw, function(self)
				if IsFirstTimePredicted() and SERVER then
					self.ply:Release(self.thing)
					self.thing:EmitSound('ThrowThing')
					local vel = self.thing.ThrowVelocity
					self.thing:SetCollisionGroup(COLLISION_GROUP_PLAYER)
					local phys = self.thing:GetPhysicsObject()
					phys:SetVelocity(self.ply:GetVelocity() + (self.ply:GetForward() + Vector(0, 0, .1)) * self.thing.ThrowVelocity * self.mult)
					if not (self.thing.SizeClass == SIZE_HUGE) then
						return phys:AddAngleVelocity(Vector(vel, math.random(-vel, vel), 0))
					end
				end
			end)
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
		__init = function(self, ply, thing, mult)
			if mult == nil then
				mult = 1
			end
			self.ply = ply
			self.thing = thing
			self.mult = mult
			return _class_0.__parent.__init(self, self.ply)
		end,
		__base = _base_0,
		__name = "THROW",
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
	THROW = _class_0
end
local ThrowThing
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = (function()
			local _accum_0 = { }
			local _len_0 = 1
			for i = 1, 30 do
				_accum_0[_len_0] = "dysphoria/whoosh/arm" .. tostring(i) .. ".ogg"
				_len_0 = _len_0 + 1
			end
			return _accum_0
		end)(),
		pitch = {
			70,
			90
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
		__name = "ThrowThing",
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
	ThrowThing = _class_0
end
local PickupThing
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = (function()
			local _accum_0 = { }
			local _len_0 = 1
			for i = 1, 5 do
				_accum_0[_len_0] = "dysphoria/pickup" .. tostring(i) .. ".ogg"
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
		__name = "PickupThing",
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
	PickupThing = _class_0
end
local HolsterThing
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = (function()
			local _accum_0 = { }
			local _len_0 = 1
			for i = 1, 3 do
				_accum_0[_len_0] = "dysphoria/weapons/wield_gun" .. tostring(i) .. ".ogg"
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
		__name = "HolsterThing",
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
	HolsterThing = _class_0
end
local HOLSTER
do
	local _class_0
	local _parent_0 = ACT
	local _base_0 = {
		Immobilizes = false,
		Impossible = function(self)
			if not IsValid(self.ply:GetInventory()) then
				return true
			end
			if IsValid(self.ply:GetInventory():GetSlot(self.islot)) then
				return true
			end
			return false
		end,
		Do = function(self, fromstate)
			local sequence, snd, cycle = self.thing.HolsterSequence or 'weapon_holster_gesture', self.thing.HolsterSound or 'HolsterThing', .45
			self:Spasm({
				sequence = sequence,
				SS = true
			})
			return self:CYCLE(cycle, function(self)
				do
					local _with_0 = self.thing
					if SERVER then
						_with_0:EmitSound(snd)
					end
					local cls = _with_0:GetClass()
					if cls:starts('thing') then
						if SERVER then
							_with_0:MoveTo(self.ply, self.ply:GetInventory(), self.islot)
						end
					end
				end
				return self:Kill()
			end)
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
		__init = function(self, ply, thing, islot)
			self.ply = ply
			self.thing = thing
			self.islot = islot
			return _class_0.__parent.__init(self, self.ply)
		end,
		__base = _base_0,
		__name = "HOLSTER",
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
	HOLSTER = _class_0
end
BIND('item_holster_left', KEY_G, {
	Press = function(self, ply)
		if SERVER then
			local wielding = ply:Wielding()
			local belted = ply:GetInventory():GetSlot(SLOT_BELT_L)
			if IsValid(wielding) then
				return ply:Do(ACT.HOLSTER, wielding, SLOT_BELT_L)
			elseif IsValid(belted) then
				return ply:Do(ACT.UNHOLSTER, belted)
			end
		end
	end
})
BIND('item_holster_right', KEY_H, {
	Press = function(self, ply)
		if SERVER then
			local wielding = ply:Wielding()
			local belted = ply:GetInventory():GetSlot(SLOT_BELT_R)
			if IsValid(wielding) then
				return ply:Do(ACT.HOLSTER, wielding, SLOT_BELT_R)
			elseif IsValid(belted) then
				return ply:Do(ACT.UNHOLSTER, belted)
			end
		end
	end
})
for pocket = 1, 4 do
	BIND("item_holster_pocket" .. tostring(pocket), _G["KEY_" .. tostring(pocket)], {
		Press = function(self, ply)
			if SERVER then
				local slot = _G["SLOT_POCKET" .. tostring(pocket)]
				local wielding = ply:Wielding()
				local pocketed = ply:GetInventory():GetSlot(slot)
				if IsValid(wielding) then
					return ply:Do(ACT.HOLSTER, wielding, slot)
				elseif IsValid(pocketed) then
					return ply:Do(ACT.UNHOLSTER, pocketed)
				end
			end
		end
	})
end
local UNHOLSTER
local _class_0
local _parent_0 = ACT
local _base_0 = {
	Immobilizes = false,
	Impossible = function(self)
		if not IsValid(self.ply:GetInventory()) then
			return true
		end
		if IsValid(self.ply:Wielding()) then
			return true
		end
		return false
	end,
	Do = function(self, fromstate)
		local sequence, snd, cycle = self.thing.UnholsterSequence or 'UNHOLSTER_Pistol', self.thing.UnholsterSound or 'HolsterThing', .33
		self:Spasm({
			sequence = sequence,
			SS = true
		})
		return self:CYCLE(cycle, function(self)
			do
				local _with_0 = self.thing
				if SERVER then
					_with_0:EmitSound(snd)
				end
				local cls = _with_0:GetClass()
				if cls:starts('thing') then
					if SERVER then
						_with_0:MoveTo(self.ply, self.ply:GetInventory(), SLOT_HAND)
					end
				end
			end
			return self:Kill()
		end)
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
	__init = function(self, ply, thing)
		self.ply = ply
		self.thing = thing
		return _class_0.__parent.__init(self, self.ply)
	end,
	__base = _base_0,
	__name = "UNHOLSTER",
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
UNHOLSTER = _class_0
return _class_0
