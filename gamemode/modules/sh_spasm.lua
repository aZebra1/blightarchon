local ReadEntity, WriteEntity, ReadString, WriteString, ReadUInt, WriteUInt, ReadFloat, WriteFloat = net.ReadEntity, net.WriteEntity, net.ReadString, net.WriteString, net.ReadUInt, net.WriteUInt, net.ReadFloat, net.WriteFloat
local NETMSG_SPASM
do
	local _class_0
	local _parent_0 = NETMSG
	local _base_0 = { }
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
		__name = "NETMSG_SPASM",
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
	self.Write = function(self, ply, sequence, slot, speed, start)
		if slot == nil then
			slot = GESTURE_SLOT_CUSTOM
		end
		if speed == nil then
			speed = 1
		end
		if start == nil then
			start = 0
		end
		WriteEntity(ply)
		WriteUInt(sequence, 16)
		WriteUInt(slot, 3)
		WriteUInt(speed, 3)
		return WriteFloat(start)
	end
	self.Read = function(self)
		return ReadEntity(), ReadUInt(16), ReadUInt(3), ReadUInt(3), ReadFloat()
	end
	self.Callback = function(self, ply, who, sequence, slot, speed, start)
		if not IsValid(who) then
			return
		end
		if who:IsDormant() then
			return
		end
		return who:Spasm({
			sequence = sequence,
			slot = slot,
			speed = speed,
			start = start
		})
	end
	if _parent_0.__inherited then
		_parent_0.__inherited(_parent_0, _class_0)
	end
	NETMSG_SPASM = _class_0
end
SEQUENCE_LOOKUP = { }
hook.Add('PostLoadAnimations', 'eclipse', function()
	SEQUENCE_LOOKUP = { }
end)
local meta = FindMetaTable('Player')
for k, v in pairs({
	FindSequence = function(self, act)
		if SEQUENCE_LOOKUP[act] then
			return SEQUENCE_LOOKUP[act]
		end
		local seq = self:LookupSequence(act)
		if seq > -1 then
			SEQUENCE_LOOKUP[act] = seq
		end
		return seq
	end,
	Spasm = function(self, choreo)
		local SS = choreo.SS
		local slot = choreo.slot or GESTURE_SLOT_CUSTOM
		local sequence = choreo.sequence
		local start = choreo.start or 0
		local speed = choreo.speed or 1
		do
			local _exp_0 = type(sequence)
			if 'table' == _exp_0 then
				sequence = table.Random(sequence)
			elseif 'string' == _exp_0 then
				sequence = self:FindSequence(sequence)
			end
		end
		if SERVER then
			if SS then
				NETMSG_SPASM:Broadcast(self, sequence, slot, speed, start)
			else
				NETMSG_SPASM:SendOmit(self, self, sequence, slot, speed, start)
			end
		end
		if isstring(sequence) then
			sequence = self:FindSequence(sequence)
		end
		self:AddVCDSequenceToGestureSlot(slot, sequence, start, not loop)
		if isnumber(speed) then
			self:SetLayerPlaybackRate(slot, speed)
		end
		return sequence, slot
	end
}) do
	meta[k] = v
end
