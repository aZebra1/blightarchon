local Fatigue
do
	local _class_0
	local _parent_0 = STATUS
	local _base_0 = {
		desc = "Fate will run its course; you will be dust.",
		icon = Material("skeleton/icons/status/fatigue.png"),
		interval = 1,
		Overflow = function(self, ply)
			return ply:BecomeRagdoll()
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
			ply.StatusBuildup = ply.StatusBuildup or { }
			if not ply.StatusBuildup[self.index] then
				ply.StatusBuildup[self.index] = 0
			end
			local Clamp = math.Clamp
			if CurTime() >= ply.StatusTicks[self.index] then
				ply.StatusTicks[self.index] = CurTime() + self.interval
				local speed_target = ply:GetSpeedTarget()
				local amt
				if ply:GetIsRagdoll() then
					amt = -8
				else
					local vel = ply:GetVelocity()
					if vel:Length2D() < 100 then
						amt = -5
					else
						amt = speed_target / 100
					end
				end
				if (amt > 0 and amt < 5) then
					amt = 0
				end
				amt = amt + (ply:WaterLevel() * 2)
				ply.StatusBuildup[self.index] = Clamp(ply.StatusBuildup[self.index] + amt, 0, 100)
				local final = ply.StatusBuildup[self.index]
				if final >= 100 or final <= 0 then
					if final >= 100 then
						ply:AddStatus(self.index, 1)
						ply.StatusBuildup[self.index] = 20
					else
						ply:AddStatus(self.index, -1)
						ply.StatusBuildup[self.index] = 99
					end
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
		__name = "Fatigue",
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
	Fatigue = _class_0
end
STATUS_FATIGUE = Fatigue.index
