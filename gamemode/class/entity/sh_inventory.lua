SLOT_HAND = 1
SLOT_OFFHAND = 2
SLOT_OUTFIT = 3
SLOT_BELT_L = 4
SLOT_BELT_R = 5
SLOT_BACK = 6
SLOT_POCKET1 = 7
SLOT_POCKET2 = 8
SLOT_POCKET3 = 9
SLOT_POCKET4 = 10
for k, v in pairs({
	InventoryCanRemove = function(self, ply, inv, item)
		return hook.Run('CanInteract', ply, inv) and inv:CanRemoveItem(item)
	end,
	InventoryCanAccept = function(self, ply, inv, item, slot)
		return hook.Run('CanInteract', ply, inv) and inv:CanAcceptItem(item, slot)
	end,
	InventoryItemChanged = function(self, inv, slot, old, new)
		local owner = inv:GetOwner()
		local hands
		if owner:IsPlayer() and slot == SLOT_HAND then
			hands = owner:GetHands()
		end
	end
}) do
	GM[k] = v
end
do
	local _class_0
	local _parent_0 = ENTITY
	local _base_0 = {
		Base = 'base_point',
		Type = 'point',
		Assign = function(self, ent, index)
			self:SetParent(ent)
			self:SetOwner(ent)
			return ent:SetNWEntity('ThingInventory', self)
		end,
		SetupDataTables = function(self)
			for i = 0, 31 do
				self:NetworkVar('Entity', i, "Slot" .. tostring(i + 1))
			end
		end,
		HasSlot = function(self, slot)
			return slot > 0 and slot <= 32
		end,
		GetSlot = function(self, slot)
			return self["GetSlot" .. tostring(slot)](self)
		end,
		SetSlot = function(self, slot, item)
			return self["SetSlot" .. tostring(slot)](self, item)
		end,
		HasItem = function(self, slot)
			return IsValid(self:GetItem(slot))
		end,
		GetItem = function(self, slot)
			return self:GetSlot(slot)
		end,
		SetItem = function(self, item, slot)
			local old = self:GetItem(slot)
			self:SetSlot(slot, item)
			return hook.Run('InventoryItemChanged', self, slot, old, item)
		end,
		GetItemSlot = function(self, item)
			return item:GetInventorySlot()
		end,
		AddItem = function(self, item, slot)
			self:SetItem(item, slot)
			item:SetInventoryEntity(self)
			item:SetInventorySlot(slot)
			item:SetParent(self)
			item:SetLocalPos(Vector())
			item:SetLocalAngles(Angle())
			item:DrawShadow(false)
			item:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
			if SERVER then
				item:GetPhysicsObject():EnableMotion(false)
				item:SetTrigger(false)
			end
			return item
		end,
		RemoveItem = function(self, item)
			if item:GetInventoryEntity() ~= self then
				return
			end
			return self:SetItem(NULL, item:GetInventorySlot())
		end,
		CanInteract = function(self, ply)
			return true
		end,
		CanAcceptItem = function(self, item, slot)
			return not self:HasItem(slot)
		end,
		CanRemoveItem = function(self, item)
			return true
		end,
		UpdateTransmitState = function(self)
			return TRANSMIT_PVS
		end,
		OnRemove = function(self)
			if SHUTTING_DOWN then
				return
			end
			for i = 1, 32 do
				local item = self:GetSlot(i)
				if IsValid(item) then
					item:MoveToWorld(item:GetPos(), item:GetAngles())
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
		__init = function(self, where)
			assert(isentity(where), 'arg 1 must be an entity')
			self:Spawn()
			self:Activate()
			return self:Assign(where)
		end,
		__base = _base_0,
		__name = "INVENTORY",
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
	self.__entity = 'inventory'
	if _parent_0.__inherited then
		_parent_0.__inherited(_parent_0, _class_0)
	end
	INVENTORY = _class_0
end
do
	local _class_0
	local _parent_0 = INVENTORY
	local _base_0 = {
		GetLayout = function(self)
			local owner = self:GetOwner()
			if owner and owner.GetInventoryLayout then
				return owner:GetInventoryLayout()
			end
		end,
		HasSlot = function(self, slot)
			local layout = self:GetLayout()
			if layout then
				return tobool(self:GetLayout()[slot])
			end
		end,
		GetItem = function(self, slot)
			local layout = self:GetLayout()
			if layout then
				return self:GetSlot(self:GetLayout()[slot])
			end
		end,
		SetItem = function(self, item, slot)
			local old = self:GetItem(slot)
			self:SetSlot(self:GetLayout()[slot], item)
			return hook.Run('InventoryItemChanged', self, slot, old, item)
		end,
		AddItem = function(self, item, slot)
			if SLOT_HAND == slot or SLOT_OFFHAND == slot or SLOT_BELT_L == slot or SLOT_BELT_R == slot then
				self:SetItem(item, slot)
				item:SetInventoryEntity(self)
				item:SetInventorySlot(slot)
				item:SetParent(NULL)
				item:DrawShadow(true)
				item:SetCollisionGroup(COLLISION_GROUP_WORLD)
				item:AlignToOwner()
				item:GetPhysicsObject():EnableMotion(false)
				return item
			else
				return _class_0.__parent.__base.AddItem(self, item, slot)
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
		__name = "INVENTORY_SLOTTED",
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
	INVENTORY_SLOTTED = _class_0
end
