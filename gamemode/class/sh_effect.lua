local Create = ents.Create
local Register = effects.Register
local lower, Left = string.lower, string.Left
local TraceLine = util.TraceLine
local _class_0
local _base_0 = { }
if _base_0.__index == nil then
	_base_0.__index = _base_0
end
_class_0 = setmetatable({
	__init = function() end,
	__base = _base_0,
	__name = "FX"
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
self.registered = { }
self.__inherited = function(self, child)
	local fields
	do
		local _tbl_0 = { }
		for k, v in pairs(child.__base) do
			if Left(k, 2) ~= "__" then
				_tbl_0[k] = v
			end
		end
		fields = _tbl_0
	end
	child.__barcode = tostring(self.__barcode and self.__barcode .. '/' or '') .. tostring(lower(rawget(child, '__entity') or child.__name))
	if CLIENT then
		Register(fields, child.__barcode)
	end
	MsgC(Color(0, 200, 0), "+EFFECT: " .. tostring(child.__barcode) .. "\n")
	self.registered[child.__barcode] = child
end
FX = _class_0
