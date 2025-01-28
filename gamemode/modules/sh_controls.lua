BIND('ctrl', KEY_LCONTROL, {
	Press = function(self, ply)
		local body = ply:GetBodyEntity()
		if body:IsRagdoll() then
			return
		end
		if ply:OnGround() then
			if not ply:DoingSomething() then
				if SERVER or (CLIENT and IsFirstTimePredicted()) then
					if not ply:StanceIs(STANCE_SQUAT) then
						return ply:Do(ACT.STANCE_SQUAT)
					else
						return ply:Do(ACT.STANCE_RISEN)
					end
				end
			end
		end
	end
})
BIND('space', KEY_SPACE, {
	Press = function(self, ply)
		if ply:Alive() and ply:GetIsRagdoll() then
			local rag = ply:GetRagdoll()
			if not (rag:GetVelocity():Length2D() > 5) then
				ply:Do(ACT.STAND_UP)
			end
		end
		if ply:OnGround() then
			if not ply:DoingSomething() then
				if SERVER or (CLIENT and IsFirstTimePredicted()) then
					if not ply:StanceIs(STANCE_PRONE) then
						if ply:StanceIs(STANCE_SQUAT) then
							return ply:Do(ACT.STANCE_PRONE)
						else
							if BIND.controls['shift']:IsDown(ply) then
								return ply:Do(ACT.KICK)
							else
								return ply:Do(ACT.SHOVE)
							end
						end
					else
						return ply:Do(ACT.STANCE_RISEN)
					end
				end
			end
		end
	end
})
BIND('shift', KEY_LSHIFT, {
	Press = function(self, ply) end
})
local dont_do_these = {
	"+zoom",
	"messagemode",
	"messagemode2"
}
local _anon_func_0 = function(bind, dont_do_these)
	for _index_0 = 1, #dont_do_these do
		if dont_do_these[_index_0] == bind then
			return true
		end
	end
	return false
end
local Controls
local _class_0
local _parent_0 = MODULE
local _base_0 = {
	PlayerBindPress = function(self, ply, bind, down)
		if down then
			if (#dont_do_these > 0 and _anon_func_0(bind, dont_do_these)) then
				return true
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
	__name = "Controls",
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
Controls = _class_0
return _class_0
