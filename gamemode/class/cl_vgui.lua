local Create, Register, GetControlTable = vgui.Create, vgui.Register, vgui.GetControlTable
local lower, Left = string.lower, string.Left
local _class_0
local _base_0 = {
	width = 320,
	height = 200
}
if _base_0.__index == nil then
	_base_0.__index = _base_0
end
_class_0 = setmetatable({
	__init = function(self, x, y, w, h)
		if x == nil then
			x = 0
		end
		if y == nil then
			y = 0
		end
		if w == nil then
			w = self.width
		end
		if h == nil then
			h = self.height
		end
		self:SetPos(x, y)
		local _obj_0 = VGUI.elements
		_obj_0[#_obj_0 + 1] = self
	end,
	__base = _base_0,
	__name = "VGUI"
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
self.elements = { }
self.Scale = function(value)
	return math.max(value * (ScrH() / 1080), 1)
end
self.__inherited = function(self, child)
	do
		local _with_0 = getmetatable(child)
		_with_0.__call = function(self, parent, ...)
			local panel = Create(self.__barcode, parent)
			panel.__class = self
			for k, v in pairs(self.__base) do
				if Left(k, 2) ~= "__" then
					panel[k] = v
				end
			end
			self.__init(panel, ...)
			return panel
		end
	end
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
	fields.__name = child.__name
	local base = fields.Base or self.__barcode
	fields.Base = nil
	child.__barcode = tostring(self.__barcode and self.__barcode .. '/' or '') .. tostring(lower(child.__name))
	Register(child.__barcode, fields, base)
	self.registered[child.__name] = child
	return MsgC(Color(0, 200, 0), "+VGUI: " .. tostring(child.__name) .. "\n")
end
VGUI = _class_0
