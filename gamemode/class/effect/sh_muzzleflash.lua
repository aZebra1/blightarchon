local random, Rand = math.random, math.Rand
local images_muzzle
do
	local _accum_0 = { }
	local _len_0 = 1
	for i = 1, 4 do
		_accum_0[_len_0] = "effects/muzzleflash" .. tostring(i)
		_len_0 = _len_0 + 1
	end
	images_muzzle = _accum_0
end
local images_distort = {
	"sprites/heatwave"
}
local images_smoke
do
	local _accum_0 = { }
	local _len_0 = 1
	for i = 1, 9 do
		_accum_0[_len_0] = "particle/smokesprites_000" .. tostring(i)
		_len_0 = _len_0 + 1
	end
	images_smoke = _accum_0
end
for i = 10, 16 do
	images_smoke[#images_smoke + 1] = "particle/smokesprites_00" .. tostring(i)
end
local MuzzleFlash
local _class_0
local _parent_0 = FX
local _base_0 = {
	Init = function(self, data)
		local quality = 3
		if quality == 0 then
			return
		end
		local wpn = data:GetEntity()
		if not IsValid(wpn) then
			return
		end
		local ply = wpn:GetHolder()
		if not IsValid(ply) then
			return
		end
		local pos, dir = wpn:GetMuzzlePos()
		dir = dir:Forward()
		local addvel = ply:GetVelocity()
		local emitter = ParticleEmitter(pos)
		if (not wpn.Suppressed) and (not wpn.FlashHidden) then
			local particle = emitter:Add(images_muzzle[random(#images_muzzle)], pos)
			if particle then
				particle:SetVelocity(addvel)
				particle:SetLifeTime(0)
				particle:SetDieTime(Rand(0.05, 0.1))
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				particle:SetStartSize(Rand(15, 20))
				particle:SetEndSize(Rand(25, 30))
				particle:SetLighting(false)
				particle:SetRoll(random(0, 360))
				particle:SetColor(255, 255, 255)
			end
		end
		for i = 1, quality do
			local particle = emitter:Add(images_smoke[random(#images_smoke)], pos)
			if particle then
				particle:SetVelocity(VectorRand() * 10 + (dir * i * Rand(12, 24)) + addvel)
				particle:SetLifeTime(0)
				particle:SetDieTime(Rand(0.75, 1.5))
				particle:SetStartAlpha(Rand(5, 10) * quality)
				particle:SetEndAlpha(0)
				particle:SetStartSize(Rand(8, 12))
				particle:SetEndSize(Rand(24, 30))
				particle:SetRoll(math.rad(Rand(0, 360)))
				particle:SetRollDelta(Rand(-1, 1))
				particle:SetLighting(true)
				particle:SetAirResistance(96)
				particle:SetGravity(Vector(-7, 3, 60))
				particle:SetColor(255, 255, 255)
			end
		end
		if quality >= 3 then
			local particle = emitter:Add(images_distort[random(#images_distort)], pos)
			if particle then
				particle:SetVelocity((dir * 25) + 1.05 * addvel)
				particle:SetLifeTime(0)
				particle:SetDieTime(Rand(0.1, 0.2))
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				particle:SetStartSize(Rand(5, 8))
				particle:SetEndSize(0)
				particle:SetRoll(Rand(0, 360))
				particle:SetRollDelta(Rand(-2, 2))
				particle:SetAirResistance(5)
				particle:SetGravity(Vector(0, 0, 40))
				particle:SetColor(255, 255, 255)
			end
		end
		if not wpn.Suppressed then
			local light = DynamicLight(self:EntIndex())
			if light then
				light.Pos = pos
				light.r = 244
				light.g = 209
				light.b = 66
				light.Brightness = 6
				light.Decay = 2500
				light.Size = 256
				light.DieTime = CurTime() + 0.1
			end
		end
		return emitter:Finish()
	end,
	Think = function(self)
		return false
	end,
	Render = function(self)
		return false
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
	__name = "MuzzleFlash",
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
MuzzleFlash = _class_0
return _class_0
