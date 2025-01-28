local random = math.random
local Empty = table.Empty
local TraceHull, TraceLine, GetSurfaceData = util.TraceHull, util.TraceLine, util.GetSurfaceData
for k, v in pairs({
	CanInteract = function(self, ply, ent)
		if ent.CanInteract then
			return ent:CanInteract(ply)
		end
		return true
	end,
	ItemAllowMove = function(self, ply, item, inv, slot)
		if not hook.Run('CanInteract', ply, item) then
			return false
		end
		local old_inv = item:GetInventoryEntity()
		if IsValid(old_inv) and not hook.Run('InventoryCanRemove', ply, old_inv, item) then
			return false
		end
		if IsValid(inv) and not hook.Run('InventoryCanAccept', ply, inv, item, slot) then
			return false
		end
		return true
	end
}) do
	GM[k] = v
end
local meta = FindMetaTable('Player')
for k, v in pairs({
	Wielding = function(self)
		local inv = self:GetInventory()
		if IsValid(inv) and inv.GetItem then
			return inv:GetItem(SLOT_HAND)
		end
	end,
	WieldingOffhand = function(self)
		local inv = self:GetInventory()
		if IsValid(inv) and inv.GetItem then
			return inv:GetItem(SLOT_OFFHAND)
		end
	end,
	BeltItems = function(self)
		local inv = self:GetInventory()
		if not IsValid(inv) then
			return { }
		end
		local items
		do
			local _accum_0 = { }
			local _len_0 = 1
			local _list_0 = {
				SLOT_BELT_L,
				SLOT_BELT_R
			}
			for _index_0 = 1, #_list_0 do
				local slot = _list_0[_index_0]
				if IsValid(inv:GetItem(slot)) then
					_accum_0[_len_0] = inv:GetItem(slot)
					_len_0 = _len_0 + 1
				end
			end
			items = _accum_0
		end
		return items
	end,
	TraceItem = function(self, item, pos, high)
		local start = self:GetViewOrigin()
		local mins, maxs = item:GetRotatedAABB(item:OBBMins(), item:OBBMaxs())
		if high then
			pos = pos - Vector(0, 0, mins.z)
		end
		local tr = TraceHull({
			start = start,
			endpos = pos,
			filter = self:GetTraceFilter(),
			mins = mins,
			maxs = maxs
		})
		return tr
	end,
	Release = function(self, item)
		if not IsValid(item) then
			return
		end
		item:AlignToOwner()
		local tr = self:TraceItem(item, item:WorldSpaceCenter())
		return item:MoveToWorld(item:GetPos(), item:GetAngles())
	end
}) do
	meta[k] = v
end
local emeta = FindMetaTable('Entity')
for k, v in pairs({
	GetInventory = function(self)
		return self:GetNWEntity('ThingInventory')
	end,
	HasInventory = function(self)
		return IsValid(self:GetInventory())
	end
}) do
	emeta[k] = v
end
local _anon_func_0 = function(SLOT_BELT_L, SLOT_BELT_R, SLOT_HAND, SLOT_OFFHAND, self)
	local _val_0 = self:GetInventorySlot()
	return SLOT_HAND == _val_0 or SLOT_OFFHAND == _val_0 or SLOT_BELT_L == _val_0 or SLOT_BELT_R == _val_0
