local meta = FindMetaTable('Player')
for k, v in pairs({
	GetStateTable = function(self)
		return STATE.states[self:GetState()]
	end,
	AlterState = function(self, state, seconds, ent, abrupt)
		local oldstate = self:GetState()
		if oldstate ~= state and not abrupt then
			STATE.states[oldstate]:Exit(self, state)
		end
		self:SetState(state)
		self:SetStateStart(CurTime())
		if seconds then
			self:SetStateEnd(CurTime() + seconds)
		else
			self:SetStateEnd(0)
		end
		if ent then
			self:SetStateEntity(ent)
		else
			self:SetStateEntity(NULL)
		end
		if oldstate == state then
			return STATE.states[state]:Continue(self)
		else
			return STATE.states[state]:Enter(self, oldstate)
		end
	end,
	EndState = function(self, abrupt)
		local state
		if self:KeyDown(IN_ATTACK2) then
			state = STATE.PRIMED
		else
			state = STATE.IDLE
		end
		return self:AlterState(state, nil, nil, abrupt)
	end,
	StateIs = function(self, state)
		return self:GetState() == state
	end
}) do
	meta[k] = v
end
local band = bit.band
local _anon_func_0 = function(thing)
	local _obj_0 = thing.Animations
	if _obj_0 ~= nil then
		return _obj_0.idle
	end
	return nil
end
local IDLE
do
	local _class_0
	local _parent_0 = STATE
	local _base_0 = {
		Think = function(self, ply)
			if ply:KeyDown(IN_ATTACK2) then
				return ply:AlterState(STATE.PRIMED)
			end
		end,
		StartCommand = function(self, ply, cmd)
			if band(cmd:GetButtons(), IN_ATTACK) > 0 then
				return cmd:AddKey(IN_USE)
			end
		end,
		CalcMainActivity = function(self, ply, vel)
			local dragging = ply:GetDragging()
			if dragging and IsValid(dragging) then
				return _class_0.__parent.__base.CalcMainActivity(self, ply, vel, ANIMS.deliver_box)
			end
			local thing = ply:Wielding()
			if IsValid(thing) and _anon_func_0(thing) then
				return _class_0.__parent.__base.CalcMainActivity(self, ply, vel, thing.Animations.idle)
			end
			return _class_0.__parent.__base.CalcMainActivity(self, ply, vel)
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
		__name = "IDLE",
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
	IDLE = _class_0
end
local _anon_func_1 = function(ANIMS, BIND, IsValid, ply, thing)
	if IsValid(thing) then
		if BIND.controls['release_right']:IsDown(ply) then
			return thing.Animations.throw
		else
			return thing.Animations.prime
		end
	else
		return ANIMS.fist
	end
end
local PRIMED
do
	local _class_0
	local _parent_0 = STATE
	local _base_0 = {
		Think = function(self, ply)
			if not ply:KeyDown(IN_ATTACK2) then
				return ply:EndState()
			end
		end,
		CalcMainActivity = function(self, ply, vel)
			local thing = ply:Wielding()
			return _class_0.__parent.__base.CalcMainActivity(self, ply, vel, _anon_func_1(ANIMS, BIND, IsValid, ply, thing))
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
		__name = "PRIMED",
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
	PRIMED = _class_0
end
local _anon_func_2 = function(ANIMS, BIND, IsValid, ply, thing)
	if IsValid(thing) then
		if BIND.controls['release_right']:IsDown(ply) then
			return thing.Animations.throw
		else
			return thing.Animations.prime
		end
	else
		return ANIMS.fist
	end
end
local ACTING
do
	local _class_0
	local _parent_0 = STATE
	local _base_0 = {
		Enter = function(self, ply, oldstate)
			if ply.Doing then
				return ply.Doing:Do(oldstate)
			end
		end,
		StartCommand = function(self, ply, cmd)
			if ply:DoingSomething() and ply.Doing then
				if ply.Doing:Impossible() then
					return ply.Doing:Kill()
				end
				if ply.Doing.Immobilizes then
					cmd:ClearMovement()
					return true
				end
				return
			end
		end,
		CalcMainActivity = function(self, ply, vel)
			local thing = ply:Wielding()
			if ply:KeyDown(IN_ATTACK2) then
				return _class_0.__parent.__base.CalcMainActivity(self, ply, vel, _anon_func_2(ANIMS, BIND, IsValid, ply, thing))
			else
				return _class_0.__parent.__base.CalcMainActivity(self, ply, vel)
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
		__name = "ACTING",
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
	ACTING = _class_0
end
local State
local _class_0
local _parent_0 = MODULE
local _base_0 = {
	CalcMainActivity = function(self, ply, vel)
		if not (ply.GetState and ply.GetStateTable) then
			return
		end
		do
			local _tmp_0 = -1
			ply.CalcIdeal = _tmp_0
			ply.CalcSeqOverride = _tmp_0
		end
		ply.m_bWasOnGround = ply:IsOnGround()
		ply.m_bWasNoclipping = ply:GetMoveType() == MOVETYPE_NOCLIP and not ply:InVehicle()
		ply:GetStateTable():CalcMainActivity(ply, vel)
		return ply.CalcIdeal, ply.CalcSeqOverride
	end,
	UpdateAnimation = function(self, ply, vel, maxSeqGroundSpeed)
		local len = vel:Length()
		local rate = 1
		if len > .2 then
			rate = len * .71 / maxSeqGroundSpeed
		end
		rate = math.min(rate, 2)
		if ply:WaterLevel() >= 2 then
			rate = math.max(rate, .5)
		end
		if ply:IsOnGround() and len >= 1000 then
			rate = .1
		end
		return ply:SetPlaybackRate(rate)
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
	__name = "State",
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
State = _class_0
return _class_0
