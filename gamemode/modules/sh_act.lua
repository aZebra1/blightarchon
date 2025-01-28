local meta = FindMetaTable('Player')
for k, v in pairs({
	DoingSomething = function(self)
		return self:GetState() == STATE.ACTING
	end,
	Do = function(self, act, ...)
		if self:DoingSomething() then
			return
		end
		if not self:Alive() then
			return
		end
		if isnumber(act) then
			act = ACT.acts[act]
		end
		if self:GetIsRagdoll() and not act.RagdollAct then
			return
		end
		if act.Immobilizes then
			local len2d = self:GetVelocity():Length2D()
			len2d = len2d * 1.02
			if len2d >= TUMBLE_OUCH - 50 then
				if SERVER then
					self:BecomeRagdoll()
				end
				return
			end
		end
		self.Doing = act(self, ...)
		if self.Doing:Impossible() then
			return
		end
		return self:AlterState(STATE.ACTING)
	end
}) do
	meta[k] = v
end
local _anon_func_0 = function(ply)
	local _obj_0 = ply.Doing
	if _obj_0 ~= nil then
		return _obj_0.Immobilizes
	end
	return nil
end
local Act
local _class_0
local _parent_0 = MODULE
local _base_0 = {
	InputMouseApply = function(self, cmd, x, y, ang)
		if math.abs(x) + math.abs(y) <= 0 then
			return
		end
		local ply = LocalPlayer()
		if (ply:DoingSomething() and _anon_func_0(ply)) or ply.GettingUp then
			cmd:SetMouseX(0)
			cmd:SetMouseY(0)
			return true
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
	__name = "Act",
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
Act = _class_0
return _class_0
