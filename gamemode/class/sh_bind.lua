local _class_0
local _base_0 = {
	IsDown = function(self, ply)
		if SERVER then
			return self.state[ply]
		else
			return self.state
		end
	end
}
if _base_0.__index == nil then
	_base_0.__index = _base_0
end
_class_0 = setmetatable({
	__init = function(self, control, key, extra)
		self.control = control
		self.key = key
		self.press = extra.Press or function(self) end
		self.release = extra.Release or function(self) end
		self.think = extra.Think or function(self) end
		if CLIENT then
			self.state = false
		else
			self.state = { }
		end
		hook.Add('PlayerButtonDown', "eclipse:bind:" .. tostring(self.control), function(ply, key)
			if not IsFirstTimePredicted() then
				return
			end
			if not (key == self.key) then
				return
			end
			if not (self.control == "toggle_chat") then
				if ply.GetChatting and ply:GetChatting() then
					return
				end
			end
			if SERVER then
				if self.state[ply] then
					return
				end
				self.state[ply] = true
			else
				if self.state then
					return
				end
				self.state = true
			end
			self:press(ply)
			return
		end)
		hook.Add('PlayerButtonUp', "eclipse:bind:" .. tostring(self.control), function(ply, key)
			if not IsFirstTimePredicted() then
				return
			end
			if not (key == self.key) then
				return
			end
			if not (self.control == "toggle_chat") then
				if ply.GetChatting and ply:GetChatting() then
					return
				end
			end
			if SERVER then
				if not self.state[ply] then
					return
				end
				self.state[ply] = false
			else
				if not self.state then
					return
				end
				self.state = false
			end
			self:release(ply)
			return
		end)
		hook.Add('PostPlayerThink', "eclipse:bind:" .. tostring(self.control), function(ply)
			if SERVER then
				if self.state[ply] then
					self:think(ply)
				end
			else
				if self.state then
					self:think(ply)
				end
			end
			return
		end)
		self.__class.controls[self.control] = self
	end,
	__base = _base_0,
	__name = "BIND"
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
self.controls = { }
BIND = _class_0
