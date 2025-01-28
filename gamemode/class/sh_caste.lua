CASTES = { }
do
	local _class_0
	local _base_0 = {
		name = "",
		desc = "A collective group of people with a common culture, tradition, and history.",
		color = Color(150, 150, 0),
		fates = { }
	}
	if _base_0.__index == nil then
		_base_0.__index = _base_0
	end
	_class_0 = setmetatable({
		__init = function() end,
		__base = _base_0,
		__name = "CASTE"
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
			local _obj_0 = CASTES
			_obj_0[#_obj_0 + 1] = child
		end
		child.index = #CASTES
	end
	CASTE = _class_0
end
local meta = FindMetaTable('Player')
for k, v in pairs({
	Caste = function(self)
		return self:GetCaste()
	end,
	CasteTable = function(self)
		return CASTES[self:Caste()]
	end
}) do
	meta[k] = v
end
