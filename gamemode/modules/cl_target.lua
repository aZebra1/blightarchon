local clamp = math.clamp
local Target
local _class_0
local _parent_0 = MODULE
local _base_0 = {
	target_info = { },
	target_cur = { },
	target_old = { },
	Think = function(self)
		self:TargetThink()
		return
	end,
	HUDPaint = function(self)
		self:DrawTargetInfo()
		return
	end,
	DrawTargetInfo = function(self)
		for k, target in pairs(self.target_info) do
			local entity = target.entity
			if IsValid(entity) then
				if self.target_cur == entity then
					target.alpha = clamp(target.alpha + 250 * FrameTime(), 0, 255)
				else
					target.alpha = clamp(target.alpha - 200 * FrameTime(), 0, 255)
				end
				local info, pos = { }, target.last_look_pos + Vector(0, 0, 6)
				if entity.TargetInfo then
					info, pos = entity:TargetInfo(LocalPlayer())
				elseif entity:IsDoor() then
					info, pos = self:TargetInfoDoor(entity)
				end
				if info and (#info > 0) then
					pos = pos:ToScreen()
					for _index_0 = 1, #info do
						local line = info[_index_0]
						local font = line.font or 'Spleen_Label'
						draw.DrawTextShadow(line.text, font, pos.x, pos.y, ColorAlpha(line.color or COLOR_WHITE, target.alpha), ColorAlpha(COLOR_BLACK, target.alpha), TEXT_ALIGN_CENTER, 2)
						surface.SetFont(font)
						local w, h = surface.GetTextSize(line.text)
						pos.y = pos.y + (h + 2)
					end
				end
			end
			if target.alpha <= 0 or not IsValid(entity) then
				self.target_info[k] = nil
			end
		end
	end,
	TargetThink = function(self)
		local ply = LocalPlayer()
		if not IsValid(ply) then
			return
		end
		local start = ply:EyePos()
		local trace = {
			start = start,
			endpos = start + ply:GetAimVector() * 128,
			filter = ply
		}
		local tr = util.TraceLine(trace)
		local ent = tr.Entity
		if IsValid(ent) and ent.TargetInfo then
			if (self.target_cur ~= self.target_old) or not IsValid(self.target_cur) then
				self.target_old = self.target_cur
				self.target_cur = ent
				local new_info = {
					entity = self.target_cur,
					last_look = CurTime(),
					alpha = 0
				}
				self.target_info[self.target_cur:EntIndex()] = new_info
			end
			local info = self.target_info[self.target_cur:EntIndex()]
			if info then
				info.last_look = CurTime()
				info.last_look_pos = tr.HitPos
			end
		else
			self.target_old = self.target_cur
			self.target_cur = nil
		end
	end,
	TargetInfoDoor = function(self, door) end
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
	__name = "Target",
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
Target = _class_0
return _class_0
