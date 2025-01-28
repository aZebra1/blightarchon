local INVENTORY_LAYOUT_BODY = table.FlipKeyValues({
	SLOT_HAND,
	SLOT_OFFHAND,
	SLOT_OUTFIT,
	SLOT_BELT_L,
	SLOT_BELT_R,
	SLOT_BACK,
	SLOT_POCKET1,
	SLOT_POCKET2,
	SLOT_POCKET3,
	SLOT_POCKET4
})
BIND('release_left', KEY_Z, {
	Press = function(self, ply)
		if CLIENT then
			local item = ply:WieldingOffhand()
			if not IsValid(item) then
				return
			end
			local tr = ply:TraceItem(item, ply:GetInteractTrace().HitPos)
			local ang = Angle(0, ply:GetAngles().y, 0) + item.PlaceAngle
			return _ud83d_udcbe.GhostEntity:MakeGhostEntity(item:GetModel(), tr.HitPos, ang)
		end
	end,
	Release = function(self, ply)
		local item = ply:WieldingOffhand()
		if not item then
			return
		end
		if not ply:StateIs(STATE.PRIMED) then
			ply:Do(ACT.DROP, item)
		end
		if CLIENT then
			return _ud83d_udcbe.GhostEntity:ReleaseGhostEntity()
		end
	end
})
BIND('release_right', KEY_X, {
	Press = function(self, ply)
		if CLIENT then
			local item = ply:Wielding()
			if not IsValid(item) then
				return
			end
			local tr = ply:TraceItem(item, ply:GetInteractTrace().HitPos)
			local ang = Angle(0, ply:GetAngles().y, 0) + item.PlaceAngle
			return _ud83d_udcbe.GhostEntity:MakeGhostEntity(item:GetModel(), tr.HitPos, ang)
		end
	end,
	Release = function(self, ply)
		local item = ply:Wielding()
		if not item then
			return
		end
		if not ply:StateIs(STATE.PRIMED) then
			ply:Do(ACT.DROP, item)
		end
		if CLIENT then
			return _ud83d_udcbe.GhostEntity:ReleaseGhostEntity()
		end
	end
})
BIND('reload', KEY_R, {
	Release = function(self, ply)
		local act
		if ply:StateIs(STATE.PRIMED) then
			act = ACT.UNLOAD
		else
			act = ACT.SWITCH_HAND
		end
		return ply:Do(act)
	end
})
BIND('item_use', MOUSE_MIDDLE, {
	Press = function(self, ply)
		local item = ply:Wielding()
		if IsValid(item) and item.Used then
			return item:Used(ply)
		end
	end
})
BIND('item_combine', KEY_C, {
	Press = function(self, ply)
		local wielding, wielding_off = ply:Wielding(), ply:WieldingOffhand()
		if IsValid(wielding) and IsValid(wielding_off) then
			return ply:Do(ACT.COMBINE)
		end
	end
})
local meta = FindMetaTable('Player')
for k, v in pairs({
	GetInventoryLayout = function(self)
		return INVENTORY_LAYOUT_BODY
	end,
	GetInventoryPosition = function(self, slot)
		local attaches = {
			[SLOT_HAND] = 'anim_attachment_RH',
			[SLOT_OFFHAND] = 'anim_attachment_LH',
			[SLOT_BELT_L] = 'waist_l',
			[SLOT_BELT_R] = 'waist_r',
			[SLOT_POCKET1] = 'waist',
			[SLOT_POCKET2] = 'waist',
			[SLOT_POCKET3] = 'waist',
			[SLOT_POCKET4] = 'waist'
		}
		local index = self:LookupAttachment(attaches[slot])
		local att = self:GetAttachment(index)
		if att then
			return att.Pos, att.Ang
		end
	end,
	IsHolding = function(self, ent)
		return (self:Wielding() == ent or self:WieldingOffhand() == ent)
	end
}) do
	meta[k] = v
end
local Inventory
local _class_0
local _parent_0 = MODULE
local _base_0 = {
	PlayerTick = function(self, ply)
		if not SERVER then
			return
		end
		local dragging = ply:GetDragging()
		if dragging and IsValid(dragging) then
			if (not dragging.DraggedBy) or (dragging.DraggedBy ~= ply) or (not dragging:IsPlayerHolding()) then
				ply:SetDragging(NULL)
			end
		end
		return
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
	__name = "Inventory",
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
Inventory = _class_0
return _class_0
