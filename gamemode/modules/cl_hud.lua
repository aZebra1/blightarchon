local _anon_func_0 = function(name, self)
	local _check_0 = self.dont_draw
	for _index_0 = 1, #_check_0 do
		if _check_0[_index_0] == name then
			return true
		end
	end
	return false
end
local HUD
local _class_0
local _parent_0 = MODULE
local _base_0 = {
	HUDShouldDraw = function(self, name)
		if _anon_func_0(name, self) then
			return false
		end
	end,
	HUDItemPickedUp = function(self)
		return false
	end,
	HUDDrawPickupHistory = function(self)
		return false
	end,
	meters = {
		speed = {
			open = false,
			x = 0,
			pct_curr = 0,
			pct_targ = 0
		}
	},
	DrawSpeedMeter = function(self)
		local ply = LocalPlayer()
		local speed = ply:GetVelocity():Length2D()
		local rag = ply:GetRagdoll()
		if not (rag and IsValid(rag)) and (ply:KeyDown(IN_SPEED) or speed > SPEED_WALK * 1.1) then
			self.meters.speed.x = Lerp(0.03, self.meters.speed.x, 20)
			local target = ply:GetSpeedTarget()
			self.meters.speed.pct_curr = math.min(1, Lerp(FrameTime() * 5, self.meters.speed.pct_curr, speed / SPEED_SPRINT))
			self.meters.speed.pct_targ = Lerp(FrameTime() * 5, self.meters.speed.pct_targ, target / SPEED_SPRINT)
			if not self.meters.speed.open then
				self.meters.speed.open = true
			end
		else
			self.meters.speed.x = Lerp(0.03, self.meters.speed.x, -20)
			self.meters.speed.pct_curr = Lerp(0.1, self.meters.speed.pct_curr, 0)
			self.meters.speed.pct_targ = Lerp(0.1, self.meters.speed.pct_targ, 0)
			if self.meters.speed.open then
				self.meters.speed.open = false
			end
		end
		local y = ScrH() * 0.5
		if self.meters.speed.x > 0 then
			local dark = 0.35 + math.abs(math.sin(CurTime()) / 4)
			draw.NoTexture()
			surface.SetDrawColor(ColorAlpha(COLOR_BLACK, 255))
			draw.DrawArc(self.meters.speed.x, y, 20, 0, 360)
			surface.SetDrawColor(Darken(COLOR_YELLOW, dark))
			draw.DrawRing(self.meters.speed.x, y, 20, 6, 0, math.floor(360 * self.meters.speed.pct_targ))
			surface.SetDrawColor(Darken(COLOR_RED, dark))
			draw.DrawRing(self.meters.speed.x, y, 20, 4, 0, math.max(1, math.floor(360 * self.meters.speed.pct_curr)))
		end
		return
	end,
	DrawInventory = function(self)
		local ply = LocalPlayer()
		if not IsValid(ply) then
			return
		end
		local wielding, wielding_off = ply:Wielding(), ply:WieldingOffhand()
		if IsValid(wielding) then
			local name = _ud83d_udcbe.Inspect:Inspect(ply, wielding) or wielding:ProcessIName()
			surface.SetFont('spleen_label')
			local w, h = surface.GetTextSize(name)
			draw.DrawTextShadow(name, "spleen_label", ScrW() - 20, ScrH() - h - 20, COLOR_WHITE, COLOR_BLACK, TEXT_ALIGN_RIGHT)
		end
		if IsValid(wielding_off) then
			local name = _ud83d_udcbe.Inspect:Inspect(ply, wielding_off) or wielding_off:ProcessIName()
			surface.SetFont('spleen_label')
			local w, h = surface.GetTextSize(name)
			return draw.DrawTextShadow(name, "spleen_label", 20, ScrH() - h - 20, COLOR_WHITE, COLOR_BLACK, TEXT_ALIGN_LEFT)
		end
	end,
	HUDDrawTargetID = function(self)
		return false
	end,
	HUDPaint = function(self)
		hook.Run("PaintWorldTips")
		do
			local _obj_0 = BUBBLE
			if _obj_0 ~= nil then
				_obj_0:Draw()
			end
		end
		self:DrawSpeedMeter()
		self:DrawInventory()
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
	__name = "HUD",
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
local self = _class_0;
self.dont_draw = {
	'CHudAmmo',
	'CHudSecondaryAmmo',
	'CHudHealth',
	'CHudBattery',
	'CHudCrosshair',
	'CHudWeapon',
	'CHudWeaponSelection',
	'CHudZoom',
	'CHudDamageIndicator',
	'CHudGeiger',
	'CHudChat',
	'CHudHistoryResource'
}
if _parent_0.__inherited then
	_parent_0.__inherited(_parent_0, _class_0)
end
HUD = _class_0
return _class_0
