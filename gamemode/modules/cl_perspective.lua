local Clamp = math.Clamp
local Perspective
local _class_0
local bones
local _parent_0 = MODULE
local _base_0 = {
	ViewOffsets = {
		up = 0,
		forward = 3,
		forward2 = 0,
		leftright = 0
	},
	SmoothFactor = 0.1,
	RollFactor = 0.1,
	ZNear = 0.4,
	VForward = Vector(0, 0, 0),
	FrameTime = 1,
	EyeAngles = Angle(0, 180, 0),
	CurAngles = nil,
	CurPos = nil,
	ViewTable = { },
	FinalOffset = Vector(0, 0, 0),
	Attachment = 0,
	FOV = 110,
	FirstPersonView = function(self, ply, pos, ang, fov)
		local rag = ply:GetRagdoll()
		if rag and rag:IsValid() then
			return self.Attachment.Pos, self.Attachment.Ang
		end
		self.VForward = ply:GetAimVector()
		self.FrameTime = FrameTime()
		self.EyeAngles = ply:EyeAngles()
		local ox, oy, oz, orl = 0, 0, 0, 0
		do
			local _with_0 = self.ViewOffsets
			_with_0.leftright = Lerp(self.FrameTime * 6, _with_0.leftright, ox)
			_with_0.forward = Lerp(self.FrameTime * 4, _with_0.forward, oy)
			_with_0.up = Lerp(self.FrameTime * 4, _with_0.up, oz)
		end
		self.RollFactor = Lerp(Clamp(self.FrameTime * 15, 0, 1), self.RollFactor, orl)
		do
			local _with_0 = self.FinalOffset
			_with_0.x = self.VForward.x * (self.ViewOffsets.forward + self.ViewOffsets.forward2)
			_with_0.y = self.VForward.y * (self.ViewOffsets.forward + self.ViewOffsets.forward2)
			_with_0.z = self.ViewOffsets.up
		end
		self.FinalOffset = self.FinalOffset + ply:GetRight() * self.ViewOffsets.leftright
		ang = ang + (Angle(0, 0, self.Attachment.Ang.r * self.RollFactor))
		pos = self.Attachment.Pos
		pos = pos + self.FinalOffset + ply:GetForward() * 2
		local tr = util.TraceLine({
			start = self.Attachment.Pos,
			endpos = pos,
			filter = ply
		})
		pos = tr.HitPos
		return pos, ang
	end,
	CalcView = function(self, ply, pos, ang, fov)
		if DEVCAM then
			local body = ply:GetBodyEntity()
			for _index_0 = 1, #bones do
				local bone = bones[_index_0]
				bone = body:LookupBone(bone)
				if bone then
					body:ManipulateBoneScale(bone, Vector(1, 1, 1))
				end
			end
			self.ViewTable = {
				origin = DEVCAM.pos,
				angles = DEVCAM.ang,
				fov = self.FOV,
				znear = Clamp(self.ZNear, 0.1, 1),
				drawviewer = true
			}
		else
			local body = ply:GetBodyEntity()
			for _index_0 = 1, #bones do
				local bone = bones[_index_0]
				local shrink, not_shrink = Vector(0, 0, 0), Vector(1, 1, 1)
				local val = shrink
				if body:GetClass() == "prop_ragdoll" and not ply:Alive() then
					val = not_shrink
				end
				bone = body:LookupBone(bone)
				if bone then
					body:ManipulateBoneScale(bone, val)
				end
			end
			self.Attachment = body:GetAttachment(body:LookupAttachment("eyes"))
			local ePos, eAng = self:FirstPersonView(ply, pos, ang, fov)
			self.CurPos = ePos
			self.CurAngles = LerpAngle(Clamp(self.FrameTime * (65 * self.SmoothFactor), 0, 1), self.CurAngles or ang, eAng)
			local fov_target = 110
			self.FOV = Lerp(0.01, self.FOV, fov_target)
			self.ViewTable = {
				origin = self.CurPos,
				angles = self.CurAngles + ply:GetViewPunchAngles(),
				fov = self.FOV,
				znear = Clamp(self.ZNear, 0.1, 1),
				drawviewer = true
			}
		end
		return self.ViewTable
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
	__name = "Perspective",
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
local self = _class_0;
bones = {
	"ValveBiped.Bip01_Head1",
	"ValveBiped.Bip01_Neck1"
}
if _parent_0.__inherited then
	_parent_0.__inherited(_parent_0, _class_0)
end
Perspective = _class_0
return _class_0
