local bor = bit.bor
local Bonemerge
local _class_0
local _parent_0 = ENTITY
local _base_0 = {
	Type = "anim",
	Base = "base_anim",
	RenderGroup = RENDERGROUP_OTHER,
	AutomaticFrameAdvance = true,
	Initialize = function(self)
		self:AddEffects(bor(EF_BONEMERGE, EF_BONEMERGE_FASTCULL))
		self:SetSolid(SOLID_NONE)
		self:SetNotSolid(true)
		self:SetMoveType(MOVETYPE_NONE)
		return self:SetCollisionBounds(Vector(0, 0, 0), Vector(0, 0, 0))
	end,
	OnTakeDamage = function(self) end,
	PhysicsCollide = function(self) end
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
	__name = "Bonemerge",
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
Bonemerge = _class_0
return _class_0
