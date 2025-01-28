BIND("behold", KEY_B, {
	Press = function(self, ply)
		if CLIENT then
			if not (not ply.NextInspect or ply.NextInspect < CurTime()) then
				return
			end
			ply.NextInspect = CurTime() + 0.5
			local tr = ply:GetInteractTrace(248)
			local ent = tr.Entity
			if not tr.Entity:IsValid() then
				return
			end
			local txt = _ud83d_udcbe.Inspect:Inspect(ply, ent)
			return _ud83d_udcbe.Inspect:MakeBubble(ply, ent, txt)
		end
	end
})
local Inspect
local _class_0
local _parent_0 = MODULE
local _base_0 = {
	Inspect = function(self, ply, ent)
		local text = ent:GetClass()
		if ent.IName then
			text = ent.IName
		end
		do
			local _obj_0 = ent.ProcessIName
			if _obj_0 ~= nil then
				text = _obj_0(ent, text or text)
			end
		end
		if text == ent:GetClass() then
			local _exp_0 = ent:GetClass()
			if 'prop_ragdoll' == _exp_0 then
				local who = ent:GetNWEntity('Player')
				text = 'fresh body...'
				if who and (IsValid(who)) and who:IsPlayer() and who:Alive() then
					text = text .. "... alive"
				else
					text = _ud83d_udcbe.Decay.stages[ent:GetNWInt("decay_stage", DECAYSTAGE_FRESH)].name
					text = text .. "... asleep forever"
				end
			elseif 'prop_physics' == _exp_0 then
				text = 'trash'
			end
		end
		if ent:IsPlayer() and ent:Alive() then
			text = ent:Nick()
		end
		local ele = ent.Element
		if ele and ele.IName then
			text = tostring(ele.IName) .. " " .. tostring(text)
		end
		return text
	end,
	MakeBubble = function(self, ply, ent, txt)
		local pos = ent:GetPos()
		if ent:IsPlayer() and ent:Alive() then
			pos = ent:WorldSpaceCenter()
		end
		return BUBBLE({
			text = tostring(txt),
			font = "spleen_chat",
			pos = pos,
			char = NULL,
			text_color = Color(128, 128, 128),
			vol = 0.5,
			move = Vector(0, 0, 0.025),
			speed = 0.5,
			lifespan = 6,
			clingy = false,
			auditory = false,
			speech = false
		})
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
	__name = "Inspect",
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
Inspect = _class_0
return _class_0
