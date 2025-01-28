local meta = FindMetaTable('Player')
local _anon_func_0 = function(pairs, self)
	local _tab_0 = {
		self:Wielding(),
		self:WieldingOffhand()
	}
	local _obj_0 = self:BeltItems()
	local _idx_0 = 1
	for _key_0, _value_0 in pairs(_obj_0) do
		if _idx_0 == _key_0 then
			_tab_0[#_tab_0 + 1] = _value_0
			_idx_0 = _idx_0 + 1
		else
			_tab_0[_key_0] = _value_0
		end
	end
	return _tab_0
end
for k, v in pairs({
	GetBodyEntity = function(self)
		local rag = self:GetRagdoll()
		if rag and rag:IsValid() and not (rag.corpse and self:Alive()) then
			return rag
		end
		return self
	end,
	GetHeadPos = function(self)
		local head = self:LookupBone('ValveBiped.Bip01_Head1')
		if head then
			return self:GetBonePosition(head)
		else
			return self:EyePos()
		end
	end,
	BecomeRagdoll = function(self, dmginfo, corpse)
		local rag = self:GetRagdoll()
		local body = self.Body
		if rag and rag:IsValid() then
			body = rag.Body
		end
		if rag and rag:IsValid() then
			rag:Remove()
		end
		local _list_0 = _anon_func_0(pairs, self)
		for _index_0 = 1, #_list_0 do
			local thing = _list_0[_index_0]
			if IsValid(thing) then
				self:Release(thing)
			end
		end
		self:DropObject()
		self:SetIsRagdoll(true)
		local vel = self:GetVelocity()
		do
			rag = ents.Create('prop_ragdoll')
			rag:SetPos(self:GetPos())
			rag:SetAngles(self:GetAngles())
			rag:SetModel(self:GetModel())
			rag:SetSkin(self:GetSkin())
			for i = 0, 20 do
				rag:SetBodygroup(i, self:GetBodygroup(i))
				rag:SetSubMaterial(i, self:GetSubMaterial(i))
			end
			rag:Spawn()
			rag:Activate()
			if SERVER then
				rag.Body = { }
				for k, v in pairs(body) do
					rag.Body[k] = v
					v:SetParent(rag)
					v.RenderGroup = RENDERGROUP_BOTH
				end
				self.Body = nil
			end
			rag:SetNWEntity('Player', self)
			self:SetRagdoll(rag)
			for i = 0, rag:GetPhysicsObjectCount() - 1 do
				local bone_idx = rag:TranslatePhysBoneToBone(i)
				local phys_obj = rag:GetPhysicsObjectNum(i)
				if IsValid(phys_obj) then
					local pos, ang = self:GetBonePosition(bone_idx)
					phys_obj:SetPos(pos)
					phys_obj:SetAngles(ang)
					phys_obj:SetVelocity(vel)
				end
			end
			if SERVER then
				self:SetNotSolid(true)
				if not rag.corpse then
					rag:CallOnRemove("TransportPlayer", function(ent)
						local ply = ent:GetNWEntity('Player')
						if IsValid(ply) then
							if ply.SetIsRagdoll then
								ply:SetIsRagdoll(false)
							end
							ply:SetPos(ent:GetPos())
							ply:SetNotSolid(false)
							if ent.Body then
								ply.Body = ply.Body or { }
								for k, v in pairs(ent.Body) do
									ply.Body[k] = v
									v:SetParent(self)
									v.RenderGroup = RENDERGROUP_OTHER
								end
							end
						end
					end)
				end
			end
		end
		local _list_1 = {
			'GetHeadPos',
			'CanHear',
			'GetHitBone',
			'GetHitBox',
			'HeadBlownApart',
			'RemoveHead'
		}
		for _index_0 = 1, #_list_1 do
			local k = _list_1[_index_0]
			rag[k] = self[k]
		end
		rag.SetKnockback = function(self, vel, force)
			local head_idx = self:LookupBone("ValveBiped.Bip01_Head1")
			for i = 0, self:GetPhysicsObjectCount() - 1 do
				local bone_idx = self:TranslatePhysBoneToBone(i)
				local phys_obj = self:GetPhysicsObjectNum(i)
				if IsValid(phys_obj) then
					if bone_idx == head_idx then
						phys_obj:SetVelocity(vel * 1.5)
					else
						phys_obj:SetVelocity(vel)
					end
					if force then
						if bone_idx == head_idx then
							phys_obj:ApplyForceCenter(force * 1.5)
						else
							phys_obj:ApplyForceCenter(force)
						end
					end
				end
			end
		end
		rag.GetPlayer = function(self)
			return self
		end
		rag.Corpsify = function(self)
			self.corpse = true
			self:SetNWEntity('Player', NULL)
			self.cuts_of_meat = BUTCHER_CUTS_OF_MEAT
			self.decay_stage = DECAYSTAGE_FRESH
			self:SetNWInt('decay_stage', DECAYSTAGE_FRESH)
			self.decay_points = 0
			self.decay_start = CurTime()
			self.decay_end = self.decay_start + DECAY_TIME
		end
		rag:SetVelocity(vel)
		if self:GetNWBool("headless", false) then
			rag:SetBodygroup(0, 3)
		end
		return rag
	end,
	RestoreFromRagdoll = function(self)
		local rag = self:GetRagdoll()
		if not (rag and rag:IsValid()) then
			return
		end
		for i = 0, 20 do
			self:SetBodygroup(i, rag:GetBodygroup(i))
			self:SetSubMaterial(i, rag:GetSubMaterial(i))
		end
		if rag.Body then
			self.Body = self.Body or { }
			for k, v in pairs(rag.Body) do
				self.Body[k] = v
				v:SetParent(self)
				v.RenderGroup = RENDERGROUP_OTHER
			end
		else
			self:InitializeBody()
		end
		return rag:Remove()
	end
}) do
	meta[k] = v
end
local Fall_Over
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = (function()
			local _accum_0 = { }
			local _len_0 = 1
			for i = 1, 7 do
				_accum_0[_len_0] = "physics/body/body_medium_impact_soft" .. tostring(i) .. ".wav"
				_len_0 = _len_0 + 1
			end
			return _accum_0
		end)(),
		level = SNDLVL_60dB
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
		__name = "Fall_Over",
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
	Fall_Over = _class_0
end
BIND("fall_over", KEY_T, {
	Press = function(self, ply)
		if SERVER then
			if not (ply:Alive() and not ply:GetIsRagdoll()) then
				return
			end
			local rag = ply:GetRagdoll()
			if rag and rag:IsValid() then
				return
			end
			return ply:BecomeRagdoll()
		end
	end
})
local Ragdoll
local _class_0
local _parent_0 = MODULE
local _base_0 = {
	PlayerTick = function(self, ply)
		if not ply.GetRagdoll then
			return
		end
		local rag = ply:GetRagdoll()
		if not (rag and rag:IsValid()) then
			return
		end
		ply:SetPos(rag:GetPos())
		if rag.DraggedBy then
			if not (IsValid(rag.DraggedBy) and rag:IsPlayerHolding() and rag.DraggedBy:GetDragging() == rag) then
				rag.DraggedBy = nil
				return
			end
		end
		return
	end,
	PlayerFootstep = function(self, ply)
		local rag = ply:GetRagdoll()
		if rag and rag:IsValid() then
			return true
		end
	end,
	PlayerDeath = function(self, ply, attacker, dmg)
		local rag = ply:GetRagdoll()
		if (not rag) or (not rag:IsValid()) then
			rag = ply:BecomeRagdoll(dmg, true)
		end
		rag:Corpsify()
		return
	end,
	PlayerSpawn = function(self, ply)
		ply:SetIsRagdoll(false)
		ply:SetRagdoll(nil)
		ply:SetNoDraw(false)
		ply:SetNotSolid(false)
		return
	end,
	PlayerDisconnected = function(self, ply)
		return ply:Kill()
	end,
	EntityTakeDamage = function(self, ent, dmginfo)
		if not (IsValid(ent) and ent:GetClass() == "prop_ragdoll") then
			return
		end
		if ent.corpse and dmginfo:GetDamageType() == DMG_BLAST then
			self:Gib(ent, dmginfo)
		end
		if not ent:GetNWEntity('Player') then
			return
		end
		local ply = ent:GetNWEntity('Player')
		if not (ply and ply:IsValid() and ply:GetIsRagdoll() and ply:Alive()) then
			return
		end
		local attacker = dmginfo:GetAttacker()
		if attacker and attacker:IsValid() and attacker:GetClass() == "prop_ragdoll" then
			return
		end
		if dmginfo:GetDamageType() == DMG_CRUSH then
			dmginfo:ScaleDamage(0.5)
		end
		return ply:TakeDamageInfo(dmginfo)
	end,
	Gib = function(self, rag, dmginfo)
		if rag.removing then
			return
		end
		rag.removing = true
		rag:SetNWEntity("Player", NULL)
		rag:EmitSound('physics/flesh/flesh_bloody_break.wav')
		ENTITY:create('thing/food/meat/gore', rag:GetPos())
		rag:Remove()
		return
	end,
	PreDrawTranslucentRenderables = function(self, bDepth, bSkybox)
		if bDepth then
			return
		end
		local _list_0 = ents.FindByClass("prop_ragdoll")
		for _index_0 = 1, #_list_0 do
			local corpse = _list_0[_index_0]
			local _list_1 = corpse:GetChildren()
			for _index_1 = 1, #_list_1 do
				local piece = _list_1[_index_1]
				if piece:GetClass() == "bonemerge" then
					piece:DrawModel()
				end
			end
		end
		return
	end,
	OnEntityCreated = function(self, rag)
		if CLIENT and rag:IsRagdoll() then
			timer.Simple(0.1, function()
				if not (rag:IsValid() and rag:IsRagdoll()) then
					return
				end
				local ply = rag:GetNWEntity('Player')
				if ply:IsValid() then
					if rag:GetCreationTime() > CurTime() - 1 then
						rag:SnatchModelInstance(ply)
					end
					rag.GetPlayer = function()
						return ply
					end
					rag.GetPlayerColor = function(self)
						ply = self:GetPlayer()
						if IsValid(ply) then
							return ply:GetPlayerColor()
						end
					end
				end
			end)
		end
		return
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
	__name = "Ragdoll",
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
Ragdoll = _class_0
return _class_0
