local meta = FindMetaTable('Player')
for k, v in pairs({
	InitializeBody = function(self)
		self.Body = self.Body or { }
		local segments = {
			"torso",
			"legs"
		}
		for _index_0 = 1, #segments do
			local s = segments[_index_0]
			local segment = ents.Create("bonemerge")
			segment:SetModel("models/in/player/every" .. tostring(s) .. ".mdl")
			segment:SetParent(self)
			segment:Spawn()
			if self.Body[s] then
				self.Body[s]:Remove()
			end
			self.Body[s] = segment
		end
		for i = 1, 9 do
			self:SetBodygroup(i, 0)
		end
		return self:SetBodygroup(self:FindBodygroupByName("hands"), 1)
	end,
	GetViewOrigin = function(self)
		local pos
		local ang
		local ent = self:GetBodyEntity()
		if not IsValid(ent) then
			return
		end
		local head = ent:LookupBone('ValveBiped.Bip01_Head1')
		if head then
			if CLIENT then
				ent:SetupBones()
			end
			local matrix = ent:GetBoneMatrix(head)
			pos, ang = LocalToWorld(Vector(5, -5, 0), Angle(0, -90, -90), matrix:GetTranslation(), matrix:GetAngles())
			if not ent:IsRagdoll() then
				ang = ent:EyeAngles()
			end
			local trace = util.TraceLine({
				start = self:EyePos(),
				endpos = pos,
				filter = self:GetTraceFilter(),
				mins = Vector(-3, -3, -3),
				maxs = Vector(3, 3, 3),
				collisiongroup = COLLISION_GROUP_PLAYER_MOVEMENT
			})
			pos = trace.HitPos
		end
		return pos, ang
	end,
	GetTraceFilter = function(self)
		local filter
		do
			local _tab_0 = {
				self,
				self:GetBodyEntity(),
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
			filter = _tab_0
		end
		local _list_0 = {
			SLOT_POCKET1,
			SLOT_POCKET2,
			SLOT_POCKET3,
			SLOT_POCKET4
		}
		for _index_0 = 1, #_list_0 do
			local pocket = _list_0[_index_0]
			filter[#filter + 1] = self:GetInventory():GetSlot(pocket)
		end
		return filter
	end,
	GetInteractTrace = function(self, range)
		if range == nil then
			range = 82
		end
		if CLIENT then
			local frame = FrameNumber()
			if self.LastInteractTrace == frame then
				return self.InteractTrace
			end
			self.LastInteractTrace = frame
		end
		local vo, va = self:GetViewOrigin()
		self.InteractTrace = util.TraceHull({
			start = vo,
			endpos = vo + va:Forward() * range,
			mins = Vector(-5, -5, -5),
			maxs = Vector(5, 5, 5),
			filter = self:GetTraceFilter()
		})
		return self.InteractTrace
	end,
	GetHandPosition = function(self)
		local index = self:LookupAttachment('anim_attachment_RH')
		local att = self:GetAttachment(index)
		if att then
			return att.Pos, att.Ang
		end
	end,
	GetRF = function(self, maxd, muffled, inclself)
		local rf = { }
		local body_ours = self:GetBodyEntity()
		local head_ours = body_ours:GetHeadPos()
		local _list_0 = player.GetAll()
		for _index_0 = 1, #_list_0 do
			local ply = _list_0[_index_0]
			local body_theirs = ply:GetBodyEntity()
			local head_theirs = body_theirs:GetHeadPos()
			if (body_theirs ~= body_ours) or inclself then
				local dist = maxd
				if maxd ~= muffled and not body_theirs:CanHear(body_ours) then
					dist = muffled
				end
				if head_theirs:Distance(head_ours) < dist then
					rf[#rf + 1] = ply
				end
			end
		end
		return rf
	end,
	CanSee = function(self, ent)
		return hook.Run('CanSeePos', self:EyePos(), ent:EyePos(), {
			self,
			ent
		})
	end,
	LookingAt = function(self, ent)
		if self:CanSee(ent) then
			local tpos
			if ent:IsPlayer() then
				tpos = ent:EyePos()
			else
				tpos = ent:GetPos()
			end
			return self:LookingInDirection(tpos)
		end
	end,
	LookingInDirection = function(self, pos, pct)
		if pct == nil then
			pct = 0.95
		end
		local diff = pos - self:GetShootPos()
		local match = self.GetAimVector:Dot(diff) / diff:Length()
		return match >= pct
	end,
	CanHear = function(self, ent)
		local tr = util.TraceLine({
			start = self:GetHeadPos(),
			endpos = ent:GetHeadPos(),
			filter = self,
			mask = MASK_SOLID
		})
		local e = tr.Entity
		if IsValid(e) and ((e:EntIndex() == ent:EntIndex()) or (e.GetRagdoll or e:GetClass() == "prop_ragdoll" and e == ent:GetRagdoll())) then
			return true
		else
			return false
		end
	end,
	GetTargets = function(self, dir, range, addfilter, fatness, exclude, compensate)
		if dir == nil then
			dir = self:GetAimVector()
		end
		if range == nil then
			range = self:BoundingRadius()
		end
		if fatness == nil then
			fatness = .75
		end
		local traces = { }
		local filter = self:GetTraceFilter(exclude)
		if addfilter then
			for _index_0 = 1, #addfilter do
				local x = addfilter[_index_0]
				filter[#filter + 1] = x
			end
		end
		local uncompstart = self:WorldSpaceCenter()
		if compensate then
			self:LagCompensation(true)
		end
		local start = self:WorldSpaceCenter()
		local trace = {
			start = start,
			endpos = start + dir * range,
			mins = self:OBBMins() * fatness,
			maxs = self:OBBMaxs() * fatness,
			filter = filter,
			mask = MASK_SHOT
		}
		for i = 1, 20 do
			local tr = util.TraceHull(trace)
			local ent = tr.Entity
			if IsValid(ent) then
				traces[#traces + 1] = tr
				local _obj_0 = trace.filter
				_obj_0[#_obj_0 + 1] = ent
			end
		end
		for i = 1, 20 do
			local tr = util.TraceLine(trace)
			local ent = tr.Entity
			if IsValid(ent) then
				traces[#traces + 1] = tr
				local _obj_0 = trace.filter
				_obj_0[#_obj_0 + 1] = ent
			end
		end
		if compensate then
			self:LagCompensation(false)
		end
		return traces
	end
}) do
	meta[k] = v
end
local Player
do
	local _class_0
	local drawing_bonemerge
	local _parent_0 = MODULE
	local _base_0 = {
		CanSeePos = function(self, pos1, pos2, filter)
			local tr = util.TraceLine({
				start = pos1,
				endpos = pos2,
				filter = filter,
				mask = MASK_SOLID + CONTENTS_WINDOW + CONTENTS_GRATE
			})
			if tr.Fraction == 1.0 then
				return true
			end
			return false
		end,
		PlayerInitialSpawn = function(self, ply)
			player_manager.SetPlayerClass(ply, "fucklet")
			return
		end,
		PlayerSpray = function(self)
			return true
		end,
		PrePlayerDraw = function(self, ply)
			if ply:GetWatching() then
				return true
			end
			local rag = ply:GetRagdoll()
			if rag and rag:IsValid() then
				return true
			end
			return
		end,
		PostPlayerDraw = function(self, ply)
			if not drawing_bonemerge then
				drawing_bonemerge = true
				local _list_0 = ply:GetChildren()
				for _index_0 = 1, #_list_0 do
					local v = _list_0[_index_0]
					if v:GetClass() == "bonemerge" then
						v:DrawModel()
					end
				end
				drawing_bonemerge = false
				return render.SetBlend(1)
			end
		end,
		PlayerCanHearPlayersVoice = function(self, ply, other)
			return false
		end,
		PlayerStartVoice = function(self, ply)
			return true
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
		__name = "Player",
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
	drawing_bonemerge = false
	if _parent_0.__inherited then
		_parent_0.__inherited(_parent_0, _class_0)
	end
	Player = _class_0
end
BIND("cough", KEY_K, {
	Press = function(self, ply)
		if SERVER then
			return ply:Do(ACT.COUGH)
		end
	end
})
local Cough
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = (function()
			local _accum_0 = { }
			local _len_0 = 1
			for i = 1, 4 do
				_accum_0[_len_0] = "ambient/voices/cough" .. tostring(i) .. ".wav"
				_len_0 = _len_0 + 1
			end
			return _accum_0
		end)()
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
		__name = "Cough",
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
	Cough = _class_0
end
local COUGH
do
	local _class_0
	local _parent_0 = ACT
	local _base_0 = {
		Immobilizes = false,
		Do = function(self, fromstate)
			local _with_0 = self.ply
			if not _with_0:StanceIs(STANCE_RISEN) then
				return
			end
			local sequence = 'a_g_headinhds'
			local snd, cycle1 = "ambient/voices/cough" .. math.random(1, 4) .. ".wav", .43
			if (CLIENT and IsFirstTimePredicted()) or SERVER then
				self:Spasm({
					sequence = sequence
				})
			end
			self:CYCLE(cycle1, function(self)
				if IsFirstTimePredicted() and SERVER then
					local bone = 'ValveBiped.Bip01_Head1'
					return _with_0:EmitSound('Cough')
				end
			end)
			return _with_0
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
		__name = "COUGH",
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
	COUGH = _class_0
end
GM.DoPlayerDeath = function(self) end
GM.PlayerDeathSound = function(self)
	return true
end
