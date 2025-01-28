BIND('dev_cursor', KEY_F4, {
	Press = function(self, ply)
		if not ply:IsAdmin() then
			return
		end
		if not CLIENT then
			return
		end
		local toggled = vgui.CursorVisible()
		return gui.EnableScreenClicker(not toggled)
	end
})
BIND('dev_camera', KEY_F3, {
	Press = function(self, ply)
		if not ply:IsAdmin() then
			return
		end
		if not CLIENT then
			return
		end
		if DEVCAM then
			DEVCAM = nil
		else
			DEVCAM = {
				pos = ply:EyePos(),
				ang = ply:EyeAngles()
			}
		end
	end
})
concommand.Add('twkr', function()
	local _with_0 = VGUI.registered.TweakerHand()
	_with_0:SetSize(320, 200)
	_with_0:Center()
	_with_0.item = LocalPlayer():Wielding()
	return _with_0
end)
concommand.Add('twkr_off', function()
	local _with_0 = VGUI.registered.TweakerOffhand()
	_with_0:SetSize(320, 200)
	_with_0:Center()
	_with_0.item = LocalPlayer():WieldingOffhand()
	return _with_0
end)
concommand.Add('twkr_beltL', function()
	local _with_0 = VGUI.registered.TweakerBeltL()
	_with_0:SetSize(320, 200)
	_with_0:Center()
	_with_0.item = LocalPlayer():GetInventory():GetSlot(SLOT_BELT_L)
	return _with_0
end)
concommand.Add('twkr_beltR', function()
	local _with_0 = VGUI.registered.TweakerBeltR()
	_with_0:SetSize(320, 200)
	_with_0:Center()
	_with_0.item = LocalPlayer():GetInventory():GetSlot(SLOT_BELT_R)
	return _with_0
end)
concommand.Add('sqv', function()
	local _with_0 = VGUI.registered.Seqview()
	_with_0:SetSize(320, 200)
	_with_0:Center()
	return _with_0
end)
local Dev
local _class_0
local _parent_0 = MODULE
local _base_0 = {
	PreDrawHalos = function(self)
		if not IsValid(vgui.GetHoveredPanel()) then
			return
		end
		local ent = properties.GetHovered(EyePos(), gui.ScreenToVector(gui.MousePos()))
		if not IsValid(ent) then
			return
		end
		local c = Color(255, 255, 255, 255)
		c.r = 200 + math.sin(RealTime() * 50) * 55
		c.g = 200 + math.sin(RealTime() * 20) * 55
		c.b = 200 + math.cos(RealTime() * 60) * 55
		local t = {
			ent
		}
		if (ent.GetActiveWeapon and IsValid(ent:GetActiveWeapon())) then
			t[#t + 1] = ent:GetActiveWeapon()
		end
		return halo.Add(t, c, 2, 2, 2, true, false)
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
	__name = "Dev",
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
Dev = _class_0
return _class_0
