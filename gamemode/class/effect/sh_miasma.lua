local blood_materials
do
	local _accum_0 = { }
	local _len_0 = 1
	for i = 1, 8 do
		_accum_0[_len_0] = Material("decals/blood" .. tostring(i))
		_len_0 = _len_0 + 1
	end
	blood_materials = _accum_0
end
local drip_sounds
do
	local _accum_0 = { }
	local _len_0 = 1
	for i = 1, 8 do
		_accum_0[_len_0] = "dysphoria/gore/blood/drip" .. tostring(i) .. ".wav"
		_len_0 = _len_0 + 1
	end
	drip_sounds = _accum_0
end
local randscale = {
	min = 0.55,
	max = 1.25
}
local Miasma
local _class_0
local _parent_0 = FX
local _base_0 = {
	Init = function(self, data)
		local pos = data:GetOrigin()
		local mag = data:GetMagnitude()
		local speed = data:GetStart()
		local ang = data:GetNormal()
		local scale = data:GetScale()
		local emitter = ParticleEmitter(pos)
		for i = 1, 1 do
			local particle = emitter:Add("particle/particle_noisesphere", pos)
			particle:SetVelocity((((ang * 5) * i) * 5) + (speed) + Vector(math.random(-4, 4), math.random(-4, 4), math.random(-4, 4)))
			particle:SetDieTime(_ud83c_udfb2(9, 12))
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetStartSize(scale * .25)
			particle:SetEndSize(scale * math.random(3, 5))
			particle:SetRoll(math.Rand(-10, 10))
			particle:SetRollDelta(math.Rand(-0.4, 0.4))
			particle:SetColor(100, 40, 115, 200)
			particle:SetGravity(Vector(0, 0, 4))
			particle:SetCollide(true)
			particle:SetAirResistance(90)
			particle:SetBounce(1)
		end
		return emitter:Finish()
	end,
	Think = function(self)
		return false
	end,
	Render = function(self) end
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
	__name = "Miasma",
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
Miasma = _class_0
return _class_0
