MOVING_WALK = 1
MOVING_RUN = 2
SPEED_CREEP = 50
SPEED_WALK = 100
SPEED_RUN = 200
SPEED_SPRINT = 400
local hull = {
	mins = Vector(-13, -13, 8),
	maxs = Vector(13, 13, 72)
}
local Movement
do
	local _class_0
	local _parent_0 = MODULE
	local _base_0 = {
		GetSpeedTarget = function(self, ply, mv)
			if ply:StanceIs(STANCE_SQUAT) or ply:StanceIs(STANCE_PRONE) then
				return SPEED_CREEP + (SPEED_WALK - SPEED_CREEP) / 2
			elseif not mv:KeyDown(IN_FORWARD) then
				return SPEED_WALK
			else
				if (not mv:KeyDown(IN_SPEED)) and ply:GetSpeed() < SPEED_WALK * 1.3 then
					return SPEED_WALK
				end
				local target = ply:GetSpeedTarget()
				if target < SPEED_CREEP then
					ply:SetSpeedTarget(SPEED_CREEP)
					target = SPEED_CREEP
				elseif target > SPEED_SPRINT then
					ply:SetSpeedTarget(SPEED_SPRINT)
					target = SPEED_SPRINT
				end
				return target
			end
		end,
		SetupMove = function(self, ply, mv, cmd)
			mv:SetButtons(bit.band(mv:GetButtons(), bit.bnot(IN_JUMP + IN_DUCK)))
			local min, max = math.min, math.max
			if (not IsFirstTimePredicted()) or (not ply.GetSpeed) or (not ply:Alive()) or ply:GetMoveType() == MOVETYPE_NOCLIP then
				return true
			end
			local speeding = mv:KeyDown(IN_FORWARD) and (mv:KeyDown(IN_SPEED) or ply:GetSpeed() >= SPEED_WALK * 1.3)
			local speedlerp = 0.01
			local tumbled = ply:TumbleCheck(hull, 1, ply:GetAngles())
			local target = self:GetSpeedTarget(ply, mv)
			if target < SPEED_WALK and (ply:GetVelocity():Length2D() < SPEED_RUN / 1.5) then
				speedlerp = 0.5
			else
				ply.Moving = speeding and MOVING_RUN or MOVING_WALK
				speedlerp = speeding and 0.01 or 0.03
				if tumbled.Hit then
					target = SPEED_WALK
					speedlerp = 0.1
				end
			end
			local speed = Lerp(speedlerp, ply:GetSpeed(), target)
			ply:SetSpeed(speed)
			if ply.Moving ~= MOVING_WALK and speed < SPEED_WALK * 1.3 then
				ply.Moving = MOVING_WALK
			end
			if mv:KeyDown(IN_SPEED) then
				local wheel = cmd:GetMouseWheel()
				if wheel ~= 0 then
					local newtarg = math.Clamp(ply:GetSpeedTarget() + wheel * 25, SPEED_CREEP, SPEED_SPRINT)
					ply:SetSpeedTarget(newtarg)
					if CLIENT then
						local snd
						if wheel < 0 then
							snd = "hl1/fvox/fuzz.wav"
						else
							snd = "hl1/fvox/buzz.wav"
						end
						ply:EmitSound(snd, 75, 75 + (50 * (ply:GetSpeedTarget() / SPEED_SPRINT)), 0.1)
					end
				end
			end
			if (not speeding) and speed > SPEED_RUN / 1.5 and ply:IsOnGround() then
				mv:SetForwardSpeed(speed)
			end
			ply:SetRunSpeed(speed)
			ply:SetWalkSpeed(speed)
			local len2d = ply:GetVelocity():Length2D()
			len2d = len2d * 1.02
			local rag = ply:GetRagdoll()
			if len2d >= TUMBLE_SOFT and (not rag or not rag:IsValid()) then
				if (not ply.NextTumble) or CurTime() >= ply.NextTumble then
					if not ply:BumpChest(len2d) then
						if not ply:BumpHead(len2d) then
							ply:BumpLegs(len2d)
						end
					end
				end
			end
			return true
		end,
		PlayerSpawn = function(self, ply)
			ply:SetSpeed(SPEED_WALK)
			ply:SetSpeedTarget(SPEED_WALK)
			ply.Moving = MOVING_WALK
			return
		end,
		TranslateActivity = function(self, ply, act)
			local oact = act
			if ACT_MP_RUN == act then
				local vel = ply:GetVelocity()
				if vel:Length2D() >= SPEED_RUN * 1.5 then
					act = ACT_HL2MP_RUN_FAST
				end
			end
			if act ~= oact then
				return act
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
		__name = "Movement",
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
	Movement = _class_0
	return _class_0
end
