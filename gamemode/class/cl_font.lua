local CreateFont = surface.CreateFont
local lower, sub = string.lower, string.sub
local _class_0
local _base_0 = {
	font = 'Arial',
	extended = false,
	size = 13,
	weight = 500,
	blursize = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false
}
if _base_0.__index == nil then
	_base_0.__index = _base_0
end
_class_0 = setmetatable({
	__init = function() end,
	__base = _base_0,
	__name = "FONT"
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
	local fields = { }
	local ancestor = child
	while ancestor do
		local inheritance
		do
			local _tbl_0 = { }
			for k, v in pairs(ancestor.__base) do
				if not fields[k] and k ~= 'new' and sub(k, 1, 2) ~= '__' then
					_tbl_0[k] = v
				end
			end
			inheritance = _tbl_0
		end
		for k, v in pairs(inheritance) do
			fields[k] = v
		end
		if not ancestor.__parent then
			break
		end
		ancestor = ancestor.__parent
	end
	child.__barcode = tostring(self.__barcode and self.__barcode .. '/' or '') .. tostring(lower(child.__name))
	CreateFont(child.__barcode, fields)
	return MsgC(Color(0, 200, 0), "+FONT: " .. tostring(child.__barcode) .. "\n")
end
FONT = _class_0
