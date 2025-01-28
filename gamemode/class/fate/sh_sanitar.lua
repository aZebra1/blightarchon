local SANITAR
do
	local _class_0
	local _parent_0 = FATE
	local _base_0 = {
		caste = CASTE_SANITAR,
		submaterials = {
			scalp = SUBMAT_HATSCOMBINED_GREY,
			torso = "models/IN/clothes/male_soldier1",
			legs = "models/IN/clothes/male_soldier1"
		},
		OnSpawn = function(self, ply)
			return ply:SetPlayerColor(Vector(0, 1, 0))
		end
	}
	for _key_0, _val_0 in pairs(_parent_0.__base) do
		if _base_0[_key_0] == nil and _key_0:match("^__") and not (_key_0 == "__index" and _val_0 == _parent_0.__base) then
			_base_0[_key_0] = _val_0
		end
	end
	if _base_0.__index == nil then
		_base_0.__index = _base_0
	end
	setmetatable(_base_0, _parent_0.__base)
	_class_0 = setmetatable({
		__init = function(self, ...)
			return _class_0.__parent.__init(self, ...)
		end,
		__base = _base_0,
		__name = "SANITAR",
		__parent = _parent_0
	}, {
		__index = function(cls, name)
			local val = rawget(_base_0, name)
			if val == nil then
				local parent = rawget(cls, "__parent")
				if parent then
					return parent[name]
				end
			else
				return val
			end
		end,
		__call = function(cls, ...)
			local _self_0 = setmetatable({ }, _base_0)
			cls.__init(_self_0, ...)
			return _self_0
		end
	})
	_base_0.__class = _class_0
	if _parent_0.__inherited then
		_parent_0.__inherited(_parent_0, _class_0)
	end
	SANITAR = _class_0
end
local Scrub
do
	local _class_0
	local _parent_0 = SANITAR
	local _base_0 = {
		name = "Sanitar Scrub",
		desc = [[The lowest organism in the Sanitar food chain.
Not trusted with a gun, only a beating stick and a scrubber.
How does it feel to be the one cleaning all this up?]],
		bodygroups = {
			scalp = BGROUP_SCALP_SKULLCAP,
			mouth = BGROUP_MOUTH_RESPIRATOR_DUAL,
			torso = BGROUP_TORSO_SANITAR,
			eyes = BGROUP_EYES_GOGGLES_BIKER,
			hands = BGROUP_HANDS_GLOVES_FULL
		}
	}
	for _key_0, _val_0 in pairs(_parent_0.__base) do
		if _base_0[_key_0] == nil and _key_0:match("^__") and not (_key_0 == "__index" and _val_0 == _parent_0.__base) then
			_base_0[_key_0] = _val_0
		end
	end
	if _base_0.__index == nil then
		_base_0.__index = _base_0
	end
	setmetatable(_base_0, _parent_0.__base)
	_class_0 = setmetatable({
		__init = function(self, ...)
			return _class_0.__parent.__init(self, ...)
		end,
		__base = _base_0,
		__name = "Scrub",
		__parent = _parent_0
	}, {
		__index = function(cls, name)
			local val = rawget(_base_0, name)
			if val == nil then
				local parent = rawget(cls, "__parent")
				if parent then
					return parent[name]
				end
			else
				return val
			end
		end,
		__call = function(cls, ...)
			local _self_0 = setmetatable({ }, _base_0)
			cls.__init(_self_0, ...)
			return _self_0
		end
	})
	_base_0.__class = _class_0
	if _parent_0.__inherited then
		_parent_0.__inherited(_parent_0, _class_0)
	end
	Scrub = _class_0