end
local _class_0
local _parent_0 = ENTITY
local _base_0 = {
	Base = 'base_anim',
	Type = 'anim',
	Spawnable = true,
	SetupDataTables = function(self)
		self._NetworkVars = {
			String = 0,
			Bool = 0,
			Float = 0,
			Int = 0,
			Vector = 0,
			Angle = 0,
			Entity = 0
		}
		self:AddNetworkVar('Entity', 'InventoryEntity')
		self:AddNetworkVar('Int', 'InventorySlot')
		self:AddNetworkVar('Int', 'Durability')
		return self:AddNetworkVar('String', 'Element')
	end,
	AddNetworkVar = function(self, var_type, name, extended)
		local index = assert(self._NetworkVars[var_type], tostring(self:GetClass()) .. " attempt to register unknown network var type " .. tostring(var_type))
		local max
		if 'String' == var_type then
			max = 3
		else
			max = 31
		end
		if index >= max then
			error("Network var limit exceeded for " .. tostring(var_type))
		end
		self:NetworkVar(var_type, index, name, extended)
		self._NetworkVars[var_type] = index + 1
	end,
	Name = 'thing',
	Model = Model('models/props_junk/PopCan01a.mdl'),
	Description = 'Wow! I can pick it up and throw it!',
	GetDescription = function(self)
		return self.Description
	end,
	Durability = 50,
	ProcessIName = function(self, text)
		if text == nil then
			text = self:GetClass()
		end
		local el
		do
			local _obj_0 = self.GetElement
			if _obj_0 ~= nil then
				el = _obj_0(self)
			end
		end
		if el and el ~= '' and ELEMENT.registered[el] then
			local element = ELEMENT.registered[self:GetElement()].IName
			text = tostring(element) .. " " .. tostring(text)
		end
		return text
	end,
	TargetInfo = function(self, witness)
		local info = { }
		info[#info + 1] = {
			font = 'spleen_label',
			color = COLOR_BGREEN,
			text = _ud83d_udcbe.Inspect:Inspect(witness, self) or self:GetClass()
		}
		local pos = self:GetPos()
		pos.z = pos.z + 15
		return info, pos
	end,
	OnTakeDamage = function(self, dmg)
		if CLIENT then
			return
		end
		if dmg:IsDamageType(DMG_CRUSH) and not (self.Attributes and self.Attributes['shatters']) then
			return
		end
		if dmg:GetDamageType() == DMG_BURN and self.Flamability and self.Flamability > 0 then
			self:Ignite(self.Flamability / 10, self.Flamability / 5)
		end
		if self:GetHolder():IsValid() then
			return
		end
		self:SetDurability(math.max(self:GetDurability() - dmg:GetDamage(), 0))
		if self:GetDurability() <= 0 then
			return self:Break()
		end
	end,
	Break = function(self, hit_ent)
		if self.Attributes and self.Attributes['shatters'] then
			local effectData = EffectData()
			local pos = self:GetPos()
			effectData:SetStart(pos)
			effectData:SetOrigin(pos)
			effectData:SetScale(8)
			util.Effect('GlassImpact', effectData, true, true)
			self:EmitSound('placenta/weapons/bottle_break.wav')
			if IsValid(hit_ent) then
				local dmg = DamageInfo()
				dmg:SetAttacker(self)
				dmg:SetDamage(self.SizeClass * 25)
				dmg:SetDamageType(DMG_SLASH)
				hit_ent:TakeDamageInfo(dmg)
			end
		end
		return self:Remove()
	end,
	Animations = {
		prime = ANIMS.something,
		throw = ANIMS.throwing
	},
	HandOffset = {
		Pos = Vector(),
		Ang = Angle()
	},
	BeltOffset = {
		Pos = Vector(),
		Ang = Angle()
	},
	HolsterSequence = 'wos_aoc_sword_holster',
	UnholsterSequence = 'draw_melee',
	ImpactSound = 'popcan.impacthard',
	CanInteract = function(self, ply)
		return true
	end,
	OnPrimaryInteract = function(self, tr, ply, hands)
		local ent = tr.Entity
		if IsValid(ent) then
			if self.UsedOnOther then
				self:UsedOnOther(ply, ent)
			end
			return true
		end
	end,
	OnInteract = function(self) end,
	AttackEnabled = true,
	AttackAct = ACT.SWING,
	AttackDamage = 5,
	AttackDamageType = DMG_CLUB,
	AttackDelay = .8,
	AttackRange = 50,
	AttackSound = {
		Swing = 'WeaponFrag.Throw',
		Hit = 'physics/cardboard/cardboard_box_impact_soft1.wav'
	},
	AttackSequence = {
		'melee_1h_overhead',
		'melee_1h_right'
	},
	SizeClass = SIZE_TINY,
	Mass = 1,
	ThrowVelocity = 1000,
	PlaceAngle = Angle(),
	PlaceAngle2 = Angle(),
	Initialize = function(self)
		self:SetModel(self.Model)
		if SERVER then
			self:PhysicsInit(SOLID_VPHYSICS)
			self:SetMoveType(MOVETYPE_VPHYSICS)
			self:SetUseType(SIMPLE_USE)
			self.TouchList = { }
			self:GetPhysicsObject():SetMass(self.Mass)
			if self.SizeClass <= SIZE_SMALL then
				self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			end
			self:SetDurability(self.Durability)
		end
		self:PhysWake()
		if self.Color then
			self:SetColor(self.Color)
		end
		if self.Material then
			self:SetMaterial(self.Material)
		end
		self.VisibleState = true
		if self.Element then
			_ud83d_udcbe.Elements:Assign(self, self.Element)
		end
		return self:OnSpawned()
	end,
	OnSpawned = function(self)
		return true
	end,
	CanBeMoved = function(self)
		return true
	end,
	MoveTo = function(self, ply, inv, slot, force)
		if not force then
			local ok = hook.Run('ItemAllowMove', ply, self, inv, slot)
			if not ok then
				return false
			end
		end
		local old_inv = self:GetInventoryEntity()
		if IsValid(old_inv) then
			old_inv:RemoveItem(self)
		end
		return inv:AddItem(self, slot)
	end,
	MoveToWorld = function(self, pos, ang, force)
		local old_inv = self:GetInventoryEntity()
		if IsValid(old_inv) then
			old_inv:RemoveItem(self)
		end
		return self:AddToWorld(pos, ang)
	end,
	AddToWorld = function(self, pos, ang)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		if SERVER and self.SizeClass > SIZE_SMALL then
			self:CreateTouchList()
		end
		self:SetParent(NULL)
		self:SetInventoryEntity(NULL)
		if SERVER then
			self:SetPos(pos)
			self:SetAngles(ang)
			self:GetPhysicsObject():EnableMotion(true)
			self:PhysWake()
		end
		return self:UpdateVisible()
	end,
	Think = function(self)
		if IsValid(self:GetHolder()) then
			self:AlignToOwner()
		end
		if CLIENT and self:InWorld() and self:IsEFlagSet(61440) then
			self:RemoveEFlags(61440)
		end
		if SERVER then
			return self:UpdateTouchList()
		end
	end,
	GetAlignmentOffset = function(self, holder)
		if holder:IsPlayer() then
			local inv = holder:GetInventory()
			if (holder:BeltItems() == self) then
				if inv:GetSlot(SLOT_BELT_L) == self then
					return self.BeltLeftOffset
				elseif inv:GetSlot(SLOT_BELT_R) == self then
					return self.BeltRightOffset
				end
			else
				return self.HandOffset
			end
		end
	end,
	AlignToOwner = function(self)
		local holder = self:GetHolder()
		if not IsValid(holder) then
			return
		end
		local pos, ang = holder:GetInventoryPosition(self:GetInventorySlot())
		local offset = self:GetAlignmentOffset(holder)
		if offset and offset.Pos then
			pos, ang = LocalToWorld(offset.Pos, offset.Ang, pos, ang)
		end
		self:SetPos(pos)
		return self:SetAngles(ang)
	end,
	GetHolder = function(self)
		local inv = self:GetInventoryEntity()
		if IsValid(inv) then
			return inv:GetParent()
		end
		return NULL
	end,
	InHand = function(self)
		return IsValid(self:GetInventoryEntity()) and self:GetInventorySlot() == SLOT_HAND
	end,
	InOffhand = function(self)
		return IsValid(self:GetInventoryEntity()) and self:GetInventorySlot() == SLOT_OFFHAND
	end,
	InInventory = function(self)
		return IsValid(self:GetInventoryEntity()) and not (_anon_func_0(SLOT_BELT_L, SLOT_BELT_R, SLOT_HAND, SLOT_OFFHAND, self))
	end,
	InWorld = function(self)
		return not IsValid(self:GetInventoryEntity())
	end,
	StartTouch = function(self, ent)
		if SERVER then
			self.TouchList[ent] = true
		end
	end,
	EndTouch = function(self, ent)
		if SERVER then
			self.TouchList[ent] = nil
		end
	end,
	CreateTouchList = function(self)
		if SERVER then
			Empty(self.TouchList)
			self.TriggerActive = true
			return self:SetTrigger(true)
		end
	end,
	UpdateTouchList = function(self)
		if not self.TriggerActive or table.Count(self.TouchList) > 0 then
			return
		end
		self.TriggerActive = false
		self:SetTrigger(false)
		return self:SetCollisionGroup(COLLISION_GROUP_NONE)
	end,
	PhysicsCollide = function(self, data, physobj)
		if data.DeltaTime > .2 and data.Speed > 30 then
			self:EmitSound(self.ImpactSound)
			if self.SizeClass <= SIZE_SMALL then
				self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			end
		end
		if data.DeltaTime > .2 and data.Speed > 120 then
			if self.Attributes and self.Attributes['shatters'] then
				return self:Break(data.HitEntity or NULL)
			end
		end
	end,
	UpdateVisible = function(self)
		local visible = not self:InInventory()
		if visible ~= self.VisibleState then
			self:OnVisibleChanged(visible)
			self.VisibleState = visible
		end
	end,
	GetVisible = function(self)
		return self.VisibleState
	end,
	OnVisibleChanged = function(self, visible) end,
	DrawCustomOpaque = function(self, flags)
		if CLIENT then
			return self:DrawModel()
		end
	end,
	DrawCustomTranslucent = function(self, flags)
		if CLIENT then
			return self:DrawModel()
		end
	end,
	Draw = function(self, flags)
		if CLIENT then
			if self:InInventory() then
				return
			end
			if self:InHand() or self:InOffhand() then
				self:AlignToOwner()
			end
			self:SetupBones()
			return self:DrawCustomOpaque(flags)
		end
	end,
	DrawTranslucent = function(self, flags)
		if CLIENT then
			if self:InInventory() then
				return
			end
			if self:InHand() or self:InOffhand() then
				self:AlignToOwner()
			end
			self:SetupBones()
			return self:DrawCustomTranslucent(flags)
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
	__name = "THING",
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
self.__entity = 'thing'
if _parent_0.__inherited then
	_parent_0.__inherited(_parent_0, _class_0)
end
THING = _class_0


local _class_0
local _parent_0 = ENTITY
local _base_0 = {
	Base = 'base_anim',
	Type = 'anim',
	Spawnable = true,
	SetupDataTables = function(self)
		self._NetworkVars = {
			String = 0,
			Bool = 0,
			Float = 0,
			Int = 0,
			Vector = 0,
			Angle = 0,
			Entity = 0
		}
		self:AddNetworkVar('Entity', 'InventoryEntity')
		self:AddNetworkVar('Int', 'InventorySlot')
		self:AddNetworkVar('Int', 'Durability')
		return self:AddNetworkVar('String', 'Element')
	end,
	AddNetworkVar = function(self, var_type, name, extended)
		local index = assert(self._NetworkVars[var_type], tostring(self:GetClass()) .. " attempt to register unknown network var type " .. tostring(var_type))
		local max
		if 'String' == var_type then
			max = 3
		else
			max = 31
		end
		if index >= max then
			error("Network var limit exceeded for " .. tostring(var_type))
		end
		self:NetworkVar(var_type, index, name, extended)
		self._NetworkVars[var_type] = index + 1
	end,
	Name = 'NONPICKUP',
	Model = Model('models/props_junk/PopCan01a.mdl'),
	Description = 'Wow! I can pick it up and throw it!',
	GetDescription = function(self)
		return self.Description
	end,
	Durability = 50,
	ProcessIName = function(self, text)
		if text == nil then
			text = self:GetClass()
		end
		local el
		do
			local _obj_0 = self.GetElement
			if _obj_0 ~= nil then
				el = _obj_0(self)
			end
		end
		if el and el ~= '' and ELEMENT.registered[el] then
			local element = ELEMENT.registered[self:GetElement()].IName
			text = tostring(element) .. " " .. tostring(text)
		end
		return text
	end,
	TargetInfo = function(self, witness)
		local info = { }
		info[#info + 1] = {
			font = 'spleen_label',
			color = COLOR_BGREEN,
			text = _ud83d_udcbe.Inspect:Inspect(witness, self) or self:GetClass()
		}
		local pos = self:GetPos()
		pos.z = pos.z + 15
		return info, pos
	end,
	OnTakeDamage = function(self, dmg)
		if CLIENT then
			return
		end
		if dmg:IsDamageType(DMG_CRUSH) and not (self.Attributes and self.Attributes['shatters']) then
			return
		end
		if dmg:GetDamageType() == DMG_BURN and self.Flamability and self.Flamability > 0 then
			self:Ignite(self.Flamability / 10, self.Flamability / 5)
		end
		if self:GetHolder():IsValid() then
			return
		end
		self:SetDurability(math.max(self:GetDurability() - dmg:GetDamage(), 0))
		if self:GetDurability() <= 0 then
			return self:Break()
		end
	end,
	Break = function(self, hit_ent)
		if self.Attributes and self.Attributes['shatters'] then
			local effectData = EffectData()
			local pos = self:GetPos()
			effectData:SetStart(pos)
			effectData:SetOrigin(pos)
			effectData:SetScale(8)
			util.Effect('GlassImpact', effectData, true, true)
			self:EmitSound('placenta/weapons/bottle_break.wav')
			if IsValid(hit_ent) then
				local dmg = DamageInfo()
				dmg:SetAttacker(self)
				dmg:SetDamage(self.SizeClass * 25)
				dmg:SetDamageType(DMG_SLASH)
				hit_ent:TakeDamageInfo(dmg)
			end
		end
		return self:Remove()
	end,
	Animations = {
		prime = ANIMS.something,
		throw = ANIMS.throwing
	},
	HandOffset = {
		Pos = Vector(),
		Ang = Angle()
	},
	BeltOffset = {
		Pos = Vector(),
		Ang = Angle()
	},
	HolsterSequence = 'wos_aoc_sword_holster',
	UnholsterSequence = 'draw_melee',
	ImpactSound = 'popcan.impacthard',
	CanInteract = function(self, ply)
		return true
	end,
	OnPrimaryInteract = function(self, tr, ply, hands)
		local ent = tr.Entity
		if IsValid(ent) then
			if self.UsedOnOther then
				self:UsedOnOther(ply, ent)
			end
			return true
		end
	end,
	OnInteract = function(self) end,
	AttackEnabled = false,
	AttackAct = ACT.SWING,
	AttackDamage = 5,
	AttackDamageType = DMG_CLUB,
	AttackDelay = .8,
	AttackRange = 50,
	AttackSound = {
		Swing = 'WeaponFrag.Throw',
		Hit = 'physics/cardboard/cardboard_box_impact_soft1.wav'
	},
	AttackSequence = {
		'melee_1h_overhead',
		'melee_1h_right'
	},
	SizeClass = SIZE_TINY,
	Mass = 1,
	ThrowVelocity = 1000,
	PlaceAngle = Angle(),
	PlaceAngle2 = Angle(),
	Initialize = function(self)
		self:SetModel(self.Model)
		if SERVER then
			self:PhysicsInit(SOLID_VPHYSICS)
			self:SetMoveType(MOVETYPE_VPHYSICS)
			self:SetUseType(SIMPLE_USE)
			self.TouchList = { }
			self:GetPhysicsObject():SetMass(self.Mass)
			if self.SizeClass <= SIZE_SMALL then
				self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			end
			self:SetDurability(self.Durability)
		end
		self:PhysWake()
		if self.Color then
			self:SetColor(self.Color)
		end
		if self.Material then
			self:SetMaterial(self.Material)
		end
		self.VisibleState = true
		if self.Element then
			_ud83d_udcbe.Elements:Assign(self, self.Element)
		end
		return self:OnSpawned()
	end,
	OnSpawned = function(self)
		return true
	end,
	CanBeMoved = function(self)
		return false
	end,
	MoveTo = function(self, ply, inv, slot, force)
		if not force then
			local ok = hook.Run('ItemAllowMove', ply, self, inv, slot)
			if not ok then
				return false
			end
		end
		local old_inv = self:GetInventoryEntity()
		if IsValid(old_inv) then
			old_inv:RemoveItem(self)
		end
		return inv:AddItem(self, slot)
	end,
	MoveToWorld = function(self, pos, ang, force)
		local old_inv = self:GetInventoryEntity()
		if IsValid(old_inv) then
			old_inv:RemoveItem(self)
		end
		return self:AddToWorld(pos, ang)
	end,
	AddToWorld = function(self, pos, ang)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		if SERVER and self.SizeClass > SIZE_SMALL then
			self:CreateTouchList()
		end
		self:SetParent(NULL)
		self:SetInventoryEntity(NULL)
		if SERVER then
			self:SetPos(pos)
			self:SetAngles(ang)
			self:GetPhysicsObject():EnableMotion(true)
			self:PhysWake()
		end
		return self:UpdateVisible()
	end,
	Think = function(self)
		if IsValid(self:GetHolder()) then
			self:AlignToOwner()
		end
		if CLIENT and self:InWorld() and self:IsEFlagSet(61440) then
			self:RemoveEFlags(61440)
		end
		if SERVER then
			return self:UpdateTouchList()
		end
	end,
	GetAlignmentOffset = function(self, holder)
		if holder:IsPlayer() then
			local inv = holder:GetInventory()
			if (holder:BeltItems() == self) then
				if inv:GetSlot(SLOT_BELT_L) == self then
					return self.BeltLeftOffset
				elseif inv:GetSlot(SLOT_BELT_R) == self then
					return self.BeltRightOffset
				end
			else
				return self.HandOffset
			end
		end
	end,
	AlignToOwner = function(self)
		local holder = self:GetHolder()
		if not IsValid(holder) then
			return
		end
		local pos, ang = holder:GetInventoryPosition(self:GetInventorySlot())
		local offset = self:GetAlignmentOffset(holder)
		if offset and offset.Pos then
			pos, ang = LocalToWorld(offset.Pos, offset.Ang, pos, ang)
		end
		self:SetPos(pos)
		return self:SetAngles(ang)
	end,
	GetHolder = function(self)
		local inv = self:GetInventoryEntity()
		if IsValid(inv) then
			return inv:GetParent()
		end
		return NULL
	end,
	InHand = function(self)
		return IsValid(self:GetInventoryEntity()) and self:GetInventorySlot() == SLOT_HAND
	end,
	InOffhand = function(self)
		return IsValid(self:GetInventoryEntity()) and self:GetInventorySlot() == SLOT_OFFHAND
	end,
	InInventory = function(self)
		return IsValid(self:GetInventoryEntity()) and not (_anon_func_0(SLOT_BELT_L, SLOT_BELT_R, SLOT_HAND, SLOT_OFFHAND, self))
	end,
	InWorld = function(self)
		return not IsValid(self:GetInventoryEntity())
	end,
	StartTouch = function(self, ent)
		if SERVER then
			self.TouchList[ent] = true
		end
	end,
	EndTouch = function(self, ent)
		if SERVER then
			self.TouchList[ent] = nil
		end
	end,
	CreateTouchList = function(self)
		if SERVER then
			Empty(self.TouchList)
			self.TriggerActive = true
			return self:SetTrigger(true)
		end
	end,
	UpdateTouchList = function(self)
		if not self.TriggerActive or table.Count(self.TouchList) > 0 then
			return
		end
		self.TriggerActive = false
		self:SetTrigger(false)
		return self:SetCollisionGroup(COLLISION_GROUP_NONE)
	end,
	PhysicsCollide = function(self, data, physobj)
		if data.DeltaTime > .2 and data.Speed > 30 then
			self:EmitSound(self.ImpactSound)
			if self.SizeClass <= SIZE_SMALL then
				self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			end
		end
		if data.DeltaTime > .2 and data.Speed > 120 then
			if self.Attributes and self.Attributes['shatters'] then
				return self:Break(data.HitEntity or NULL)
			end
		end
	end,
	UpdateVisible = function(self)
		local visible = not self:InInventory()
		if visible ~= self.VisibleState then
			self:OnVisibleChanged(visible)
			self.VisibleState = visible
		end
	end,
	GetVisible = function(self)
		return self.VisibleState
	end,
	OnVisibleChanged = function(self, visible) end,
	DrawCustomOpaque = function(self, flags)
		if CLIENT then
			return self:DrawModel()
		end
	end,
	DrawCustomTranslucent = function(self, flags)
		if CLIENT then
			return self:DrawModel()
		end
	end,
	Draw = function(self, flags)
		if CLIENT then
			if self:InInventory() then
				return
			end
			if self:InHand() or self:InOffhand() then
				self:AlignToOwner()
			end
			self:SetupBones()
			return self:DrawCustomOpaque(flags)
		end
	end,
	DrawTranslucent = function(self, flags)
		if CLIENT then
			if self:InInventory() then
				return
			end
			if self:InHand() or self:InOffhand() then
				self:AlignToOwner()
			end
			self:SetupBones()
			return self:DrawCustomTranslucent(flags)
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
	__name = "NONPICKUP",
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
self.__entity = 'nonpickup'
if _parent_0.__inherited then
	_parent_0.__inherited(_parent_0, _class_0)
end
NONPICKUP = _class_0
