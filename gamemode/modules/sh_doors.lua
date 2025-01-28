DOOR_STATE_CLOSED = 0
DOOR_STATE_OPENING = 1
DOOR_STATE_OPEN = 2
DOOR_STATE_CLOSING = 3
local DoorKicked
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = (function()
			local _accum_0 = { }
			local _len_0 = 1
			local _list_0 = {
				1,
				4,
				5
			}
			for _index_0 = 1, #_list_0 do
				local i = _list_0[_index_0]
				_accum_0[_len_0] = "physics/wood/wood_crate_impact_hard" .. tostring(i) .. ".wav"
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
		__name = "DoorKicked",
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
	DoorKicked = _class_0
end
local DoorBustedIn
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = (function()
			local _accum_0 = { }
			local _len_0 = 1
			local _list_0 = {
				1,
				3,
				4,
				5
			}
			for _index_0 = 1, #_list_0 do
				local i = _list_0[_index_0]
				_accum_0[_len_0] = "physics/wood/wood_crate_break" .. tostring(i) .. ".wav"
				_len_0 = _len_0 + 1
			end
			return _accum_0
		end)(),
		level = 90
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
		__name = "DoorBustedIn",
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
	DoorBustedIn = _class_0
end
local emeta = FindMetaTable('Entity')
for k, v in pairs({
	DoorLocked = function(self)
		if self:IsDoor() then
			return self:GetInternalVariable("m_bLocked")
		end
	end,
	DoorOpen = function(self)
		if self:IsDoor() then
			local _exp_0 = self:GetClass()
			if "func_door" == _exp_0 or "func_door_rotating" == _exp_0 then
				return self:GetInternalVariable("m_toggle_state") == 0
			elseif "prop_door_rotating" == _exp_0 then
				return self:GetInternalVariable("m_eDoorState") ~= 0
			else
				return false
			end
		end
	end,
	DoorOpenUp = function(self, who)
		if self:DoorOpen() then
			if self:GetClass() == "prop_dynamic" then
				self:Fire("SetAnimation", "close")
			else
				self:Fire("close")
			end
			return true
		end
		do
			local _exp_0 = self:GetClass()
			if "prop_door_rotating" == _exp_0 then
				local target = ents.Create("info_target")
				target:SetName(tostring(target))
				target:SetPos(who:EyePos())
				target:Spawn()
				self:Fire("OpenAwayFrom", tostring(target), 0)
				timer.Simple(1, function()
					if IsValid(target) then
						return target:Remove()
					end
				end)
			elseif "prop_dynamic" == _exp_0 then
				self:Fire("SetAnimation", "open")
			else
				self:Fire("Open")
			end
		end
		return true
	end,
	DoorKicked = function(self, burglar, hitpos)
		if self:IsDoor() and self:GetClass() == "prop_door_rotating" then
			self:EmitSound("DoorKicked")
		end
		if math.random(1, 7) == 2 then
			self:DoorBustedIn(burglar, hitpos)
			return true, true
		else
			local rc, rm = unpack(_ud83d_udcbe.Chatter.audible_ranges.yelling)
			local rf = burglar:GetRF(rc, rm, true)
			net.Start("nDoorKicked")
			net.WriteVector(hitpos)
			net.Send(rf)
			return true, false
		end
	end,
	DoorBustedIn = function(self, burglar, hitpos)
		if self:IsDoor() and not self:DoorOpen() and self:GetClass() == "prop_door_rotating" then
			self:EmitSound("DoorBustedIn")
			self:Fire("SetSpeed", 500, 0)
			timer.Simple(1, function()
				if IsValid(self) then
					return self:Fire("SetSpeed", 100, 0)
				end
			end)
			self:Fire("Unlock")
			self:DoorOpenUp(burglar)
			local rc, rm = unpack(_ud83d_udcbe.Chatter.audible_ranges.yelling)
			local rf = burglar:GetRF(rc, rm, true)
			net.Start("nDoorBustedIn")
			net.WriteVector(hitpos)
			return net.Send(rf)
		end
	end,
	InteractDoorHandle = function(self, who)
		if not self:IsDoor() then
			return
		end
		self:DoorOpenUp(who)
		return nil, nil
	end
}) do
	emeta[k] = v
end
if SERVER then
	util.AddNetworkString("nDoorKicked")
	return util.AddNetworkString("nDoorBustedIn")
else
	net.Receive("nDoorKicked", function(len)
		local pos = net.ReadVector()
		pos = pos + Vector(0, 0, 10)
		local texts = {
			"THUD",
			"WHAM"
		}
		return BUBBLE({
			text = "*" .. tostring(texts[math.random(1, #texts)]) .. "*",
			font = "spleen_chat",
			text_color = COLOR_RED,
			color = COLOR_BLACK,
			pos = pos,
			clingy = true,
			lifespan = 1
		})
	end)
	return net.Receive("nDoorBustedIn", function(len)
		local pos = net.ReadVector()
		pos = pos + Vector(0, 0, 10)
		local texts = {
			"CRASH"
		}
		return BUBBLE({
			text = "*" .. tostring(texts[math.random(1, #texts)]) .. "*",
			font = "spleen_chat",
			text_color = COLOR_RED,
			pos = pos,
			clingy = true,
			lifespan = 2
		})
	end)
end
