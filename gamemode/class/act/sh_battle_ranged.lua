local random = math.random
local SHOOT
local _class_0
local _parent_0 = ACT
local _base_0 = {
	Immobilizes = false,
	Impossible = function(self)
		if not (IsValid(self.weapon) and self.ply:Wielding() == self.weapon and self.weapon.AttackEnabled) then
			return true
		end
	end,
	Do = function(self, fromstate)
		local mag = self.weapon:GetMagazine()
		if IsValid(mag) and mag:GetRounds() > 0 then
			local sequence = self.weapon.AttackSequence
			if istable(sequence) then
				sequence = sequence[random(#sequence)]
			end
			if (CLIENT and IsFirstTimePredicted()) or SERVER then
				self:Spasm({
					slot = GESTURE_SLOT_ATTACK_AND_RELOAD,
					sequence = sequence
				})
			end
			if IsFirstTimePredicted() then
				self.weapon:Shoot()
			end
		end
		return self:Kill()
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
	__init = function(self, ply, weapon)
		self.ply = ply
		self.weapon = weapon
		return _class_0.__parent.__init(self, self.ply)
	end,
	__base = _base_0,
	__name = "SHOOT",
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
SHOOT = _class_0
return _class_0
