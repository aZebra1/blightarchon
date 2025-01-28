local SWITCH_HAND
do
	local _class_0
	local _parent_0 = ACT
	local _base_0 = {
		Immobilizes = false,
		Impossible = function(self)
			if not (IsValid(self.ply:Wielding()) or IsValid(self.ply:WieldingOffhand())) then
				return true
			end
		end,
		Do = function(self, fromstate)
			local sequence, snd, cycle_start, cycle_switch = 'reload_dual', 'PickupThing', .7, .8
			if (CLIENT and IsFirstTimePredicted()) or SERVER then
				self:Spasm({
					sequence = sequence,
					start = cycle_start
				})
			end
			return self:CYCLE(cycle_switch, function(self)
				if SERVER then
					local w, w_off = self.ply:Wielding(), self.ply:WieldingOffhand()
					if IsValid(w) then
						if IsValid(w_off) then
							w_off:MoveToWorld(w_off:GetPos(), w_off:GetAngles())
							timer.Simple(0.1, function()
								return w_off:MoveTo(self.ply, self.ply:GetInventory(), SLOT_HAND)
							end)
						end
						w:MoveTo(self.ply, self.ply:GetInventory(), SLOT_OFFHAND)
					end
					if IsValid(w_off) then
						w_off:MoveTo(self.ply, self.ply:GetInventory(), SLOT_HAND)
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
		__init = function(self, ply)
			self.ply = ply
			return _class_0.__parent.__init(self, self.ply)
		end,
		__base = _base_0,
		__name = "SWITCH_HAND",
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
	SWITCH_HAND = _class_0
end
local UNLOAD
do
	local _class_0
	local _parent_0 = ACT
	local _base_0 = {
		Immobilizes = false,
		Impossible = function(self)
			local wielding = self.ply:Wielding()
			if not (IsValid(wielding) and wielding.GetMagazine and IsValid(wielding:GetMagazine())) then
				return true
			end
		end,
		Do = function(self, fromstate)
			local sequence, cycle_start, cycle_unload = 'reload_dual', .7, .8
			if (CLIENT and IsFirstTimePredicted()) or SERVER then
				self:Spasm({
					sequence = sequence,
					start = cycle_start
				})
			end
			return self:CYCLE(cycle_unload, function(self)
				if SERVER then
					local wielding, wielding_off = self.ply:Wielding(), self.ply:WieldingOffhand()
					local mag = wielding:GetMagazine()
					if not IsValid(mag) then
						return
					end
					if IsValid(wielding_off) then
						local p, a = wielding:GetInventoryPosition()
						mag:MoveToWorld(p, a)
					else
						mag:MoveTo(self.ply, self.ply:GetInventory(), SLOT_OFFHAND)
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
		__init = function(self, ply)
			self.ply = ply
			return _class_0.__parent.__init(self, self.ply)
		end,
		__base = _base_0,
		__name = "UNLOAD",
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
	UNLOAD = _class_0
end
local COMBINE
local _class_0
local _parent_0 = ACT
local _base_0 = {
	Immobilizes = false,
	Impossible = function(self)
		local wielding, wielding_off = self.ply:Wielding(), self.ply:WieldingOffhand()
		if not (IsValid(wielding) and IsValid(wielding_off)) then
			return true
		end
	end,
	Do = function(self, fromstate)
		local sequence, cycle_start, cycle_combine = 'reload_dual', .7, .8
		if (CLIENT and IsFirstTimePredicted()) or SERVER then
			self:Spasm({
				sequence = sequence,
				start = cycle_start
			})
		end
		return self:CYCLE(cycle_combine, function(self)
			if SERVER then
				local wielding, wielding_off = self.ply:Wielding(), self.ply:WieldingOffhand()
				if not (IsValid(wielding) and IsValid(wielding_off)) then
					return
				end
				if wielding_off.UsedOnOther then
					if wielding_off:UsedOnOther(self.ply, wielding) then
						return self:Kill()
					end
				end
				if wielding.UsedOnOther then
					if wielding:UsedOnOther(self.ply, wielding_off) then
						return self:Kill()
					end
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
	__init = function(self, ply)
		self.ply = ply
		return _class_0.__parent.__init(self, self.ply)
	end,
	__base = _base_0,
	__name = "COMBINE",
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
COMBINE = _class_0
return _class_0
