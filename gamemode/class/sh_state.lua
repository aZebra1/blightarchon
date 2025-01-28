local upper = string.upper
local insert = table.insert
local _class_0
local _base_0 = {
	Think = function(self, ply) end,
	Enter = function(self, ply, oldstate) end,
	Continue = function(self, ply) end,
	Exit = function(self, ply, newstate) end,
	Move = function(self, ply, mv) end,
	HandleMidair = function(self, ply, vel, animset)
		if ply.Jumping then
			if ply.FirstJumpFrame then
				ply.FirstJumpFrame = false
				ply:AnimRestartMainSequence()
			end
			if ply:WaterLevel() >= 2 then
				ply.Jumping = false
				ply:AnimRestartMainSequence()
			end
			if not ply.Landing then
				if (CurTime() - ply.JumpStart) > .4 and ply:OnGround() then
					ply.Landing = true
					ply.LandStart = CurTime()
					if CLIENT then
						ply:Spasm('jump_land')
					end
					return true
				end
			elseif (CurTime() - ply.LandStart) > .3 then
				ply.Landing = false
				ply.Jumping = false
			end
			if ply.Jumping and not ply.Landing then
				ply.CalcSeqOverride = ply:FindSequence(animset.jump)
				return true
			end
		end
		return false
	end,
	CalcMainActivity = function(self, ply, vel, animset)
		if animset == nil then
			animset = ANIMS.normal
		end
		if self:HandleMidair(ply, vel, animset) then
			return
		end
		if self.HandleSquat then
			if self:HandleSquat(ply, vel, animset) then
				return
			end
		end
		if self.HandleProne then
			if self:HandleProne(ply, vel, animset) then
				return
			end
		end
		local len2d = vel:Length2D()
		ply.CalcSeqOverride = ply:FindSequence(animset.idle)
		if (len2d > SPEED_RUN * 1.5) then
			ply.CalcSeqOverride = ply:FindSequence(animset.sprint)
		elseif (len2d > SPEED_WALK * 1.5) then
			ply.CalcSeqOverride = ply:FindSequence(animset.run)
		elseif len2d > 0.5 then
			ply.CalcSeqOverride = ply:FindSequence(animset.walk)
		end
		return ply
	end,
	Jumped = function(self, ply)
		ply.Jumping = true
		ply.Landing = false
		ply.FirstJumpFrame = true
		ply.JumpStart = CurTime()
		ply:AnimRestartMainSequence()
		if CLIENT and IsFirstTimePredicted() then
			ply:ViewPunch(Angle(-5, 0, 0))
		end
		return ply
	end
}
if _base_0.__index == nil then
	_base_0.__index = _base_0
end
_class_0 = setmetatable({
	__init = function() end,
	__base = _base_0,
	__name = "STATE"
}, {
	__index = _base_0,
	__call = function(cls, ...)
		local _self_0 = setmetatable({ }, _base_0)
		cls.__init(_self_0, ...)
		return _self_0
	end
})
_base_0.__class = _class_0
local self = _class_0;
self.states = { }
self.__inherited = function(self, child)
	self[upper(child.__name)] = insert(self.states, child)
end
STATE = _class_0
