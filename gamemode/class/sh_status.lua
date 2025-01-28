local _class_0
local _base_0 = {
	name = "undefined",
	uniqueID = "undefined",
	icon = "undefined",
	default = 0,
	minimum = 0,
	minimum_display = 1,
	maximum = 4,
	colors = {
		[4] = Color(200, 0, 0),
		[3] = Color(150, 46, 7),
		[2] = Color(129, 67, 11),
		[1] = Color(107, 88, 14),
		[0] = Color(85, 109, 18),
		[-1] = Color(64, 130, 22),
		[-2] = Color(42, 152, 25),
		[-3] = Color(21, 173, 29),
		[-4] = Color(0, 194, 33)
	},
	Overflow = function(self, ply, char) end
}
if _base_0.__index == nil then
	_base_0.__index = _base_0
end
_class_0 = setmetatable({
	__init = function() end,
	__base = _base_0,
	__name = "STATUS"
}, {
	__index = _base_0,
	__call = function(cls, ...)
		local _self_0 = setmetatable({ }, _base_0)
		cls.__init(_self_0, ...)
		return _self_0
	end
})
_base_0.__class = _class_0
local self = _class_0;
self.effects = { }
self.indices = { }
self.active = { }
self.__inherited = function(self, child)
	child.index = table.Count(self.effects) + 1
	child.uniqueID = string.lower(child.__name)
	self.effects[child.uniqueID] = child
	self.indices[child.index] = child
	local alias_name = tostring(child.uniqueID:sub(1, 1):upper()) .. tostring(child.uniqueID:sub(2))
	local meta = FindMetaTable('Player')
	meta["Status" .. tostring(alias_name)] = function(self)
		if self["Status" .. tostring(alias_name) .. "Val"] == nil then
			return 0
		end
		if self["Status" .. tostring(alias_name) .. "Val"] == false then
			return false
		end
		return self["Status" .. tostring(alias_name) .. "Val"]
	end
	meta["SetStatus" .. tostring(alias_name)] = function(self, val, force)
		if val == nil then
			return
		end
		if SERVER then
			if self["Status" .. tostring(alias_name) .. "Val"] == val and not force then
				return
			end
			self["Status" .. tostring(alias_name) .. "Val"] = val
			if child.private then
				local _with_0 = net
				_with_0.Start("nSetStatus" .. tostring(alias_name))
				_with_0.WriteInt(val, 4)
				_with_0.Send(self)
				return _with_0
			else
				local _with_0 = net
				_with_0.Start("nSetStatus" .. tostring(alias_name))
				_with_0.WriteEntity(self)
				_with_0.WriteInt(val, 4)
				_with_0.Broadcast()
				return _with_0
			end
		else
			self["Status" .. tostring(alias_name)] = val
		end
	end
	if SERVER then
		return util.AddNetworkString("nSetStatus" .. tostring(alias_name))
	else
		return net.Receive("nSetStatus" .. tostring(alias_name), function(len)
			if child.private then
				local val = net.ReadInt(4)
				LocalPlayer()["Status" .. tostring(alias_name) .. "Val"] = val
			else
				local ply = net.ReadEntity()
				local val = net.ReadInt(4)
				ply["Status" .. tostring(alias_name) .. "Val"] = val
			end
		end)
	end
end
self.FindByName = function(self, status)
	status = status:lower()
	local uniqueID
	for k, v in pairs(self.effects) do
		if status:find(v.name:lower()) then
			uniqueID = k
			break
		end
	end
	return uniqueID
end
self.Get = function(self, uniqueID)
	return self.effects[uniqueID] or nil
end
self.NameToUniqueID = function(self, name)
	return string.gsub(name, " ", "_"):lower()
end
STATUS = _class_0
