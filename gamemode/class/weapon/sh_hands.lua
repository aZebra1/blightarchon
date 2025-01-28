local Hands
do
	local _class_0
	local _parent_0 = WEAPON
	local _base_0 = {
		Primary = {
			ClipSize = -1,
			DefaultClip = -1,
			Automatic = false,
			Ammo = "",
			Damage = 0,
			Delay = 0
		},
		WorldModel = '',
		SetupDataTables = function(self)
			self:NetworkVar('Float', 0, 'NextInteraction')
			self:NetworkVar('Float', 1, 'LastThrow')
			self:NetworkVar('Bool', 0, 'Throw')
			return self:NetworkVar('Bool', 1, 'Raised')
		end,
		Think = function(self)
			local ply = self:GetOwner()
			ply:GetStateTable():Think(ply)
			if ply.Doing then
				ply.Doing:Think()
			end
			local thing = ply:Wielding()
			if CLIENT and IsValid(thing) then
				if true then
					return
				end
				self.RenderGroup = thing:GetRenderGroup()
				self.WorldModel = thing:GetModel()
			end
		end,
		PrimaryAttack = function(self)
			local ply = self:GetOwner()
			local thing = ply:Wielding()
			local tr = ply:GetInteractTrace()
			local ent = tr.Entity
			local controls = {
				{
					ctrl = "release_right",
					what = thing
				},
				{
					ctrl = "release_left",
					what = ply:WieldingOffhand()
				}
			}
			for _index_0 = 1, #controls do
				local c = controls[_index_0]
				if IsValid(c.what) and BIND.controls[c.ctrl]:IsDown(ply) then
					if ply:StateIs(STATE.PRIMED) then
						return ply:Do(ACT.THROW, c.what)
					else
						return ply:Do(ACT.PLACE, c.what)
					end
				end
			end
			if IsValid(thing) then
				if ply:StateIs(STATE.PRIMED) then
					if thing.AttackAct and thing.AttackEnabled then
						if thing.AttackDelay then
							self:SetNextPrimaryFire(CurTime() + thing.AttackDelay)
						end
						return ply:Do(thing.AttackAct, thing)
					end
				end
				if thing:OnPrimaryInteract(tr, ply, self) then
					return
				end
				if IsValid(ent) and ent.OnActUpon then
					return ent:OnActUpon(ply, self, thing)
				end
			else
				if ply:StateIs(STATE.PRIMED) then
					ply:Do(ACT.PUNCH)
					return
				end
				if not IsValid(ent) then
					return
				end
				if ent.ActUpon then
					return ent:ActUpon(ply, self)
				end
				if ent:IsPlayer() then
					return
				end
				return ply:Do(ACT.PICK_UP, ent)
			end
		end,
		SecondaryAttack = function(self) end,
		HeldItemChanged = function(self, old, new)
			if CLIENT and IsValid(old) then
				old:SetPredictable(false)
			end
			if CLIENT and IsValid(new) then
				return new:SetPredictable(true)
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
		__name = "Hands",
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
	Hands = _class_0
end
local meta = FindMetaTable('Player')
meta.GetHands = function(self)
	return self:GetWeapon('hands')
end
