local Food
do
	local _class_0
	local _parent_0 = THING
	local _base_0 = {
		SetupDataTables = function(self)
			_class_0.__parent.__base.SetupDataTables(self)
			return self:AddNetworkVar('Bool', 'Rotten')
		end,
		Model = Model('models/props_junk/garbage_plasticbottle002a.mdl'),
		Spawnable = true,
		Sound = Sound('npc/barnacle/barnacle_crunch2.wav'),
		ImpactSound = Sound('physics/flesh/flesh_squishy_impact_hard2.wav'),
		Hunger = 0,
		Fatigue = 0,
		Poison = 0,
		Thirst = 0,
		HealthAdd = 0,
		RotTime = 0,
		IName = 'food',
		ProcessIName = function(self, text)
			_class_0.__parent.__base.ProcessIName(self)
			if (self.GetRotten ~= nil) then
				text = "rotten " .. tostring(text)
			end
			return text
		end,
		Eat = function(self, ply)
			if CLIENT then
				return
			end
			if self.Hunger ~= 0 then
				ply:AddStatus(STATUS_HUNGER, self.Hunger)
			end
			if self.Fatigue ~= 0 then
				ply:AddStatus(STATUS_FATIGUE, self.Fatigue)
			end
			if self.Poison ~= 0 then
				ply:AddStatus(STATUS_POISON, self.Poison)
			end
			if self.Thirst ~= 0 then
				ply:AddStatus(STATUS_THIRST, self.Thirst)
			end
			if self.HealthAdd ~= 0 then
				ply:SetHealth(math.min(ply:Health() + self.HealthAdd, ply:GetMaxHealth()))
			end
			self:EmitSound(self.Sound)
			if self:GetRotten() then
				ply:AddStatus(STATUS_POISON, 1)
			end
			if not self.PersistAfterEat then
				return self:Remove()
			end
		end,
		Used = function(self, ply)
			return self:Eat(ply)
		end,
		UsedOnOther = function(self, ply, ent)
			if CLIENT then
				return
			end
			if ent:IsPlayer() then
				self:Eat(ent)
			end
			if ent.AcceptsFood and not ent:GetFull() and not self.NonIngredient then
				ply:Spasm({
					sequence = 'gesture_item_give',
					SS = true
				})
				ply:GetInventory():RemoveItem(self)
				ent:AddFood(self)
				return true
			end
		end,
		OnSpawned = function(self)
			_class_0.__parent.__base.OnSpawned(self)
			self:SetRotten(false)
			if self.RotTime > 0 then
				self.RotsIn = CurTime() + self.RotTime
			end
			return
		end,
		Think = function(self)
			_class_0.__parent.__base.Think(self)
			if CLIENT then
				return
			end
			if self.RotsIn and (not self:GetRotten()) and self.RotsIn < CurTime() then
				return self:Rot()
			end
		end,
		Rot = function(self)
			self:SetRotten(true)
			self:SetColor(Color(100, 0, 150))
			return self:EmitSound("FoodRot")
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
		__name = "Food",
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
	Food = _class_0
end
local PurifiedWater
do
	local _class_0
	local _parent_0 = Food
	local _base_0 = {
		IName = 'purified.water',
		Model = 'models/props_junk/PopCan01a.mdl',
		Sound = Sound('npc/barnacle/barnacle_gulp2.wav'),
		Thirst = -1
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
		__name = "Purified.Water",
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
	PurifiedWater = _class_0
end

local DirtyWater
do
	local _class_0
	local _parent_0 = Food
	local _base_0 = {
		IName = 'dirty.water',
		Model = 'models/props_junk/PopCan01a.mdl',
		Sound = Sound('npc/barnacle/barnacle_gulp2.wav'),
		Thirst = -1
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
		__name = "Dirty.Water",
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
	DirtyWater = _class_0
end

local Vodka
do
	local _class_0
	local _parent_0 = Food
	local _base_0 = {
		IName = 'distilled.vodka',
		Model = 'models/spec45as/stalker/items/vodka.mdl',
		Sound = Sound('npc/barnacle/barnacle_gulp2.wav'),
		Thirst = -5
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
		__name = "Distilled.Vodka",
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
	Vodka = _class_0
end

local Beans
do
	local _class_0
	local _parent_0 = Food
	local _base_0 = {
		IName = 'beans',
		Model = 'models/props_junk/garbage_metalcan002a.mdl',
		Hunger = -1,
		RotTime = 600
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
		__name = "Beans",
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
	Beans = _class_0
end
local Bandage
do
	local _class_0
	local _parent_0 = Food
	local _base_0 = {
		IName = 'skin bandage',
		Model = 'models/props/bandage.mdl',
		Material = 'props/medkit1',
		Sound = Sound('physics/flesh/flesh_impact_hard4.wav'),
		HealthAdd = 50,
		Poison = -2,
		NonIngredient = true
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
		__name = "Bandage",
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
	Bandage = _class_0
end
local Kibble
do
	local _class_0
	local _parent_0 = Food
	local _base_0 = {
		IName = 'kibble',
		Model = 'models/props_junk/garbage_bag001a.mdl',
		Hunger = -1,
		RotTime = 60
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
		__name = "Kibble",
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
	Kibble = _class_0
end
local Poison
do
	local _class_0
	local _parent_0 = Kibble
	local _base_0 = {
		Poison = 1
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
local Magick
do
	local _class_0
	local _parent_0 = Beans
	local _base_0 = {
		Model = 'models/props_junk/garbage_metalcan002a.mdl',
		HealthAdd = 30
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
		__name = "Magick",
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
	Magick = _class_0
end
local Meat
do
	local _class_0
	local _parent_0 = Food
	local _base_0 = {
		IName = 'meat',
		Model = 'models/props/sausage.mdl',
		Material = 'props/food',
		Hunger = -1,
		RotTime = 120,
		RuinedResult = 'thing/food/meat/gore'
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
		__name = "Meat",
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
	Meat = _class_0
end

local HumanSausage
do
	local _class_0
	local _parent_0 = Meat
	local _base_0 = {
		IName = 'human.sausage',
		Model = 'models/props/sausage.mdl',
		Material = 'props/food',
		Hunger = -2,
		RotTime = 120,
		RuinedResult = 'thing/food/meat/gore'
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
		__name = "Human.Sausage",
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
	HumanSausage = _class_0
end

local HumanSausageBread
do
	local _class_0
	local _parent_0 = Meat
	local _base_0 = {
		IName = 'human.sausage.bread',
		Model = 'models/spec45as/stalker/items/bread.mdl',
		Material = 'props/food',
		Hunger = -5,
		RotTime = 120,
		RuinedResult = 'thing/food/meat/gore'
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
		__name = "Human.Sausage.Bread",
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
	HumanSausageBread = _class_0
end

local Human
do
	local _class_0
	local _parent_0 = Meat
	local _base_0 = {
		IName = 'meat?'
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
		__name = "Human",
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
	Human = _class_0
end

local Gore
do
	local _class_0
	local _parent_0 = Meat
	local _base_0 = {
		IName = 'gore',
		Model = 'models/in/gibs/human/mgib_02.mdl',
		Material = '',
		Poison = 2,
		RotTime = 60
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
		__name = "Gore",
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
	Gore = _class_0
end

local BloodClot
do
	local _class_0
	local _parent_0 = Meat
	local _base_0 = {
		IName = 'blood.clot',
		Model = 'models/in/gibs/human/mgib_02.mdl',
		Material = '',
		Poison = 3,
		RotTime = 60
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
		__name = "Blood.Clot",
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
	BloodClot = _class_0
end

local Char
do
	local _class_0
	local _parent_0 = Gore
	local _base_0 = {
		IName = 'char',
		Color = Color(50, 50, 50),
		Poison = 2,
		RotTime = 900
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
		__name = "Char",
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
	Char = _class_0
end
local FoodRot
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = (function()
			local _accum_0 = { }
			local _len_0 = 1
			for i = 1, 3 do
				_accum_0[_len_0] = "weapons/bugbait/bugbait_squeeze" .. tostring(i) .. ".wav"
				_len_0 = _len_0 + 1
			end
			return _accum_0
		end)(),
		level = SNDLVL_50dB
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
		__name = "FoodRot",
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
	FoodRot = _class_0
end
local Bowl
local _class_0
local _parent_0 = Food
local _base_0 = {
	IName = 'bowl',
	Model = 'models/props_junk/garbage_takeoutcarton001a.mdl',
	RotTime = 0,
	PersistAfterEat = true,
	NonIngredient = true,
	SetupDataTables = function(self)
		_class_0.__parent.__base.SetupDataTables(self)
		return self:AddNetworkVar('String', 'SoupName')
	end,
	Empty = function(self)
		self.Hunger = 0
		self.Fatigue = 0
		self.Poison = 0
		self.Thirst = 0
		self.HealthAdd = 0
		self.RotTime = 0
		self:SetRotten(false)
		self:SetColor(Color(255, 255, 255))
		return self:SetSoupName('')
	end,
	OnSpawned = function(self)
		_class_0.__parent.__base.OnSpawned(self)
		return self:Empty()
	end,
	Eat = function(self, ply)
		if self:GetSoupName() == '' then
			return
		end
		_class_0.__parent.__base.Eat(self, ply)
		return self:Empty()
	end,
	GetValue = function(self, potval)
		if potval == 0 then
			return 0
		elseif potval > 0 then
			return -1
		else
			return 1
		end
	end,
	UsedOnOther = function(self, ply, ent)
		if CLIENT then
			return
		end
		if ent.BowlScoopable and ent:GetSoupName() ~= "" and self:GetSoupName() == "" then
			self:SetSoupName(ent:GetSoupName())
			local empty = true
			local val = self:GetValue(ent.Hunger)
			ent.Hunger = ent.Hunger + val
			self.Hunger = self.Hunger + (val * -1)
			if not (val == 0) then
				empty = false
			end
			val = self:GetValue(ent.Fatigue)
			ent.Fatigue = ent.Fatigue + val
			self.Fatigue = self.Fatigue + (val * -1)
			if not (val == 0) then
				empty = false
			end
			val = self:GetValue(ent.Poison)
			ent.Poison = ent.Poison + val
			self.Poison = self.Poison + (val * -1)
			if not (val == 0) then
				empty = false
			end
			val = self:GetValue(ent.Thirst)
			ent.Thirst = ent.Thirst + val
			self.Thirst = self.Thirst + (val * -1)
			if not (val == 0) then
				empty = false
			end
			if empty then
				return ent:Empty()
			end
		end
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
	__name = "Bowl",
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
Bowl = _class_0
return _class_0
