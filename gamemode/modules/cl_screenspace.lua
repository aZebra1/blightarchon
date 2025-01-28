local max = math.max
local Screenspace
do
	local _class_0
	local _parent_0 = MODULE
	local _base_0 = {
		BlendSets = {
			HPPD = {
				src_blend = BLEND_DST_COLOR,
				dst_blend = BLEND_DST_ALPHA,
				blend_fnc = BLENDFUNC_ADD,
				rate = 8,
				passes = function()
					return max(1, 1 + LocalPlayer():Status(STATUS_FATIGUE) * 2)
				end,
				textures = { }
			}
		},
		BlendOverlay = function(self, set, mul)
			if mul == nil then
				mul = 1
			end
			local OverrideAlphaWriteEnable, OverrideDepthEnable, OverrideBlend, SetMaterial, DrawScreenQuadEx = render.OverrideAlphaWriteEnable, render.OverrideDepthEnable, render.OverrideBlend, render.SetMaterial, render.DrawScreenQuadEx
			local floor, sin, cos = math.floor, math.sin, math.cos
			OverrideAlphaWriteEnable(true, true)
			OverrideDepthEnable(true, false)
			OverrideBlend(true, set.src_blend, set.dst_blend, set.blend_fnc, BLEND_ONE, BLEND_ZERO, BLENDFUNC_ADD)
			local passes = set.passes
			if isfunction(passes) then
				passes = passes()
			end
			for i = 1, passes do
				local idx = (floor((CurTime() * 1 + (passes / 5)) * set.rate) % #set.textures) + 1
				SetMaterial(set.textures[idx])
				local x = ScrW() * -0.15 + ScrW() * 0.1 * sin(CurTime() * (i / 10) * mul)
				local y = ScrH() * -0.15 + ScrH() * 0.1 * cos(CurTime() * (i / 10) * mul)
				DrawScreenQuadEx(x, y, ScrW() * 1.5, ScrH() * 1.5)
			end
			OverrideBlend(false)
			OverrideAlphaWriteEnable(false)
			return OverrideDepthEnable(false)
		end,
		RenderScreenspaceEffects = function(self)
			local sin, abs = math.sin, math.abs
			local tab = {
				["$pp_colour_addr"] = 0,
				["$pp_colour_addg"] = 0,
				["$pp_colour_addb"] = 0,
				["$pp_colour_brightness"] = -0.02,
				["$pp_colour_contrast"] = 0.6 + (abs(sin(CurTime() * 0.166)) * 0.5),
				["$pp_colour_colour"] = 1.8 + abs(sin(CurTime() * 0.5)),
				["$pp_colour_mulr"] = 1.5 + abs(sin(CurTime() * 0.789)),
				["$pp_colour_mulg"] = 0.5,
				["$pp_colour_mulb"] = 0.5
			}
			self:BlendOverlay(self.BlendSets.HPPD)
			return DrawColorModify(tab)
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
		__name = "Screenspace",
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
	Screenspace = _class_0
end
for i = 1, 8 do
	local mat = Material("dysphoria/blends/colornoise/a" .. tostring(i) .. ".png")
	table.insert(Screenspace.BlendSets.HPPD.textures, mat)
end
