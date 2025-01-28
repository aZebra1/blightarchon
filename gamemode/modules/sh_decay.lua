DECAYSTAGE_FRESH = 0
DECAYSTAGE_BLOAT = 1
DECAYSTAGE_ACTIVE = 2
DECAYSTAGE_ADVANCED = 3
DECAYSTAGE_REMAINS = 4
DECAYSTAGE_CREMATED = 5
DECAY_TIME = 3
DECAY_POINTS_TO_PROGRESS = 15
local SwapRagdollModels
SwapRagdollModels = function(ent, mdl, mat)
	if mat == nil then
		mat = ""
	end
	local new = ents.Create("prop_ragdoll")
	new:SetPos(ent:GetPos())
	new:SetAngles(ent:GetAngles())
	new:SetModel(mdl)
	new:SetMaterial(mat)
	new.corpse = true
	new.cuts_of_meat = ent.cuts_of_meat
	new.decay_stage = ent.decay_stage
	new:SetNWIng("decay_stage", new.decay_stage)
	new.decay_points = ent.decay_points
	new.decay_start = ent.decay_start
	new.decay_end = ent.decay_end
	new:Spawn()
	new:Activate()
	local num = new:GetPhysicsObjectCount() - 1
	local ve = ent:GetVelocity()
	new:Fire("disablemotion")
	for i = 0, num do
		local bone = new:GetPhysicsObjectNum(i)
		if IsValid(bone) then
			local bp, ba = ent:GetBonePosition(new:TranslatePhysBoneToBone(i))
			if bp and ba then
				bone:SetPos(bp)
				bone:SetAngles(ba)
			end
		end
	end
	new:Fire("enablemotion", "", 0.5)
	return ent:Remove()
