local LFrame, LButton, LLabel, LNumSlider
do
	local _obj_0 = VGUI.registered
	LFrame, LButton, LLabel, LNumSlider = _obj_0.LFrame, _obj_0.LButton, _obj_0.LLabel, _obj_0.LNumSlider
end
local round = math.round
local Tweaker
do
	local _class_0
	local _parent_0 = LFrame
	local _base_0 = {
		Title = 'Tweaker',
		Width = 320,
		Height = 280,
		IsMenu = true,
		GetItem = function(self) end,
		item_offset = 'HandOffset',
		Think = function(self)
			_class_0.__parent.__base.Think(self)
			if self.item then
				if (not IsValid(self.item)) or self:GetItem() ~= self.item then
					return self:Remove()
				end
			else
				return self:Remove()
			end
		end,
		PerformLayout = function(self)
			_class_0.__parent.__base.PerformLayout(self)
			local _list_0 = self.controls
			for _index_0 = 1, #_list_0 do
				local slider = _list_0[_index_0]
				slider:SetWide(self:GetWide() * 4 / 15)
				slider.resetButton:SetPos(16, slider:GetY())
			end
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
		__init = function(self, x, y)
			_class_0.__parent.__init(self, x, y)
			if self.__class.instance then
				if IsValid(self.__class.instance) then
					self.__class.instance:Remove()
				end
				self.__class.instance = nil
			end
			self.__class.instance = self
			timer.Simple(0.05, function()
				return self:SetSize(self.Width, self.Height)
			end)
			self.item = self:GetItem()
			local offset = self.item[self.item_offset]
			self.controls = { }
			local _list_0 = {
				'x',
				'y',
				'z'
			}
			for _index_0 = 1, #_list_0 do
				local axis = _list_0[_index_0]
				local slider = LNumSlider()
				self:Add(slider)
				slider:SetText(axis)
				slider:SetMinMax(-23, 23)
				slider:SetDecimals(2)
				slider:SetValue((self.item and offset) and offset.Pos[axis] or 0)
				slider.OnValueChanged = function(self, val)
					local parent = self:GetParent()
					local item, item_offset = parent.item, parent.item_offset
					local oset = item[item_offset]
					oset.Pos[axis] = val
				end
				slider:DockMargin(48, 0, 0, 0)
				do
					local _obj_0 = self.controls
					_obj_0[#_obj_0 + 1] = slider
				end
				slider:Dock(TOP)
				local _with_0 = LButton()
				slider.resetButton = _with_0
				self:Add(slider.resetButton)
				_with_0.DoClick = function(self)
					return slider:SetValue(0)
				end
			end
			local _list_1 = {
				'p',
				'y',
				'r'
			}
			for _index_0 = 1, #_list_1 do
				local raxis = _list_1[_index_0]
				local slider = LNumSlider()
				self:Add(slider)
				slider:SetText(raxis)
				slider:SetMinMax(-180, 180)
				slider:SetDecimals(2)
				slider:SetValue((self.item and offset) and offset.Ang[raxis] or 0)
				slider.OnValueChanged = function(self, val)
					local parent = self:GetParent()
					local item, item_offset = parent.item, parent.item_offset
					local oset = item[item_offset]
					oset.Ang[raxis] = val
				end
				slider:DockMargin(48, 0, 0, 0)
				do
					local _obj_0 = self.controls
					_obj_0[#_obj_0 + 1] = slider
				end
				slider:Dock(TOP)
				local _with_0 = LButton()
				slider.resetButton = _with_0
				self:Add(slider.resetButton)
				_with_0.DoClick = function(self)
					return slider:SetValue(0)
				end
			end
			do
				local outputButton = LButton()
				self:Add(outputButton)
				local wide = self:GetWide() / 3
				outputButton:DockMargin(wide, 0, wide, 10)
				outputButton.DoClick = function(self)
					local item = self:GetParent().item
					if not (item and IsValid(item)) then
						return
					end
					local offp = offset.Pos
					local offa = offset.Ang
					local vectxt = "Pos: Vector " .. tostring(round(offp.x, 2)) .. ", " .. tostring(round(offp.y, 2)) .. ", " .. tostring(round(offp.z, 2))
					local angtxt = "Ang: Angle " .. tostring(round(offa.x, 2)) .. ", " .. tostring(round(offa.y, 2)) .. ", " .. tostring(round(offa.z, 2))
					SetClipboardText(tostring(vectxt) .. "\n" .. tostring(angtxt))
					return print(item:GetModel(), "\n" .. tostring(vectxt), "\n" .. tostring(angtxt))
				end
				outputButton:Dock(BOTTOM)
			end
			return self:MakePopup()
		end,
		__base = _base_0,
		__name = "Tweaker",
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
	Tweaker = _class_0
end
local TweakerHand
do
	local _class_0
	local _parent_0 = Tweaker
	local _base_0 = {
		GetItem = function(self)
			return LocalPlayer():Wielding()
		end,
		item_offset = 'HandOffset'
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
		__name = "TweakerHand",
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
	TweakerHand = _class_0
end
local TweakerOffhand
do
	local _class_0
	local _parent_0 = Tweaker
	local _base_0 = {
		GetItem = function(self)
			return LocalPlayer():WieldingOffhand()
		end,
		item_offset = 'HandOffset'
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
		__name = "TweakerOffhand",
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
	TweakerOffhand = _class_0
end
local TweakerBeltL
do
	local _class_0
	local _parent_0 = Tweaker
	local _base_0 = {
		GetItem = function(self)
			return LocalPlayer():GetInventory():GetSlot(SLOT_BELT_L)
		end,
		item_offset = 'BeltLeftOffset'
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
		__name = "TweakerBeltL",
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
	TweakerBeltL = _class_0
end
local TweakerBeltR
local _class_0
local _parent_0 = Tweaker
local _base_0 = {
	GetItem = function(self)
		return LocalPlayer():GetInventory():GetSlot(SLOT_BELT_R)
	end,
	item_offset = 'BeltRightOffset'
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
	__name = "TweakerBeltR",
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
TweakerBeltR = _class_0
return _class_0
