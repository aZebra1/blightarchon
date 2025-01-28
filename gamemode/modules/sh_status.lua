local meta = FindMetaTable('Player')
for k, v in pairs({
	Status = function(self, enum)
		local status = STATUS.indices[enum]
		local uniqueID = status.uniqueID
		local alias_name = tostring(uniqueID:sub(1, 1):upper()) .. tostring(uniqueID:sub(2))
		return self["Status" .. tostring(alias_name)](self)
	end,
	AddStatus = function(self, enum, amount)
		local status = STATUS.indices[enum]
		local uniqueID = status.uniqueID
		local Clamp = math.Clamp
		local alias_name = tostring(uniqueID:sub(1, 1):upper()) .. tostring(uniqueID:sub(2))
		local old_val = self:Status(enum)
		local new_val = Clamp(old_val + amount, 0, status.maximum)
		self["SetStatus" .. tostring(alias_name)](self, new_val)
		if old_val == status.maximum and new_val == status.maximum then
			status:Overflow(self)
		end
		return self["Status" .. tostring(alias_name)](self)
	end,
	SetStatus = function(self, enum, amount)
		local status = STATUS.indices[enum]
		local uniqueID = status.uniqueID
		local Clamp = math.Clamp
		local alias_name = tostring(uniqueID:sub(1, 1):upper()) .. tostring(uniqueID:sub(2))
		local old_val = self:Status(enum)
		local new_val = Clamp(amount, 0, status.maximum)
		self["SetStatus" .. tostring(alias_name)](self, new_val)
		if old_val == status.maximum and new_val == status.maximum then
			status:Overflow(self)
		end
		return self["Status" .. tostring(alias_name)](self)
	end
}) do
	meta[k] = v
end
local Status
local _class_0
local _parent_0 = MODULE
local _base_0 = {
	Think = function(self)
		local _list_0 = player.GetAll()
		for _index_0 = 1, #_list_0 do
			local ply = _list_0[_index_0]
			for _, status in pairs(STATUS.effects) do
				status:Think(ply)
			end
		end
	end,
	PlayerSpawn = function(self, ply)
		for k, v in pairs(STATUS.effects) do
			local fname = "Status" .. tostring(v.uniqueID:sub(1, 1):upper()) .. tostring(v.uniqueID:sub(2))
			ply["Set" .. tostring(fname)](ply, v.default)
		end
	end,
	HUDPaint = function(self)
		local sin, max, min = math.sin, math.max, math.min
		local lply = LocalPlayer()
		local x = ScrW() - 80
		local y = ScrH() * 0.5
		for k, v in pairs(STATUS.effects) do
			local _continue_0 = false
			repeat
				local fname = "Status" .. tostring(v.uniqueID:sub(1, 1):upper()) .. tostring(v.uniqueID:sub(2))
				local val = lply[fname](lply)
				if val < v.minimum_display then
					_continue_0 = true
					break
				end
				surface.SetMaterial(v.icon)
				local color = v.colors[val]
				color = Color(color.r, color.g, color.b, 255)
				local _list_0 = {
					'r',
					'g',
					'b'
				}
				for _index_0 = 1, #_list_0 do
					local c = _list_0[_index_0]
					color[c] = color[c] + (sin(CurTime()) * 20)
					color[c] = min(color[c], 255)
					color[c] = max(color[c], 0)
				end
				surface.SetDrawColor(color)
				local x2 = x + (math.random(-val, val))
				local y2 = y + (math.random(-val, val))
				surface.DrawTexturedRect(x2, y2, 64, 64)
				y = y + 64
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
	__name = "Status",
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
Status = _class_0
return _class_0
