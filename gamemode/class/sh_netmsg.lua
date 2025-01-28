local SendToServer, SendOmit, SendPAS, SendPVS, Broadcast, Send, Start, Receive = net.SendToServer, net.SendOmit, net.SendPAS, net.SendPVS, net.Broadcast, net.Send, net.Start, net.Receive
local AddNetworkString = util.AddNetworkString
local _class_0
local _base_0 = { }
if _base_0.__index == nil then
	_base_0.__index = _base_0
end
_class_0 = setmetatable({
	__init = function() end,
	__base = _base_0,
	__name = "NETMSG"
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
self.__inherited = function(self, child)
	assert(type(child.__name) == "string")
	if SERVER then
		AddNetworkString(child.__name)
	end
	return Receive(child.__name, (function()
		local _base_1 = child
		local _fn_0 = _base_1.Receive
		return _fn_0 and function(...)
			return _fn_0(_base_1, ...)
		end
	end)())
end
self.Unreliable = false
self.Read = function(self, len) end
self.Write = function(self, ...) end
self.Receive = function(self, len, ply)
	return self:Callback(ply, self:Read(len))
end
self.Callback = function(self, ...) end
self.BuildMessage = function(self, ...)
	Start(self.__name, self.Unreliable)
	return self:Write(...)
end
self.SendToServer = function(self, ...)
	assert(CLIENT)
	self:BuildMessage(...)
	return SendToServer()
end
self.Send = function(self, ply, ...)
	assert(SERVER)
	self:BuildMessage(...)
	return Send(ply)
end
self.SendOmit = function(self, ply, ...)
	assert(SERVER)
	self:BuildMessage(...)
	return SendOmit(ply)
end
self.SendPAS = function(self, pos, ...)
	assert(SERVER)
	self:BuildMessage(...)
	return SendPAS(pos)
end
self.SendPVS = function(self, pos, ...)
	assert(SERVER)
	self:BuildMessage(...)
	return SendPVS(pos)
end
self.Broadcast = function(self, ...)
	assert(SERVER)
	self:BuildMessage(...)
	return Broadcast()
end
NETMSG = _class_0