end
local Decay
do
	local _class_0
	local _parent_0 = MODULE
	local _base_0 = {
		stages = {
			[DECAYSTAGE_FRESH] = {
				name = "fresh body",
				on_set = function(rag) end,
				yield = {
					'thing/food/meat/human',
					'thing/food/meat/human',
					'thing/food/bandage'
				}
			},
			[DECAYSTAGE_BLOAT] = {
				name = "bloated body",
				on_set = function(rag)
					return rag:SetColor(Color(250, 0, 250))
				end,
				sound = "CorpseRotBloat",
				yield = {
					'thing/food/meat/blood.clot'
				},
				yield_rotten = true
			},
			[DECAYSTAGE_ACTIVE] = {
				name = "maggot-infesed body",
				on_set = function(rag)
					rag:SetMaterial("models/zombie_fast_players/fast_zombie_sheet")
					return rag:SetColor(Color(75, 200, 75))
				end,
				sound = "CorpseRotActive",
				yield = {
					'thing/food/meat/gore'
				},
				yield_rotten = true,
				miasma_color = Color(20, 80, 20)
			},
			[DECAYSTAGE_ADVANCED] = {
				name = "horrifically revolting caracass",
				on_set = function(rag)
					rag:SetColor(Color(255, 255, 255))
					if not rag.Headless then
						rag:SetBodygroup(0, 2)
					end
					return rag:SetMaterial("models/skeleton/skeleton_decomp")
				end,
				sound = "CorpseRotAdvanced",
				yield = {
					'thing/food/meat/gore/char'
				},
				yield_rotten = true,
				miasma_color = Color(100, 40, 115)
			},
			[DECAYSTAGE_REMAINS] = {
				name = "skeletal remains",
				on_set = function(rag)
					if not rag.Headless then
						rag:SetBodygroup(0, 4)
					end
					rag:SetBodygroup(7, 4)
					rag:SetMaterial("models/skeleton/skeleton_decomp")
					return rag:SetCollisionGroup(COLLISION_GROUP_WEAPON)
				end,
				yield = {
					'thing/junk/bone'
				},
				yield_rotten = true
			},
			[DECAYSTAGE_CREMATED] = {
				on_set = function(rag)
					rag:SetMaterial("")
					if not rag.Headless then
						rag:SetBodygroup(0, 4)
					end
					return rag:SetBodygroup(7, 4)
				end,
				yield = {
					'thing/food/meat/char'
				},
				yield_rotten = false
			}
		},
		Think = function(self, ply)
			for _, rag in ipairs(ents.FindByClass("prop_ragdoll")) do
				local _continue_0 = false
				repeat
					if not rag.corpse then
						_continue_0 = true
						break
					end
					if rag.decay_stage == DECAYSTAGE_REMAINS or rag.decay_stage == DECAYSTAGE_CREMATED and not rag.no_bleed then
						_continue_0 = true
						break
					end
					if rag.decay_end <= CurTime() then
						if rag.decay_stage > DECAYSTAGE_FRESH then
							rag:EmitSound("Flies")
						end
						if self.stages[rag.decay_stage] and self.stages[rag.decay_stage].sound then
							rag:EmitSound(self.stages[rag.decay_stage].sound)
						end
						rag.decay_points = rag.decay_points + 1
						rag.decay_start = CurTime()
						rag.decay_end = rag.decay_start + math.Round(DECAY_TIME * math.random(0.7, 1.3))
						if self.stages[rag.decay_stage].miasma_color then
							local col = self.stages[rag.decay_stage].miasma_color
							local edata = EffectData()
							edata:SetOrigin(rag:GetPos())
							edata:SetScale(10 + (rag.decay_points / 2))
							edata:SetColor(col.r, col.g, col.r)
							local miasmas = _ud83c_udfb2(2, 5)
							for i = 1, miasmas do
								edata:SetStart(Vector(_ud83c_udfb2(-27, 27), _ud83c_udfb2(-27, 27), 0))
								util.Effect("miasma", edata)
							end
						end
						if rag.decay_points > DECAY_POINTS_TO_PROGRESS then
							rag.decay_points = 0
							rag.decay_stage = rag.decay_stage + 1
							self.stages[rag.decay_stage].on_set(rag)
						end
						rag:SetNWInt("decay_stage", rag.decay_stage)
					end
					_continue_0 = true
				until true
				if not _continue_0 then
					break
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
		__name = "Decay",
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
	Decay = _class_0
end
local Flies
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = (function()
			local _accum_0 = { }
			local _len_0 = 1
			for i = 1, 5 do
				_accum_0[_len_0] = "ambient/creatures/flies" .. tostring(i) .. ".wav"
				_len_0 = _len_0 + 1
			end
			return _accum_0
		end)(),
		level = SNDLVL_NORM
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
		__name = "Flies",
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
	Flies = _class_0
end
local CorpseRotBloat
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = (function()
			local _accum_0 = { }
			local _len_0 = 1
			for i = 1, 2 do
				_accum_0[_len_0] = "npc/barnacle/barnacle_digesting" .. tostring(i) .. ".wav"
				_len_0 = _len_0 + 1
			end
			return _accum_0
		end)(),
		level = SNDLVL_50dB
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
		__name = "CorpseRotBloat",
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
	CorpseRotBloat = _class_0
end
local CorpseRotActive
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = (function()
			local _accum_0 = { }
			local _len_0 = 1
			for i = 1, 3 do
				_accum_0[_len_0] = "npc/barnacle/barnacle_tongue_pull" .. tostring(i) .. ".wav"
				_len_0 = _len_0 + 1
			end
			return _accum_0
		end)(),
		level = SNDLVL_50dB
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
		__name = "CorpseRotActive",
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
	CorpseRotActive = _class_0
end
local CorpseRotAdvanced
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = (function()
			local _accum_0 = { }
			local _len_0 = 1
			for i = 1, 2 do
				_accum_0[_len_0] = "npc/barnacle/barnacle_crunch" .. tostring(i) .. ".wav"
				_len_0 = _len_0 + 1
			end
			return _accum_0
		end)(),
		level = SNDLVL_50dB
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
		__name = "CorpseRotAdvanced",
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
	CorpseRotAdvanced = _class_0
end
local FoodRot
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = (function()
			local _accum_0 = { }
			local _len_0 = 1
			for i = 1, 3 do
				_accum_0[_len_0] = "weapons/bugbait/bugbait_squeeze" .. tostring(i) .. ".wav"
				_len_0 = _len_0 + 1
			end
			return _accum_0
		end)(),
		level = SNDLVL_50dB
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
		__name = "FoodRot",
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
	FoodRot = _class_0
	return _class_0
end