end
FATE_SANITAR_SCRUB = Scrub.index
local Sentry
do
	local _class_0
	local _parent_0 = SANITAR
	local _base_0 = {
		name = "Sanitar Sentry",
		desc = [[The guy who beats your ass and gets away with it.
You can expect a modicum of respect and a gun that might work.
At least you're not a scrub anymore.]],
		bodygroups = {
			scalp = BGROUP_SCALP_SANITAR,
			fullmask = {
				BGROUP_FULLMASK_GAS_PPM88,
				BGROUP_FULLMASK_GAS_CSS,
				BGROUP_FULLMASK_GAS_PBF,
				BGROUP_FULLMASK_GAS_XM40,
				BGROUP_FULLMASK_GAS_GP
			},
			torso = BGROUP_TORSO_SANITAR,
			hands = BGROUP_HANDS_GLOVES_FULL
		}
	}
	for _key_0, _val_0 in pairs(_parent_0.__base) do
		if _base_0[_key_0] == nil and _key_0:match("^__") and not (_key_0 == "__index" and _val_0 == _parent_0.__base) then
			_base_0[_key_0] = _val_0
		end
	end
	if _base_0.__index == nil then
		_base_0.__index = _base_0
	end
	setmetatable(_base_0, _parent_0.__base)
	_class_0 = setmetatable({
		__init = function(self, ...)
			return _class_0.__parent.__init(self, ...)
		end,
		__base = _base_0,
		__name = "Sentry",
		__parent = _parent_0
	}, {
		__index = function(cls, name)
			local val = rawget(_base_0, name)
			if val == nil then
				local parent = rawget(cls, "__parent")
				if parent then
					return parent[name]
				end
			else
				return val
			end
		end,
		__call = function(cls, ...)
			local _self_0 = setmetatable({ }, _base_0)
			cls.__init(_self_0, ...)
			return _self_0
		end
	})
	_base_0.__class = _class_0
	if _parent_0.__inherited then
		_parent_0.__inherited(_parent_0, _class_0)
	end
	Sentry = _class_0
end
FATE_SANITAR_SENTRY = Sentry.index
local Savior
do
	local _class_0
	local _parent_0 = SANITAR
	local _base_0 = {
		name = "Sanitar Savior",
		desc = [[Adept at cutting people up, and sometimes saving lives.
Not totally incapable of combat, but less armed than the rest.
Ensure Liver Failure gets its taxes worth out of your fellow Sanitars.]],
		bodygroups = {
			scalp = BGROUP_SCALP_SKULLCAP,
			fullmask = BGROUP_FULLMASK_BALACLAVA,
			torso = BGROUP_TORSO_SANITAR_SAVIOR,
			eyes = BGROUP_EYES_GOGGLES_BIKER,
			hands = BGROUP_HANDS_GLOVES_FULL
		},
		submaterials = {
			scalp = SUBMAT_HATSCOMBINED_WHITE,
			torso = "models/IN/clothes/male_soldier1",
			legs = "models/IN/clothes/male_soldier1"
		}
	}
	for _key_0, _val_0 in pairs(_parent_0.__base) do
		if _base_0[_key_0] == nil and _key_0:match("^__") and not (_key_0 == "__index" and _val_0 == _parent_0.__base) then
			_base_0[_key_0] = _val_0
		end
	end
	if _base_0.__index == nil then
		_base_0.__index = _base_0
	end
	setmetatable(_base_0, _parent_0.__base)
	_class_0 = setmetatable({
		__init = function(self, ...)
			return _class_0.__parent.__init(self, ...)
		end,
		__base = _base_0,
		__name = "Savior",
		__parent = _parent_0
	}, {
		__index = function(cls, name)
			local val = rawget(_base_0, name)
			if val == nil then
				local parent = rawget(cls, "__parent")
				if parent then
					return parent[name]
				end
			else
				return val
			end
		end,
		__call = function(cls, ...)
			local _self_0 = setmetatable({ }, _base_0)
			cls.__init(_self_0, ...)
			return _self_0
		end
	})
	_base_0.__class = _class_0
	if _parent_0.__inherited then
		_parent_0.__inherited(_parent_0, _class_0)
	end
	Savior = _class_0
end
FATE_SANITAR_SAVIOR = Savior.index
local Seeker
do
	local _class_0
	local _parent_0 = SANITAR
	local _base_0 = {
		name = "Sanitar Seeker",
		desc = [[Adept in sneaking, seeking, and sanitation.
He's seen more than your average Sanitar, that's for sure.
Rarely witnessed without their dangerous, deafening revolvers.]],
		bodygroups = {
			scalp = BGROUP_SCALP_SKULLCAP,
			fullmask = BGROUP_FULLMASK_BALACLAVA,
			torso = BGROUP_TORSO_SANITAR_LIGHT,
			eyes = BGROUP_EYES_GOGGLES_BIKER,
			hands = BGROUP_HANDS_GLOVES_FULL
		}
	}
	for _key_0, _val_0 in pairs(_parent_0.__base) do
		if _base_0[_key_0] == nil and _key_0:match("^__") and not (_key_0 == "__index" and _val_0 == _parent_0.__base) then
			_base_0[_key_0] = _val_0
		end
	end
	if _base_0.__index == nil then
		_base_0.__index = _base_0
	end
	setmetatable(_base_0, _parent_0.__base)
	_class_0 = setmetatable({
		__init = function(self, ...)
			return _class_0.__parent.__init(self, ...)
		end,
		__base = _base_0,
		__name = "Seeker",
		__parent = _parent_0
	}, {
		__index = function(cls, name)
			local val = rawget(_base_0, name)
			if val == nil then
				local parent = rawget(cls, "__parent")
				if parent then
					return parent[name]
				end
			else
				return val
			end
		end,
		__call = function(cls, ...)
			local _self_0 = setmetatable({ }, _base_0)
			cls.__init(_self_0, ...)
			return _self_0
		end
	})
	_base_0.__class = _class_0
	if _parent_0.__inherited then
		_parent_0.__inherited(_parent_0, _class_0)
	end
	Seeker = _class_0
end
FATE_SANITAR_SEEKER = Seeker.index
local Superior
do
	local _class_0
	local _parent_0 = SANITAR
	local _base_0 = {
		name = "Sanitar Superior",
		desc = [[Very important men with very big guns.
Only the most Sanitary Sanitars achieve the rank of Superior.
Consider yourself lucky, and in for a hell of a lot of work.]],
		bodygroups = {
			scalp = BGROUP_SCALP_KAPITAN,
			torso = BGROUP_TORSO_SANITAR,
			eyes = BGROUP_EYES_GOGGLES_BIKER,
			hands = BGROUP_HANDS_GLOVES_FULL
		}
	}
	for _key_0, _val_0 in pairs(_parent_0.__base) do
		if _base_0[_key_0] == nil and _key_0:match("^__") and not (_key_0 == "__index" and _val_0 == _parent_0.__base) then
			_base_0[_key_0] = _val_0
		end
	end
	if _base_0.__index == nil then
		_base_0.__index = _base_0
	end
	setmetatable(_base_0, _parent_0.__base)
	_class_0 = setmetatable({
		__init = function(self, ...)
			return _class_0.__parent.__init(self, ...)
		end,
		__base = _base_0,
		__name = "Superior",
		__parent = _parent_0
	}, {
		__index = function(cls, name)
			local val = rawget(_base_0, name)
			if val == nil then
				local parent = rawget(cls, "__parent")
				if parent then
					return parent[name]
				end
			else
				return val
			end
		end,
		__call = function(cls, ...)
			local _self_0 = setmetatable({ }, _base_0)
			cls.__init(_self_0, ...)
			return _self_0
		end
	})
	_base_0.__class = _class_0
	if _parent_0.__inherited then
		_parent_0.__inherited(_parent_0, _class_0)
	end
	Superior = _class_0
end
FATE_SANITAR_SUPERIOR = Superior.index
CASTES[CASTE_SANITAR].fates = {
	FATE_SANITAR_SCRUB,
	FATE_SANITAR_SENTRY,
	FATE_SANITAR_SAVIOR,
	FATE_SANITAR_SEEKER,
	FATE_SANITAR_SUPERIOR
}
