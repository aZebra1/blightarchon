MODULES = { }
_ud83d_udcbe = MODULES
do
	local _class_0
	local _base_0 = { }
	if _base_0.__index == nil then
		_base_0.__index = _base_0
	end
	_class_0 = setmetatable({
		__init = function() end,
		__base = _base_0,
		__name = "MODULE"
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
	self.hook_cache = { }
	self.__inherited = function(self, child)
		for k, v in pairs(child.__base) do
			if isfunction(v) then
				local _obj_0 = self.hook_cache
				_obj_0[k] = _obj_0[k] or { }
				self.hook_cache[k][child.__name] = v
			end
		end
		MsgC(Color(0, 255, 0), "Module " .. tostring(child.__name) .. " loaded.\n")
		_ud83d_udcbe[child.__name] = child
	end
	MODULE = _class_0
end
local _obj_0 = hook
_obj_0.oldCall = _obj_0.oldCall or hook.Call
hook.Call = function(name, gm, ...)
	local cache = MODULE.hook_cache[name]
	if cache then
		for i, v in pairs(cache) do
			local a, b, c, d, e, f = v(_ud83d_udcbe[i], ...)
			if not (a == nil) then
				return a, b, c, d, e, f
			end
		end
	end
	return hook.oldCall(name, gm, ...)
end
