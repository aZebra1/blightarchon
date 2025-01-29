local PRES_MASCULINE = 1
local PRES_FEMININE = 2
local PRES_ANDROGYNOUS = 3
local DESC_LOOKS = 1
local DESC_SOUNDS = 2
local DESC_SMELLS = 3
local ATTRIBUTE_COLD = 1
local ATTRIBUTE_FUCKED_UP = 2
local ATTRIBUTE_MEAN = 3
local ATTRIBUTE_RELENTLESS = 4
local Character
local _class_0
local _parent_0 = MODULE
local _base_0 = {
	caste = CASTE_SCUM,
	fate = {
		desc = {
			[DESC_LOOKS] = "stupid",
			[DESC_SOUNDS] = "boring",
			[DESC_SMELLS] = "bland"
		}
	},
	presentation = PRES_ANDROGYNOUS,
	atributes = {
		[ATTRIBUTE_COLD] = 1,
		[ATTRIBUTE_FUCKED_UP] = 1,
		[ATTRIBUTE_MEAN] = 1,
		[ATTRIBUTE_RELENTLESS] = 1
	},
	skills = { },
	motive = "fear",
	PlayerSpawn = function(self, ply)
		local caste = CASTES[CASTE_SCUM]
		local fate_idx = table.Random(caste.fates)
		ply:InitializeBody()
		ply:SetCaste(caste.index)
		ply:SetFate(12)
		PrintTable(caste.fates)
		local fate = ply:FateTable()
		PrintTable(fate)
		if fate.bodygroups then
			local scalp = fate.bodygroups.scalp or 0
			if istable(scalp) then
				scalp = table.Random(scalp)
			end
			ply:SetBodygroup(1, scalp)
			local mouth = fate.bodygroups.mouth or 0
			if istable(mouth) then
				mouth = table.Random(mouth)
			end
			ply:SetBodygroup(3, mouth)
			local mask = fate.bodygroups.fullmask or 0
			if istable(mask) then
				mask = table.Random(mask)
			end
			ply:SetBodygroup(4, mask)
			local eyes = fate.bodygroups.eyes or 0
			if istable(eyes) then
				eyes = table.Random(eyes)
			end
			ply:SetBodygroup(6, eyes)
			local hands = fate.bodygroups.hands or 1
			if istable(hands) then
				hands = table.Random(hands)
			end
			ply:SetBodygroup(7, hands)
			local torso = fate.bodygroups.torso or 0
			if istable(torso) then
				torso = table.Random(torso)
			end
			ply.Body.torso:SetBodygroup(0, torso)
			local legs = fate.bodygroups.legs or 0
			if istable(legs) then
				legs = table.Random(legs)
			end
			ply.Body.legs:SetBodygroup(0, legs)
		end
		if fate.submaterials then
			ply:SetSubMaterial(SUBMAT_INDEX_HAT, fate.submaterials.scalp or SUBMAT_HATSCOMBINED_DEFAULT)
			ply.Body.torso:SetSubMaterial(0, fate.submaterials.torso or nil)
			ply.Body.legs:SetSubMaterial(0, fate.submaterials.legs or nil)
		end
		do
			local _obj_0 = fate.OnSpawn
			if _obj_0 ~= nil then
				_obj_0(fate, ply)
			end
		end
		return
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
	__name = "Character",
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
Character = _class_0
return _class_0
