local Poison
do
	local _class_0
	local _parent_0 = STATUS
	local _base_0 = {
		desc = "It will be the death of you.",
		icon = Material("skeleton/icons/status/poison.png"),
		interval = 10,
		damage = 15,
		Overflow = function(self, ply)
			return ply:TakeDamage(self.damage)
		end,
		Think = function(self, ply)
			if not SERVER then
				return
			end
			if not ply:Alive() then
				return
			end
			ply.StatusTicks = ply.StatusTicks or { }
			if not ply.StatusTicks[self.index] then
				ply.StatusTicks[self.index] = CurTime() + self.interval
			end
			if CurTime() >= ply.StatusTicks[self.index] then
				ply.StatusTicks[self.index] = CurTime() + self.interval
				local active = ply:Status(self.index) > 0
				if ply:WaterLevel() > 0 then
					active = false
				end
				if active then
					local dmg = DamageInfo()
					dmg:SetDamageType(DMG_ACID)
					dmg:SetDamage(self.damage)
					dmg:SetAttacker(ply)
					dmg:SetInflictor(ply)
					ply:TakeDamageInfo(dmg)
					ply:AddStatus(self.index, -1)
					return dmg
				else
					return ply:AddStatus(self.index, ply:WaterLevel())
				end
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
		__name = "Poison",
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
	Poison = _class_0
end
STATUS_POISON = Poison.index
