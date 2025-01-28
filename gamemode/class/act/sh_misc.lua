local rag_orientation
rag_orientation = function(rag)
	if not (rag and IsValid(rag)) then
		return
	end
	local chest_id = rag:LookupBone("ValveBiped.Bip01_Spine1")
	local chest_pos, chest_ang = rag:GetBonePosition(chest_id)
	local result_pos = chest_pos + chest_ang:Forward() * 8
	if result_pos.y > chest_pos.y then
		return "wos_mma_standup_front01"
	end
	return "wos_mma_standup_back01"
end
local STAND_UP
local _class_0
local _parent_0 = ACT
local _base_0 = {
	RagdollAct = true,
	Immobilizes = true,
	Do = function(self, fromstate)
		self.GettingUp = true
		if not SERVER then
			return
		end
		local rag = self.ply:GetRagdoll()
		do
			local _with_0 = self.ply
			_with_0:SetNoTarget(false)
			_with_0:SetNotSolid(false)
			_with_0:DrawWorldModel(true)
			_with_0:DrawViewModel(true)
			_with_0:UnSpectate()
		end
		local sequence = rag_orientation(rag)
		self.ply:RestoreFromRagdoll()
		return self:Spasm({
			sequence = sequence,
			slot = GESTURE_SLOT_JUMP,
			SS = true
		})
	end,
	Then = function(self)
		_class_0.__parent.__base.Then(self)
		self.ply.GettingUp = false
		if self.ply:Stuck() then
			return self.ply:Unstuck()
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
	__name = "STAND_UP",
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
STAND_UP = _class_0
return _class_0
