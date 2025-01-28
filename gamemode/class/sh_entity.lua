local Create = ents.Create
local Register = scripted_ents.Register
local lower, Left = string.lower, string.Left
local TraceLine = util.TraceLine
local _class_0
local _base_0 = { }
if _base_0.__index == nil then
	_base_0.__index = _base_0
end
_class_0 = setmetatable({
	__init = function(self, where)
		if isvector(where) then
			self:SetPos(where)
		elseif isentity(where) and where:IsPlayer() then
			self:SetPos(where:GetEyeTrace().HitPos)
		end
		self:Spawn()
		return self:Activate()
	end,
	__base = _base_0,
	__name = "ENTITY"
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
	do
		local _with_0 = getmetatable(child)
		_with_0.__call = function(self, ...)
			local ent = Create(self.__barcode)
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
	child.__barcode = tostring(self.__barcode and self.__barcode .. '/' or '') .. tostring(lower(rawget(child, '__entity') or child.__name))
	Register(fields, child.__barcode)
	MsgC(Color(0, 200, 0), "+ENTITY: " .. tostring(child.__barcode) .. "\n")
	self.registered[child.__barcode] = child
end
self.create = function(self, name, ...)
	if not self.registered[name] then
		return
	end
	return self.registered[name](...)
end
ENTITY = _class_0
