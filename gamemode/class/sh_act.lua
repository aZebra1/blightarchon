local upper = string.upper
local insert = table.insert
local _class_0
local _base_0 = {
	Do = function(self) end,
	Then = function(self)
		return self:Kill()
	end,
	Impossible = function(self)
		return false
	end,
	Spasm = function(self, choreo)
		choreo.slot = choreo.slot or GESTURE_SLOT_CUSTOM
		self.sequence = self.ply:FindSequence(choreo.sequence)
		choreo.speed = choreo.speed or 1
		self.speed = choreo.speed
		self.slot = choreo.slot
		return self.ply:Spasm(choreo)
	end,
	Kill = function(self)
		self.ply.Doing = nil
		if self.ply:KeyDown(IN_ATTACK2) then
			self.ply:AlterState(STATE.PRIMED)
		else
			self.ply:EndState()
		end
		return true
	end,
	EmitSound = function(self, ...)
		return self.ply:GetActiveWeapon():EmitSound(...)
	end,
	CYCLE = function(self, cycle, func)
		return insert(self.events, {
			cycle,
			func
		})
	end,
	Think = function(self)
		if not (self.ply and IsValid(self.ply)) then
			return self:Kill()
		end
		if self.sequence and self.slot then
			local events = { }
			if self.events then
				local _list_0 = self.events
				for _index_0 = 1, #_list_0 do
					local event = _list_0[_index_0]
					if event[1] < self.ply:GetLayerCycle(self.slot) then
						event[2](self)
					else
						insert(events, event)
					end
					self.events = events
				end
			end
			if self.Then then
				if self.ply:GetLayerSequence(self.slot) ~= self.sequence then
					return self:Then()
				end
			end
		end
	end,
	Immobilizes = true
}
if _base_0.__index == nil then
	_base_0.__index = _base_0
end
_class_0 = setmetatable({
	__init = function(self, ply)
		self.ply = ply
		self.events = { }
	end,
	__base = _base_0,
	__name = "ACT"
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
self.acts = { }
self.__inherited = function(self, child)
	local name = child.__name
	if self ~= ACT then
		name = tostring(self.__name) .. "_" .. tostring(name)
	end
	ACT[upper(name)] = insert(self.acts, child)
	return #self.acts
end
ACT = _class_0
