BUTCHER_CUTS_OF_MEAT = 6
BUTCHER_DMG_TO_CUT = 30
local Butcher
do
	local _class_0
	local _parent_0 = MODULE
	local _base_0 = {
		EntityTakeDamage = function(self, ent, dmg)
			if not (ent:GetClass() == "prop_ragdoll" and ent.corpse) then
				return
			end
			if not (dmg:GetDamageType() == DMG_SLASH) then
				return
			end
			local stage = _ud83d_udcbe.Decay.stages[ent.decay_stage]
			local pos = dmg:GetDamagePosition()
			local item = table.Random(stage.yield)
			local butcher = dmg:GetAttacker() or NULL
			local skill = 5
			local edata = EffectData()
			edata:SetOrigin(pos)
			edata:SetScale(dmg:GetDamage())
			edata:SetStart(ent:GetVelocity())
			util.Effect("bloodspray", edata)
			if math.random(1, 30) < dmg:GetDamage() then
				return
			end
			if butcher:IsValid() and butcher:IsPlayer() and butcher:Alive() then
			end
			local req_skill = math.random(1, 10)
			if skill < req_skill then
				item = ENTITY.registered[item].RuinedResult or item
			end
			local thing = ENTITY:create(item, pos)
			if stage.yield_rotten and (function()
				local _base_1 = thing
				local _fn_0 = _base_1.Rot
				return _fn_0 and function(...)
					return _fn_0(_base_1, ...)
				end
			end)() then
				thing:Rot()
			end
			ent.cuts_of_meat = ent.cuts_of_meat + (-1)
			if ent.cuts_of_meat <= 0 then
				if ent.decay_stage ~= DECAYSTAGE_REMAINS then
					_ud83d_udcbe.Decay.stages[DECAYSTAGE_REMAINS].on_set(ent)
					ent.cuts_of_meat = BUTCHER_CUTS_OF_MEAT
					ent.decay_stage = DECAYSTAGE_REMAINS
					ent:SetNWInt("decay_stage", ent.decay_stage)
					ent:SetMaterial("models/skeleton/skeleton_bloody")
					return ent:SetColor(Color(255, 255, 255))
				else
					return ent:Remove()
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
		__name = "Butcher",
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
	Butcher = _class_0
	return _class_0
end
