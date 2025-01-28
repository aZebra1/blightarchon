local sin = math.sin
local Crosshair
local _class_0
local _parent_0 = MODULE
local _base_0 = {
	EyeMat = Material("blight/ui/crosshairs/face.png", "ignorez"),
	CrossShadowDist = 0,
	CrossShadowPos = Vector(0, 0, 0),
	PostDrawTranslucentRenderables = function(self)
		local ply = LocalPlayer()
		if not ply:Alive() then
			return
		end
		render.SetMaterial(self.EyeMat)
		local tr = ply:GetEyeTrace()
		self.CrossShadowPos = LerpVector(0.1, self.CrossShadowPos, tr.HitPos)
		local rot
		if tr.HitNormal.z == 1 then
			rot = ply:GetAngles().y
		else
			rot = 180
		end
		local size = 8 - 1 * TimedSin(0.4, 0, 1, 1)
		local rgb = Color(100, 100, 100)
		rgb.a = 180
		render.DrawQuadEasy(tr.HitPos + Vector(1, 1, 1) * tr.HitNormal, tr.HitNormal, size, size, rgb, rot)
		self.CrossShadowDist = Lerp(0.02, self.CrossShadowDist, 1)
		for i = 1, 3 do
			local dist = self.CrossShadowDist * i
			if dist < 3 then
				local s = size + dist
				local c = ColorAlpha(rgb, rgb.a - (rgb.a / 3 * dist))
				local r = rot + (dist * 10 * sin(CurTime()))
				local p = LerpVector(1 - (0.3 * i), self.CrossShadowPos, tr.HitPos)
				p = p + Vector(1 + dist, 1 + dist, 1 + dist) * tr.HitNormal
				render.DrawQuadEasy(p, tr.HitNormal, s, s, c, r)
			end
		end
	end,
	PreDrawHalos = function(self)
		local tr = LocalPlayer():GetInteractTrace()
		local highlighted = tr.Entity
		if IsValid(highlighted) then
			local color = HSVToColor((CurTime() * 23) % 360, 1, 1)
			return halo.Add({
				highlighted
			}, color, math.sin(CurTime()), math.cos(CurTime()), 2, true)
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
	__name = "Crosshair",
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
Crosshair = _class_0
return _class_0
