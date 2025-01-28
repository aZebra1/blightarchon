local Register = weapons.Register
local lower, Left = string.lower, string.Left
local TraceLine = util.TraceLine
local _class_0
local _base_0 = { }
if _base_0.__index == nil then
	_base_0.__index = _base_0
end
_class_0 = setmetatable({
	__init = function(self)
		return self:SetHoldType('normal')
	end,
	__base = _base_0,
	__name = "WEAPON"
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
	do
		local _with_0 = getmetatable(child)
		_with_0.__call = function(self, where, ...)
			local ent
			if isvector(where) then
				ent = Create(self.__barcode)
				ent:SetPos(where)
				ent:Spawn()
			elseif isentity(where) and where:IsPlayer() then
				ent = where:Give(self.__barcode)
			end
			ent.__class = ent.BaseClass
			self.__init(ent, ...)
			return ent
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
	fields.Base = fields.Base or self.__barcode
	fields.Spawnable = fields.Spawnable or self.Spawnable
	fields.Category = fields.Category or self.Category
	child.__barcode = tostring(self.__barcode and self.__barcode .. '/' or '') .. tostring(lower(rawget(child, '__weapon') or child.__name))
	Register(fields, child.__barcode)
	return MsgC(Color(0, 200, 0), "+WEAPON: " .. tostring(child.__barcode) .. "\n")
end
WEAPON = _class_0
