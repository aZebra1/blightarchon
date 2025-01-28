local upper = string.upper
local insert = table.insert
HULL_HUMAN_MIN = Vector(-16, -16, 0)
HULL_HUMAN_MAX_SQUAT = Vector(16, 16, 36)
HULL_HUMAN_MAX_PRONE = Vector(16, 16, 20)
STANCE_RISEN, STANCE_SQUAT, STANCE_PRONE = 1, 2, 3
local STANCE
do
	local _class_0
	local _parent_0 = ACT
	local _base_0 = {
		Immobilizes = true
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
		__name = "STANCE",
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
	local self = _class_0;
	self.__inherited = function(self, child)
		STANCE[upper(child.__name)] = _class_0.__parent.__inherited(self, child)
	end
	if _parent_0.__inherited then
		_parent_0.__inherited(_parent_0, _class_0)
	end
	STANCE = _class_0
end
local RISEN
do
	local _class_0
	local _parent_0 = STANCE
	local _base_0 = {
		Do = function(self)
			if self.ply:StanceIs(STANCE_RISEN) then
				return
			end
			local anims = {
				[STANCE_SQUAT] = 'crouch_to_stand',
				[STANCE_PRONE] = 'proneup_stand'
			}
			self:Spasm({
				sequence = anims[self.ply:GetStance()]
			})
			self.ply:SetStance(STANCE_RISEN)
			self.ply:ResetHull()
			return self.ply:SetHoldingDown(false)
		end,
		Impossible = function(self)
			local pos = self.ply:GetPos()
			local high
			if self.ply:StanceIs(STANCE_SQUAT) then
				high = 36
			elseif self.ply:StanceIs(STANCE_PRONE) then
				high = 56
			end
			local tr = util.TraceEntity({
				start = pos,
				endpos = pos + Vector(0, 0, high),
				filter = self.ply
			}, self.ply)
			if tr.Hit then
				return true
			end
			return false
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
		__name = "RISEN",
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
	RISEN = _class_0
end
local SQUAT
do
	local _class_0
	local _parent_0 = STANCE
	local _base_0 = {
		Do = function(self)
			if self.ply:StanceIs(STANCE_SQUAT) then
				return
			end
			local anims = {
				[STANCE_RISEN] = 'stand_to_crouch',
				[STANCE_PRONE] = 'proneup_crouch'
			}
			self:Spasm({
				sequence = anims[self.ply:GetStance()]
			})
			self.ply:SetStance(STANCE_SQUAT)
			self.ply:SetHull(HULL_HUMAN_MIN, HULL_HUMAN_MAX_SQUAT)
			return self.ply:SetHoldingDown(false)
		end,
		Then = function(self)
			_class_0.__parent.__base.Then(self)
			if BIND.controls['ctrl']:IsDown(self.ply) then
				return self.ply:SetHoldingDown(true)
			end
		end,
		Impossible = function(self)
			if self.ply:StanceIs(STANCE_PRONE) then
				local pos = self.ply:GetPos()
				local tr = util.TraceEntity({
					start = pos,
					endpos = pos + Vector(0, 0, 16),
					filter = self.ply
				}, self.ply)
				if tr.Hit then
					return true
				end
				return false
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
		__name = "SQUAT",
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
	SQUAT = _class_0
end
local PRONE
do
	local _class_0
	local _parent_0 = STANCE
	local _base_0 = {
		Do = function(self)
			if self.ply:StanceIs(STANCE_PRONE) then
				return
			end
			local anims = {
				[STANCE_RISEN] = 'pronedown_stand',
				[STANCE_SQUAT] = 'pronedown_crouch'
			}
			self:Spasm({
				sequence = anims[self.ply:GetStance()]
			})
			self.ply:SetStance(STANCE_PRONE)
			self.ply:SetHull(HULL_HUMAN_MIN, HULL_HUMAN_MAX_PRONE)
			return self.ply:SetHoldingDown(false)
		end,
		Then = function(self)
			_class_0.__parent.__base.Then(self)
			if BIND.controls['space']:IsDown(self.ply) then
				return self.ply:SetHoldingDown(true)
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
		__name = "PRONE",
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
	PRONE = _class_0
	return _class_0
end
