local Victim
local _class_0
local _parent_0 = PLYCLASS
local _base_0 = {
	WalkSpeed = 80,
	RunSpeed = 160,
	Loadout = function(self)
		self.Player:SetState(STATE.IDLE)
		self.Player:SetStance(STANCE_RISEN)
		return timer.Simple(0.1, function()
			self.Player:Give('hands', true)
			return INVENTORY_SLOTTED(self.Player)
		end)
	end,
	SetModel = function(self)
		return self.Player:SetModel("models/in/player/everyman.mdl")
	end,
	StartCommand = function(self, cmd)
		if self.Player:GetBodyEntity() ~= self.Player then
			return cmd:ClearMovement()
		elseif self.Player.GetState then
			local state = self.Player:GetStateTable()
			if state then
				if state.StartCommand then
					return state:StartCommand(self.Player, cmd)
				end
			end
		end
	end,
	DataTables = {
		String = {
			'RPName'
		},
		Entity = {
			'Ragdoll',
			'StateEntity',
			'Dragging'
		},
		Bool = {
			'IsRagdoll',
			'Watching',
			'HoldingDown',
			'Chatting'
		},
		Float = {
			'Speed',
			'SpeedTarget',
			'StateStart',
			'StateEnd',
			'StateNumber'
		},
		Int = {
			'State',
			'Stance',
			'Caste',
			'Fate'
		},
		Vector = {
			'StateVector'
		},
		Angle = {
			'StateAngles'
		}
	},
	SetupDataTables = function(self)
		for var_type, vars in pairs(self.DataTables) do
			local idx = 0
			for _index_0 = 1, #vars do
				local var = vars[_index_0]
				self.Player:NetworkVar(var_type, idx, var)
				idx = idx + 1
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
	__name = "Victim",
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
Victim = _class_0
return _class_0
