local GhostEntity
local _class_0
local _parent_0 = MODULE
local _base_0 = {
	ghost_entity = NULL,
	Think = function(self)
		self:UpdateGhostEntity()
		return
	end,
	MakeGhostEntity = function(self, model, pos, angle)
		util.PrecacheModel(model)
		if not IsFirstTimePredicted() then
			return
		end
		self:ReleaseGhostEntity()
		if not util.IsValidProp(model) then
			return
		end
		self.ghost_entity = ents.CreateClientProp(model)
		if not IsValid(self.ghost_entity) then
			self.ghost_entity = nil
			return
		end
		local _with_0 = self.ghost_entity
		_with_0:SetModel(model)
		_with_0:SetPos(pos)
		_with_0:SetAngles(angle)
		_with_0:Spawn()
		_with_0:PhysicsDestroy()
		_with_0:SetMoveType(MOVETYPE_NONE)
		_with_0:SetNotSolid(true)
		_with_0:SetRenderMode(RENDERMODE_TRANSCOLOR)
		_with_0:SetColor(Color(255, 255, 255, 150))
		return _with_0
	end,
	StartGhostEntity = function(self, ent)
		return self:MakeGhostEntity(ent:GetModel(), ent:GetPos(), ent:GetAngles())
	end,
	ReleaseGhostEntity = function(self)
		if self.ghost_entity then
			if not IsValid(self.ghost_entity) then
				self.ghost_entity = nil
				return
			end
			self.ghost_entity:Remove()
			self.ghost_entity = nil
		end
		if self.ghost_entities then
			for k, v in pairs(self.ghost_entities) do
				if IsValid(v) then
					v:Remove()
				end
				self.ghost_entities[k] = nil
			end
			self.ghost_entities = nil
		end
		if self.ghost_offset then
			for k, v in pairs(self.ghost_offset) do
				self.ghost_offset[k] = nil
			end
		end
	end,
	UpdateGhostEntity = function(self)
		if self.ghost_entity == nil then
			return
		end
		if not IsValid(self.ghost_entity) then
			self.ghost_entity = nil
			return
		end
		local ply = LocalPlayer()
		local item = ply:Wielding()
		if not IsValid(item) then
			item = ply:WieldingOffhand()
		end
		if not IsValid(item) then
			return
		end
		local tr = ply:TraceItem(item, ply:GetInteractTrace().HitPos)
		local ang = Angle(0, ply:GetAngles().y, 0) + item.PlaceAngle
		local _with_0 = self.ghost_entity
		_with_0:SetPos(tr.HitPos)
		_with_0:SetAngles(ang)
		return _with_0
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
	__name = "GhostEntity",
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
GhostEntity = _class_0
return _class_0
