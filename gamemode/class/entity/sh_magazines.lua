local _anon_func_0 = function(ent, self)
	local _check_0 = ent.AcceptableMagazines
	local _val_0 = self:GetClass()
	for _index_0 = 1, #_check_0 do
		if _check_0[_index_0] == _val_0 then
			return true
		end
	end
	return false
end
local Magazine
do
	local _class_0
	local _parent_0 = THING
	local _base_0 = {
		IName = 'magazine',
		Element = 'metal/scrap',
		SetupDataTables = function(self)
			_class_0.__parent.__base.SetupDataTables(self)
			return self:AddNetworkVar('Int', 'Rounds')
		end,
		GetAlignmentOffset = function(self, holder)
			local cls = holder:GetClass()
			if cls:starts('thing/firearm') then
				return holder.MagazineOffset.Pos, holder.MagazineOffset.Ang
			end
		end,
		AddRounds = function(self, added)
			local new = math.min(self:GetRounds() + added, self.Capacity)
			new = math.max(0, new)
			return self:SetRounds(new)
		end,
		Capacity = 23,
		ProcessIName = function(self, ...)
			local text = _class_0.__parent.__base.ProcessIName(self, ...)
			text = text .. ", " .. tostring(self:GetRounds()) .. "/" .. tostring(self.Capacity)
			return text
		end,
		UsedOnOther = function(self, ply, ent)
			if CLIENT then
				return
			end
			if not ent.GetMagazine then
				return
			end
			if not (ent.AcceptableMagazines and _anon_func_0(ent, self)) then
				return
			end
			if IsValid(ent:GetMagazine()) then
				return
			end
			ply:Spasm({
				sequence = 'gesture_item_give',
				SS = true
			})
			ply:GetInventory():RemoveItem(self)
			ent:SetMagazine(self)
			return true
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
		__name = "Magazine",
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
	Magazine = _class_0
end
local Pistol
do
	local _class_0
	local _parent_0 = Magazine
	local _base_0 = {
		IName = 'pistol magazine'
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
		__name = "Pistol",
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
	Pistol = _class_0
end
local Pacifier15rd
local _class_0
local _parent_0 = Magazine
local _base_0 = {
	IName = '15rd pacifier magazine',
	Model = Model("models/weapons/act3/mag_m9_15.mdl"),
	Capacity = 15,
	Caliber = '9mmLiver'
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
	__name = "Pacifier15rd",
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
Pacifier15rd = _class_0
return _class_0
