TUMBLE_SOFT = 100
TUMBLE_OUCH = 200
TUMBLE_HARD = 400
local meta = FindMetaTable('Player')
local eyevec = Vector(0, 0, 64)
local chestvec = Vector(0, 0, 32)
local bounds = {
	hull = {
		mins = Vector(-13, -13, 8),
		maxs = Vector(13, 13, 72)
	},
	head = {
		attach = 'eyes',
		mins = Vector(-5, -4, -3.5),
		maxs = Vector(5, 4, 3.5)
	},
	chest = {
		mins = Vector(-12, -12, 34),
		maxs = Vector(10, 10, 64),
		reach = 20
	},
	legs = {
		mins = Vector(-12, -12, 6),
		maxs = Vector(12, 12, 32),
		reach = 20
	},
	collapse = {
		attach = 'waist',
		offsetR = -10,
		offsetF = 4,
		mins = Vector(-8, -8, -13),
		maxs = Vector(10, 10, 13)
	},
	collapse_head = {
		attach = 'eyes',
		mins = Vector(-5, -5, -5),
		maxs = Vector(5, 5, 5)
	},
	hand_right = {
		attach = 'anim_attachment_RH',
		mins = Vector(-2, -2, -2),
		maxs = Vector(2, 2, 2)
	}
}
for k, v in pairs({
	TumbleCheck = function(self, bound, mul, dir)
		if bound == nil then
			bound = bounds.chest
		end
		if mul == nil then
			mul = 1
		end
		local attach = bound.attach
		if attach then
			attach = self:GetAttachment(self:LookupAttachment(attach))
		end
		local pos
		if attach then
			pos = attach.Pos
		else
			pos = self:GetPos()
		end
		if attach then
			if bound.offsetU then
				pos = pos + (attach.Ang:Up() * bound.offsetU)
			end
			if bound.offsetR then
				pos = pos + (attach.Ang:Right() * bound.offsetR)
			end
			if bound.offsetF then
				pos = pos + (attach.Ang:Forward() * bound.offsetF)
			end
		end
		local reach = bound.reach
		if not reach then
			reach = 20
		end
		reach = reach * mul
		if not dir then
			local vel = self:GetVelocity()
			local velF = vel:Angle():Forward()
			if (velF * reach):Length2D() < 16 then
				if attach then
					velF = attach.Ang:Forward()
				else
					velF = self:GetAngles():Forward()
				end
			end
			dir = velF
		elseif isangle(dir) then
			dir = dir:Forward()
		end
		local abs, ceil = math.abs, math.ceil
		local mins, maxs = bound.mins, bound.maxs
		if abs(ceil(dir.x)) == 0 and abs(ceil(dir.y)) == 0 then
			dir.z = 0
		end
		local tr = util.TraceHull({
			start = pos,
			endpos = pos + (dir * reach),
			mask = MASK_PLAYERSOLID,
			mins = mins,
			maxs = maxs,
			filter = self:GetTraceFilter()
		})
		return tr
	end,
	BumpChest = function(self, speed)
		local tumbled = self:TumbleCheck(bounds.chest, 1.05)
		if tumbled.Hit then
			if tumbled.HitNormal.x ~= 0 then
				local _obj_0 = tumbled.HitPos
				_obj_0.z = _obj_0.z + 12
			end
			if speed >= TUMBLE_OUCH then
				self:Bodyslam(tumbled, speed)
				self.NextTumble = CurTime() + 0.1
				return true
			else
				return self:Nudge(tumbled, speed)
			end
		end
	end,
	BumpHead = function(self, speed)
		local tumbled = self:TumbleCheck(bounds.head, .975)
		if tumbled.Hit then
			if tumbled.HitNormal.x ~= 0 then
				local _obj_0 = tumbled.HitPos
				_obj_0.z = _obj_0.z + 12
			end
			if speed >= TUMBLE_OUCH then
				self:Headbutt(tumbled, speed)
				self.NextTumble = CurTime() + 0.1
				return true
			end
		end
	end,
	BumpLegs = function(self, speed)
		local tumbled = self:TumbleCheck(bounds.legs, 1)
		if tumbled.Hit then
			if tumbled.HitNormal.x ~= 0 then
				local _obj_0 = tumbled.HitPos
				_obj_0.z = _obj_0.z + 12
			end
			if speed >= TUMBLE_OUCH then
				self:TripOver(tumbled, speed)
				self.NextTumble = CurTime() + 0.1
				return true
			end
		end
	end,
	Nudge = function(self, tumbled, speed)
		if not IsFirstTimePredicted() then
			return
		end
		if not SERVER then
			return
		end
		if tumbled.HitWorld then
			if not self.NextNudgeAV then
				self.NextNudgeAV = CurTime()
			end
			if CurTime() >= self.NextNudgeAV then
				if speed >= TUMBLE_SOFT * 1.2 then
					self:EmitSound("Flesh.ImpactSoft", 75, 90)
					self.NextNudgeAV = CurTime() + 1
				end
			end
			if SERVER then
				return self:SetSpeed(SPEED_WALK)
			end
		elseif tumbled.Entity and tumbled.Entity:IsValid() and tumbled.Entity:IsPlayer() then
			local vec = (tumbled.StartPos - tumbled.HitPos):GetNormalized() * -1 * 20
			local _with_0 = tumbled.Entity
			_with_0:SetVelocity(vec)
			if not _with_0.NextPushSound then
				_with_0.NextPushSound = CurTime()
			end
			if CurTime() >= _with_0.NextPushSound then
				_with_0:EmitSound("Flesh.ImpactSoft", 75, 90)
				_with_0.NextPushSound = CurTime() + math.Rand(0.2, 0.4)
			end
			return _with_0
		end
	end,
	Bodyslam = function(self, tumbled, speed)
		if not IsFirstTimePredicted() then
			return
		end
		if not SERVER then
			return
		end
		local min = math.min
		local force = Vector(0, 0, 0)
		if not tumbled.HitWorld then
			force = (tumbled.StartPos - tumbled.HitPos):GetNormal() * speed / 2
		end
		force.z = 0
		self:EmitSound("NPC_BaseZombie.Swat")
		if SERVER then
			self:SetSpeed(min(self:GetSpeedTarget(), SPEED_WALK))
		end
		local crashpct = speed / TUMBLE_HARD
		do
			local dmg = DamageInfo()
			dmg:SetDamage(10 * crashpct)
			dmg:SetAttacker(self)
			dmg:SetDamageType(DMG_FALL)
			dmg:SetDamagePosition(tumbled.StartPos)
			dmg:SetDamageForce(force)
			self:TakeDamageInfo(dmg)
			local dont_fall = false
			if tumbled.Entity and tumbled.Entity:IsValid() then
				local weapon = self:Wielding()
				if self:StateIs(STATE.PRIMED) then
					if IsValid(weapon) then
						dont_fall = weapon.CanCharge or false
					else
						dont_fall = true
					end
				end
			end
			if crashpct > 0.75 and not dont_fall then
				self:BecomeRagdoll(dmg)
			end
		end
		if tumbled.Entity and tumbled.Entity:IsValid() then
			if tumbled.Entity:IsPlayer() then
				local tply = tumbled.Entity
				force:Mul(-1)
				do
					local dmg = DamageInfo()
					dmg:SetDamage(15 * crashpct)
					dmg:SetAttacker(self)
					dmg:SetDamageType(DMG_FALL)
					dmg:SetDamagePosition(tumbled.HitPos)
					dmg:SetDamageForce(force)
					tply:TakeDamageInfo(dmg)
					if crashpct > 0.6 then
						tply:BecomeRagdoll(dmg)
					end
				end
				tply:SetSpeed(min(tply:GetSpeedTarget(), SPEED_WALK))
			end
		end
		return true
	end,
	Headbutt = function(self, tumbled, speed)
		if not IsFirstTimePredicted() then
			return
		end
		if not SERVER then
			return
		end
		local min = math.min
		local force = Vector(0, 0, 0)
		if not tumbled.HitWorld then
			force = (tumbled.StartPos - tumbled.HitPos):GetNormal() * speed / 2
		end
		self:EmitSound("Flesh.ImpactHard")
		if SERVER then
			self:SetSpeed(min(self:GetSpeedTarget(), SPEED_WALK))
		end
		local crashpct = speed / TUMBLE_HARD
		do
			local dmg = DamageInfo()
			dmg:SetDamage(10 * crashpct)
			dmg:SetAttacker(self)
			dmg:SetDamageType(DMG_FALL)
			dmg:SetDamagePosition(tumbled.StartPos)
			dmg:SetDamageForce(force)
			self:TakeDamageInfo(dmg)
			if crashpct >= 0.5 then
				self:SetDSP(math.random(35, 37))
			end
			local dont_fall = false
			if tumbled.Entity and tumbled.Entity:IsValid() then
				if tumbled.Entity:IsPlayer() then
					dont_fall = true
				end
			end
			if crashpct > 0.75 and not dont_fall then
				self:BecomeRagdoll(dmg)
			end
		end
		if tumbled.Entity and tumbled.Entity:IsValid() then
			if tumbled.Entity:IsPlayer() then
				local tply = tumbled.Entity
				force:Mul(-1)
				do
					local dmg = DamageInfo()
					dmg:SetDamage(20 * crashpct)
					dmg:SetAttacker(self)
					dmg:SetDamageType(DMG_FALL)
					dmg:SetDamagePosition(tumbled.HitPos)
					dmg:SetDamageForce(force)
					tumbled.Entity:TakeDamageInfo(dmg)
					local force_to_fall = 0.6
					if crashpct > force_to_fall then
						tply:BecomeRagdoll(dmg)
					end
				end
				tply:SetSpeed(min(tply:GetSpeedTarget(), SPEED_WALK))
			end
		end
		return true
	end,
	TripOver = function(self, tumbled, speed)
		if not IsFirstTimePredicted() then
			return
		end
		if not SERVER then
			return
		end
		local min = math.min
		local stepz = self:GetStepSize()
		local spos = self:GetPos() + Vector(0, 0, stepz)
		local tr = util.TraceHull({
			start = spos,
			endpos = spos + self:GetAngles():Forward() * 32,
			filter = self,
			mins = Vector(-1, -12, 0),
			maxs = Vector(1, 12, 1)
		})
		if not tr.Hit then
			return false
		end
		local force = (tumbled.StartPos - tumbled.HitPos):GetNormal() * speed
		force:Mul(-0.75)
		force.z = 0
		self:EmitSound("NPC_BaseZombie.Swat")
		if SERVER then
			self:SetSpeed(min(self:GetSpeedTarget(), SPEED_WALK))
		end
		local crashpct = speed / TUMBLE_HARD
		do
			local dmg = DamageInfo()
			dmg:SetDamage(8 * crashpct)
			dmg:SetAttacker(self)
			dmg:SetDamageType(DMG_FALL)
			dmg:SetDamagePosition(tumbled.StartPos)
			dmg:SetDamageForce(force)
			self:TakeDamageInfo(dmg)
		end
		self:BecomeRagdoll(dmg)
		return true
	end
}) do
	meta[k] = v
end
local Tumble
do
	local _class_0
	local _parent_0 = MODULE
	local _base_0 = { }
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
		__name = "Tumble",
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
	Tumble = _class_0
	return _class_0
end
