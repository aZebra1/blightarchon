local random, Rand = math.random, math.Rand
local Play = sound.Play
local insert, remove = table.insert, table.remove
local TraceHull, GetSurfaceData = util.TraceHull, util.GetSurfaceData
local SHOVE
do
	local _class_0
	local _parent_0 = ACT
	local _base_0 = {
		force_multiplier = 100,
		Do = function(self, fromstate)
			local _with_0 = self.ply
			if not _with_0:StanceIs(STANCE_RISEN) then
				_with_0:AlterState(STATE.IDLE)
				return
			end
			local sequence, snd, cycle = "range_melee_shove_1hand", nil, .23
			if fromstate == STATE.PRIMED then
				sequence, snd = "gesture_push", "dysphoria/battle/push.wav"
			end
			if (CLIENT and IsFirstTimePredicted()) or SERVER then
				self:Spasm({
					sequence = sequence
				})
			end
			self:CYCLE(cycle, function(self)
				if IsFirstTimePredicted() and SERVER then
					if snd then
						Play(snd, _with_0:GetBonePosition(_with_0:LookupBone('ValveBiped.Bip01_Spine2')), 65, math.random(90, 110))
					end
					local targets = _with_0:GetTargets()
					for _index_0 = 1, #targets do
						local tr = targets[_index_0]
						local victim = tr.Entity
						local phys = victim:GetPhysicsObject()
						local physbone = victim:GetPhysicsObjectNum(tr.PhysicsBone)
						local aimvector = _with_0:GetAimVector()
						local force = aimvector * (victim:IsPlayer() and 512 or 3600)
						if fromstate == STATE.PRIMED then
							force = force * 1.5
						end
						if phys:IsValid() then
							if victim:IsPlayer() then
								victim:DropObject()
							end
							local surfprop = util.GetSurfaceData(tr.SurfaceProps)
							surfprop = surfprop or util.GetSurfaceData(0)
							if fromstate == STATE.PRIMED then
								snd = surfprop.impactHardSound
							else
								snd = surfprop.impactSoftSound
							end
							if snd then
								Play(snd, tr.HitPos, 65, math.random(90, 110))
							end
							if victim:IsRagdoll() then
								physbone:ApplyForceCenter(force, tr.HitPos)
							else
								phys:ApplyForceOffset(force, tr.HitPos)
							end
							if victim:IsPlayer() then
								if victim:Alive() then
									local rag = victim:GetRagdoll()
									if rag and IsValid(rag) then
										rag:SetKnockback(victim:GetVelocity(), force)
									else
										if math.random(100) <= 10 or victim:Health() <= 40 then
											victim:BecomeRagdoll()
										elseif victim:DoingSomething() and victim.Doing.__class.__parent == ACT.STAND then
											victim:BecomeRagdoll()
										end
									end
									if victim:IsPlayer() and rag and IsValid(rag) then
										victim = rag
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
					end
				end
			end)
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
		__name = "SHOVE",
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
	SHOVE = _class_0
end
local KICK
do
	local _class_0
	local _parent_0 = ACT
	local _base_0 = {
		Do = function(self, fromstate)
			local _with_0 = self.ply
			if not _with_0:StanceIs(STANCE_RISEN) then
				_with_0:AlterState(STATE.IDLE)
				return
			end
			local sequence, snd, speed, cycle = 'kick_pistol', 'dysphoria/battle/foot_fire.wav', 1.23, .32
			if self.ply:EyeAngles().p >= 45 then
				sequence, speed, cycle = 'curbstomp', 1, .15
			end
			if (CLIENT and IsFirstTimePredicted()) or SERVER then
				self:Spasm({
					sequence = sequence,
					speed = speed
				})
			end
			self:CYCLE(cycle, function(self)
				if IsFirstTimePredicted() and SERVER then
					local bone = _with_0:LookupBone('ValveBiped.Bip01_R_Foot')
					local pos = _with_0:GetBonePosition(bone)
					Play(snd, pos, 65, math.random(90, 110))
					local tr = TraceHull({
						start = pos,
						endpos = pos + _with_0:GetForward() * 10,
						filter = self.ply,
						mins = Vector(-6, -6, -6),
						maxs = Vector(6, 6, 6)
					})
					if tr.HitPos and tr.HitWorld then
						local surfprop = util.GetSurfaceData(tr.SurfaceProps)
						surfprop = surfprop or util.GetSurfaceData(0)
						snd = surfprop.impactHardSound
						if snd then
							Play(snd, tr.HitPos, 65, math.random(90, 110))
						end
					end
					local targets = _with_0:GetTargets(_with_0:GetForward())
					for _index_0 = 1, #targets do
						local tr = targets[_index_0]
						local victim = tr.Entity
						local phys = victim:GetPhysicsObject()
						local physbone = victim:GetPhysicsObjectNum(tr.PhysicsBone)
						local aimvector = _with_0:GetAimVector()
						local force = aimvector * (victim:IsPlayer() and 768 or 5400)
						local surfprop = util.GetSurfaceData(tr.SurfaceProps)
						surfprop = surfprop or util.GetSurfaceData(0)
						snd = surfprop.impactHardSound
						if snd then
							Play(snd, tr.HitPos, 65, math.random(90, 110))
						end
						if phys:IsValid() then
							if victim:IsPlayer() then
								victim:DropObject()
							end
							local dmg = DamageInfo()
							dmg:SetDamage(math.random(10, 25))
							dmg:SetDamageType(DMG_CLUB)
							dmg:SetDamagePosition(tr.HitPos)
							dmg:SetInflictor(self.ply)
							dmg:SetAttacker(self.ply)
							victim:TakeDamageInfo(dmg)
							if victim:IsRagdoll() then
								physbone:ApplyForceCenter(force, tr.HitPos)
							else
								phys:ApplyForceOffset(force, tr.HitPos)
							end
							if victim:IsPlayer() then
								if victim:Alive() then
									local rag = victim:GetRagdoll()
									if rag and IsValid(rag) then
										rag:SetKnockback(victim:GetVelocity(), force)
									else
										if math.random(100) <= 10 or victim:Health() <= 40 then
											victim:BecomeRagdoll()
										elseif victim:DoingSomething() and victim.Doing.__class.__parent == ACT.STAND then
											victim:BecomeRagdoll()
										end
									end
									if victim:IsPlayer() and rag and IsValid(rag) then
										victim = rag
									end
									if victim:IsRagdoll() then
										force = force * 4
										physbone:ApplyForceCenter(force, tr.HitPos)
									elseif IsValid(victim) and IsValid(phys) then
										phys:ApplyForceOffset(force, tr.HitPos)
									end
									victim:SetVelocity(force)
								end
							elseif victim:IsDoor() then
								local kicked, busted = victim:DoorKicked(self.ply, tr.HitPos)
							end
						end
					end
				end
			end)
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
		__name = "KICK",
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
	KICK = _class_0
end
local PUNCH
local _class_0
local _parent_0 = ACT
local _base_0 = {
	Immobilizes = false,
	Do = function(self, fromstate)
		local _with_0 = self.ply
		if _with_0:StanceIs(STANCE_PRONE) then
			_with_0:AlterState(STATE.IDLE)
			return
		end
		local sequence = table.Random({
			'gesture_punch_l',
			'gesture_punch_r'
		})
		local snd, cycle1, cycle2 = 'WeaponFrag.Throw', .13, .32
		if sequence == 'gesture_punch_l' then
			self.fist = -1
		else
			self.fist = 1
		end
		if (CLIENT and IsFirstTimePredicted()) or SERVER then
			self:Spasm({
				sequence = sequence
			})
		end
		self:CYCLE(cycle1, function(self)
			if IsFirstTimePredicted() and SERVER then
				local bone
				if self.fist == -1 then
					bone = 'ValveBiped.Bip01_L_Hand'
				else
					bone = 'ValveBiped.Bip01_R_Hand'
				end
				Play(snd, _with_0:GetBonePosition(_with_0:LookupBone(bone)), math.random(90, 110))
			end
			self.punchinIt = CurTime() + .0666
		end)
		self:CYCLE(cycle2, function(self)
			self.punchinIt = nil
		end)
		return _with_0
	end,
	FistDetector = function(self)
		local bone
		if self.fist == -1 then
			bone = 'ValveBiped.Bip01_L_Hand'
		else
			bone = 'ValveBiped.Bip01_R_Hand'
		end
		local fist = self.ply:LookupBone(bone)
		local pos = self.ply:GetBonePosition(fist)
		local tr = TraceHull({
			start = pos,
			endpos = pos + self.ply:GetForward() * 10,
			filter = self.ply,
			mins = Vector(-6, -6, -6),
			maxs = Vector(6, 6, 6)
		})
		if tr.Hit or tr.HitWorld then
			return tr
		end
	end,
	Think = function(self)
		_class_0.__parent.__base.Think(self)
		if self.punchinIt and not self.punchedIt then
			if CurTime() >= self.punchinIt then
				self.punchinIt = CurTime() + 0.023
				self.ply:LagCompensation(true)
				local tr = self:FistDetector()
				self.ply:LagCompensation(false)
				if tr then
					local _with_0 = self.ply
					local victim = tr.Entity
					local isliving = victim:IsPlayer() or victim:IsNextBot() or victim:IsNPC()
					local phys = victim:GetPhysicsObject()
					local physbone = victim:GetPhysicsObjectNum(tr.PhysicsBone)
					local aimvector = _with_0:GetAimVector()
					aimvector.z = 0
					local force = aimvector * (victim:IsPlayer() and 512 or 3600)
					local dir = (tr.HitPos - tr.StartPos):GetNormalized()
					if dir:Length() == 0 then
						dir = (victim:GetPos() - self.ply:GetPos()):GetNormalized()
					end
					local dam = random(5, 15)
					force = dir * (dam * 23)
					if phys:IsValid() then
						if SERVER then
							DropEntityIfHeld(victim)
						end
						local surfprop = GetSurfaceData(tr.SurfaceProps)
						if not surfprop then
							surfprop = GetSurfaceData(0)
						end
						local snd = surfprop.impactHardSound
						if IsFirstTimePredicted() then
							Play(snd, tr.HitPos, 65, random(90, 110))
						end
						local dmg = DamageInfo()
						dmg:SetDamage(dam)
						dmg:SetDamageForce(force)
						dmg:SetDamageType(DMG_CLUB)
						dmg:SetDamagePosition(tr.HitPos)
						dmg:SetInflictor(self.ply)
						dmg:SetAttacker(self.ply)
						if SERVER then
							victim:TakeDamageInfo(dmg)
							if victim:IsPlayer() then
								if victim:Alive() then
									if (random(100) <= 15 and victim:Health() < 50) then
										victim:BecomeRagdoll()
									elseif victim:DoingSomething() and victim.Doing.__class.__parent == ACT.STAND then
										victim:BecomeRagdoll()
									end
								end
							end
							if victim:IsPlayer() and IsValid(victim:GetRagdollEntity()) then
								victim = victim:GetRagdollEntity()
							end
							if victim:IsRagdoll() then
								force = force * 4
								physbone:ApplyForceCenter(force, tr.HitPos)
							elseif IsValid(victim) and IsValid(phys) and not victim:IsDoor() then
								phys:ApplyForceOffset(force, tr.HitPos)
							end
							if not victim:IsDoor() then
								victim:SetVelocity(force)
							end
						end
						self.punchedIt = true
					end
					return _with_0
				end
			end
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
	__name = "PUNCH",
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
PUNCH = _class_0
return _class_0
