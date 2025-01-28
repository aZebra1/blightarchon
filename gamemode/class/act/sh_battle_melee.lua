local random, Rand = math.random, math.Rand
local Play = sound.Play
local insert, remove = table.insert, table.remove
local TraceHull, GetSurfaceData = util.TraceHull, util.GetSurfaceData
local SWING
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
		local anim, snd, cycle_swing_sound, cycle_to_hit = self.weapon.AttackSequence, nil, .1, .25
		if self.weapon.AttackSound and self.weapon.AttackSound.Swing then
			snd = self.weapon.AttackSound.Swing
		end
		if (CLIENT and IsFirstTimePredicted()) or SERVER then
			if istable(anim) then
				anim = anim[random(#anim)]
			end
			self:Spasm({
				sequence = anim
			})
		end
		if snd then
			self:CYCLE(cycle_swing_sound, function(self)
				if IsFirstTimePredicted() and SERVER then
					return self.weapon:EmitSound(snd)
				end
			end)
		end
		return self:CYCLE(cycle_to_hit, function(self)
			if IsFirstTimePredicted() and SERVER then
				local targets = self.ply:GetTargets(self.ply:GetAimVector(), self.weapon.AttackRange)
				for _index_0 = 1, #targets do
					local tr = targets[_index_0]
					if tr.Entity and IsValid(tr.Entity) and tr.HitPos then
						local victim = tr.Entity
						local dmg = DamageInfo()
						dmg:SetDamagePosition(tr.HitPos)
						dmg:SetDamageType(self.weapon.AttackDamageType)
						dmg:SetDamage(self.weapon.AttackDamage)
						dmg:SetAttacker(self.ply)
						dmg:SetInflictor(self.weapon)
						SuppressHostEvents(NULL)
						victim:TakeDamageInfo(dmg)
						SuppressHostEvents(self.ply)
						if self.weapon.AttackSound and self.weapon.AttackSound.Hit then
							self.weapon:EmitSound(self.weapon.AttackSound.Hit)
						end
						local surfprop = GetSurfaceData(tr.SurfaceProps)
						if not surfprop then
							surfprop = GetSurfaceData(0)
						end
						snd = surfprop.impactHardSound
						if snd then
							Play(snd, tr.HitPos, 65, random(90, 110))
						end
						local phys = victim:GetPhysicsObject()
						local physbone = victim:GetPhysicsObjectNum(tr.PhysicsBone)
						local aimvector = self.ply:GetAimVector()
						aimvector.z = 0
						local force = aimvector * (victim:IsPlayer() and 768 or 5400)
						local dir = (tr.HitPos - tr.StartPos):GetNormalized()
						if dir:Length() == 0 then
							dir = (victim:GetPos() - self.weapon:GetPos()):GetNormalized()
						end
						local dam = random(10, 25)
						force = dir * (dam * 23)
						if victim:IsPlayer() and IsValid(victim:GetRagdollEntity()) then
							victim = victim:GetRagdollEntity()
						end
						if victim:IsRagdoll() then
							force = force * 4
							physbone:ApplyForceCenter(force, tr.HitPos)
						elseif IsValid(victim) and IsValid(phys) then
							phys:ApplyForceOffset(force, tr.HitPos)
						end
						victim:SetVelocity(force)
					end
				end
			end
		end)
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
	__name = "SWING",
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
SWING = _class_0
return _class_0
