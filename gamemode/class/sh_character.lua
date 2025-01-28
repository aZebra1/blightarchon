CHARACTERS = CHARACTERS or { }
do
	local _class_0
	local _base_0 = {
		name = "",
		adjs = { }
	}
	if _base_0.__index == nil then
		_base_0.__index = _base_0
	end
	_class_0 = setmetatable({
		__init = function(self, name)
			self.name = name
			CHARACTERS[self.__class.next_id] = self
			self.__class.next_id = self.__class.next_id + 1
		end,
		__base = _base_0,
		__name = "CHAR"
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
	self.next_id = 0
	CHAR = _class_0
end
