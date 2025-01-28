local SLOT_SOUP_1 = 1
local SLOT_SOUP_2 = 2
local SLOT_SOUP_3 = 3
local SLOT_SOUP_4 = 4
local Soup
local _class_0
local _parent_0 = THING
local _base_0 = {
	IName = 'soup pot',
	Model = 'models/props_c17/metalPot001a.mdl',
	Element = 'metal/iron',
	Durability = 100,
	AcceptsFood = true,
	BowlScoopable = true,
	MaxSlots = 4,
	Initialize = function(self)
		_class_0.__parent.__base.Initialize(self)
		if SERVER then
			return INVENTORY(self)
		end
	end,
	SetupDataTables = function(self)
		_class_0.__parent.__base.SetupDataTables(self)
		self:AddNetworkVar('Bool', 'Rotten')
		return self:AddNetworkVar('String', 'SoupName')
	end,
	GetFull = function(self)
		for i = 1, self.MaxSlots do
			if not self:GetInventory():HasItem(i) then
				return false
			end
		end
		return true
	end,
	GetFree = function(self)
		for i = 1, self.MaxSlots do
			if not self:GetInventory():HasItem(i) then
				return i
			end
		end
	end,
	AddFood = function(self, food)
		return self:GetInventory():AddItem(food, self:GetFree())
	end,
	GetInventoryPosition = function(self)
		return self:GetPos(), self:GetAngles()
	end,
	Empty = function(self)
		self.Hunger = 0
		self.Fatigue = 0
		self.Poison = 0
		self.Thirst = 0
		self.HealthAdd = 0
		self:SetColor(Color(255, 255, 255))
		return self:SetSoupName('')
	end,
	Used = function(self, ply)
		if CLIENT then
			return
		end
		return self:Brew()
	end,
	Brew = function(self)
		if not self:GetFull() then
			return
		end
		self.Hunger = 0
		self.Fatigue = 0
		self.Poison = 0
		self.Thirst = 0
		for i = 1, self.MaxSlots do
			local food = self:GetInventory():GetItem(i)
			self.Hunger = self.Hunger + food.Hunger
			self.Poison = self.Poison + math.max(0, food.Poison - 1)
			self.Fatigue = self.Fatigue + food.Fatigue
			self.Thirst = self.Thirst + (food.Thirst - 1)
			food:Remove()
		end
		return self:SetSoupName('soup')
	end,
	ProcessIName = function(self, ...)
		local text = _class_0.__parent.__base.ProcessIName(self, ...)
		if self.GetSoupName ~= '' then
			text = text .. " of " .. tostring(self:GetSoupName())
		end
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
	__name = "Soup",
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
Soup = _class_0
return _class_0
