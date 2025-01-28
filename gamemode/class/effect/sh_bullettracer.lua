local tracer = Material("trails/smoke")
local tracer2 = Material("trails/smoke")
local width = 2.45
local width2 = 2.3
local BulletTracer
local _class_0
local _parent_0 = FX
local _base_0 = {
	Init = function(self, data)
		self.pos = data:GetStart()
		self.pos_end = data:GetOrigin()
		self.weapon_ent = data:GetEntity()
		self.attachment = data:GetAttachment()
		self.pos_start = self:GetTracerShootPos(self.pos, self.weapon_ent, self.attachment)
		self:SetRenderBoundsWS(self.pos_start, self.pos_end)
		self.dir = (self.pos_end - self.pos_start):GetNormalized()
		self.dist = self.pos_start:Distance(self.pos_end)
		self.lifetime = 0.4 * 1 / 2
		self.lifetime2 = 0.1 * 1 / 2
		self.dietime = CurTime() + self.lifetime
		self.dietime2 = CurTime() + self.lifetime2
	end,
	Think = function(self)
		if CurTime() > self.dietime then
			return false
		end
		return true
	end,
	Render = function(self)
		local r, g, b = 255, 220, 120
		local v = (self.dietime - CurTime()) / self.lifetime
		local v2 = (self.dietime2 - CurTime()) / self.lifetime2
		render.SetMaterial(tracer)
		render.DrawBeam(self.pos_start, self.pos_end, (v * width) * 2 / 2, 0, self.dist / 10, Color(90, 90, 90, v * 160))
		render.SetMaterial(tracer2)
		return render.DrawBeam(self.pos_start, self.pos_end, (v2 * width2) * 2 / 3, 0, self.dist / 10, Color(r, g, b, (v2 * 95) * 1 / 2))
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
	__name = "BulletTracer",
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
BulletTracer = _class_0
return _class_0
