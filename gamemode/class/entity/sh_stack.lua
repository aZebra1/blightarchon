local STACK
local _class_0
local _parent_0 = THING
local _base_0 = {
	SetupDataTables = function(self)
		_class_0.__parent.__base.SetupDataTables(self)
		return self:AddNetworkVar('Int', 'Amount')
	end,
	AddAmount = function(self, added)
		local new = math.min(self:GetAmount() + added, self.Maximum)
		new = math.max(0, new)
		if new <= 0 then
			self:Remove()
		end
		return self:SetAmount(new)
	end,
	Maximum = 10,
	SpawnWith = {
		1,
		10
	},
	OnSpawned = function(self)
		local start_amount = self.SpawnWith
		if istable(self.SpawnWith) then
			start_amount = math.random(self.SpawnWith[1], self.SpawnWith[2])
		end
		return self:SetAmount(start_amount)
	end,
	UsedOnOther = function(self, ply, ent)
		if CLIENT then
			return
		end
		if not (ent:GetClass() == self:GetClass()) then
			return
		end
		if ent:GetAmount() == ent.Maximum then
			return
		end
		local current_amt = self:GetAmount()
		local other_amt = ent:GetAmount()
		local amt = math.min(current_amt, ent.Maximum - other_amt)
		if not (ply:IsHolding(self) and ply:IsHolding(ent)) then
			ply:Spasm({
				sequence = 'gesture_item_give',
				SS = true
			})
		end
		ent:AddAmount(amt)
		self:AddAmount(-amt)
		return true
	end,
	ProcessIName = function(self, ...)
		local text = _class_0.__parent.__base.ProcessIName(self, ...)
		text = text .. ", " .. tostring(self:GetAmount()) .. "/" .. tostring(self.Maximum)
		return text
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
	__name = "STACK",
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
STACK = _class_0
THING.STACK = _class_0
