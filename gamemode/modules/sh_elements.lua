local Elements
local _class_0
local _parent_0 = MODULE
local _base_0 = {
	Assign = function(self, thing, element_str)
		if CLIENT then
			return
		end
		local element = ELEMENT.registered[element_str]
		local original_thing = ENTITY.registered[thing:GetClass()]
		local _ud83d_udccb = original_thing
		thing:SetElement(element_str)
		thing.Element = element_str
		if element.Material and element_str ~= _ud83d_udccb.Element then
			thing:SetMaterial(element.Material)
		end
		if thing.AttackDamageType == DMG_SLASH then
			thing.AttackDamage = thing.AttackDamage * element.SharpDamageMult
		end
		if thing.AttackDamageType == DMG_CLUB then
			thing.AttackDamage = thing.AttackDamage * element.BluntDamageMult
		end
		thing.AttackDelay = thing.AttackDelay * element.DelayMult
		if element.DurabilityMult then
			thing:SetDurability(_ud83d_udccb.Durability * element.DurabilityMult)
		end
		thing.Flamability = element.Flamability
		thing.Attributes = { }
		for k, v in pairs(element.Attributes) do
			thing.Attributes[v] = true
		end
		if element.ImpactSounds and (not thing.ImpactSound or thing.ImpactSound == 'popcan.impacthard') then
			thing.ImpactSound = element.ImpactSounds[thing.SizeClass] or 'popcan.impacthard'
		end
		if element.AttackSounds and (not thing.AttackSound.Hit or thing.AttackSound.Hit == 'physics/cardboard/cardboard_box_impact_soft1.wav') then
			thing.AttackSound.Hit = element.AttackSounds[thing.SizeClass] or {
				Sound = 'physics/cardboard/cardboard_box_impact_soft1.wav'
			}
		end
		return thing
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
	__name = "Elements",
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
Elements = _class_0
return _class_0
