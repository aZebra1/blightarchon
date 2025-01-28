local Ellipses, Wrap, Draw = TEXT.Ellipses, TEXT.Wrap, TEXT.Draw
local SetFont, GetTextSize = surface.SetFont, surface.GetTextSize
local ceil, min, Clamp = math.ceil, math.min, math.Clamp
local MouseX, MouseY = gui.MouseX, gui.MouseY
local lp
local ButtonHover
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = 'eclipse/ui/button_rollover.ogg'
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
		__name = "ButtonHover",
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
	ButtonHover = _class_0
end
local ButtonDown
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = 'eclipse/ui/button_click.ogg'
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
		__name = "ButtonDown",
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
	ButtonDown = _class_0
end
local ButtonUp
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = 'eclipse/ui/button_clickrelease.ogg'
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
		__name = "ButtonUp",
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
	ButtonUp = _class_0
end
local LButton
do
	local _class_0
	local _parent_0 = VGUI
	local _base_0 = {
		m_bBackground = true,
		Toggler = false,
		DoToggle = function(self, ...)
			if not self.Toggler then
				return
			end
			self.Toggled = not self.Toggled
			return self:OnToggled(self.Toggled, ...)
		end,
		OnMousePressed = function(self, mouse_code)
			if not self:IsEnabled() then
				return
			end
			if not lp then
				lp = LocalPlayer()
			end
			if self:IsSelectable() and mouse_code == MOUSE_LEFT and (input.IsShiftDown() or input.IsControlDown()) and not (lp:KeyDown(IN_FORWARD or lp:KeyDown(IN_BACK or lp:KeyDown(IN_MOVELEFT or lp:KeyDown(IN_MOVERIGHT))))) then
				return self:StartBoxSelection()
			end
			self:MouseCapture(true)
			self.Depressed = true
			LocalPlayer():EmitSound('ButtonDown')
			self:OnPressed(mouse_code)
			return self:DragMousePress(mouse_code)
		end,
		OnMouseReleased = function(self, mouse_code)
			self:MouseCapture(false)
			if not self:IsEnabled() then
				return
			end
			if not self.Depressed and dragndrop.m_DraggingMain ~= self then
				return
			end
			if self.Depressed then
				self.Depressed = nil
				self:OnReleased(mouse_code)
			end
			if self:DragMouseRelease(mouse_code) then
				return
			end
			if self:IsSelectable() and mouse_code == MOUSE_LEFT then
				if self:GetSelectionCanvas() then
					self.GetSelectionCanvas:UnselectAll()
				end
			end
			if not self.Hovered then
				return
			end
			LocalPlayer():EmitSound('ButtonUp')
			self.Depressed = true
			if MOUSE_LEFT == mouse_code then
				self:DoClick()
			elseif MOUSE_RIGHT == mouse_code then
				self:DoRightClick()
			elseif MOUSE_MIDDLE == mouse_code then
				self:DoMiddleClick()
			end
			self.Depressed = nil
		end,
		Paint = function(self, w, h)
			derma.SkinHook('Paint', 'Button', self, w, h)
			return false
		end,
		IsDown = function(self)
			return self.Depressed
		end,
		OnPressed = function(self, mouse_code) end,
		OnReleased = function(self, mouse_code) end,
		OnToggled = function(self, enabled) end,
		DoClick = function(self, ...)
			return self:DoToggle(...)
		end,
		DoRightClick = function(self) end,
		DoMiddleClick = function(self) end,
		Think = function(self)
			if not self.HoveredLast then
				if self.Hovered then
					self.HoveredLast = true
					return LocalPlayer():EmitSound('ButtonHover')
				end
			elseif not self.Hovered then
				self.HoveredLast = false
			end
		end,
		GetToggle = function(self)
			return self.Toggled
		end,
		GetDisabled = function(self)
			return not self.IsEnabled
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
			_class_0.__parent.__init(self, ...)
			self.Toggled = false
			self:SetMouseInputEnabled(true)
			self:SetCursor('hand')
			local sz = VGUI.Scale(32)
			return self:SetSize(sz, sz)
		end,
		__base = _base_0,
		__name = "LButton",
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
	LButton = _class_0
end
local LLabel
do
	local _class_0
	local _parent_0 = VGUI
	local _base_0 = {
		Text = 'Label',
		Font = 'spleen_chat_small',
		TextAlign = TEXT_ALIGN_LEFT,
		TextColor = color_white,
		Ellipses = false,
		AutoWidth = false,
		AutoHeight = false,
		AutoWrap = false,
		SetText = function(self, Text)
			self.Text = Text
			self.OriginalText = self.Text
		end,
		CalculateSize = function(self)
			SetFont(self.Font)
			return GetTextSize(self.Text)
		end,
		PerformLayout = function(self, w, h)
			local dw, dh = self:CalculateSize()
			if self.AutoWidth then
				self:SetWide(dw)
			end
			if self.AutoHeight then
				self:SetTall(dh)
			end
			if not self.OriginalText then
				self.OriginalText = self.Text
			end
			self.Text = Wrap(self.OriginalText, w, self.Font)
		end,
		Paint = function(self, w, h)
			local align = self.TextAlign
			local text
			if self.Ellipses then
				text = Ellipses(self.Text, w, self.Font)
			else
				text = self.Text
			end
			if TEXT_ALIGN_CENTER == align then
				return Draw(text, self.Font, w / 2, 0, self.TextColor, align)
			elseif TEXT_ALIGN_RIGHT == align then
				return Draw(text, self.Font, w, 0, self.TextColor, align)
			else
				return Draw(text, self.Font, 0, 0, self.TextColor)
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
		__init = function(self, ...)
			return _class_0.__parent.__init(self, ...)
		end,
		__base = _base_0,
		__name = "LLabel",
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
	LLabel = _class_0
end
local LLabelCompute
do
	local _class_0
	local _parent_0 = LLabel
	local _base_0 = {
		Think = function(self)
			_class_0.__parent.__base.Think(self)
			local txt = self:Compute()
			return self:SetText(txt)
		end,
		Compute = function(self)
			return self:GetText()
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
		__name = "LLabelCompute",
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
	LLabelCompute = _class_0
end
local LNumSlider
do
	local _class_0
	local _parent_0 = VGUI
	local _base_0 = {
		Base = 'DNumSlider',
		Height = 32
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
		__name = "LNumSlider",
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
	LNumSlider = _class_0
end
local LListView
do
	local _class_0
	local _parent_0 = VGUI
	local _base_0 = {
		Base = 'DListView'
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
		__name = "LListView",
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
	LListView = _class_0
end
local size = VGUI.Scale(200)
local LFrame
do
	local _class_0
	local _parent_0 = VGUI
	local _base_0 = {
		Base = 'EditablePanel',
		title = 'Window',
		IsMenu = false,
		DeleteOnClose = true,
		Draggable = true,
		Sizable = false,
		MinWidth = size,
		MinHeight = size,
		ScreenLock = true,
		DeleteOnClose = true,
		BackgroundBlur = false,
		PaintShadow = true,
		ShowCloseButton = function(self, bShow)
			return self.btnClose:SetVisible(bShow)
		end,
		GetTitle = function(self)
			return self.lblTitle:GetText()
		end,
		SetTitle = function(self, strTitle)
			return self.lblTitle:SetText(strTitle)
		end,
		Close = function(self)
			self:SetVisible(false)
			if self.DeleteOnClose then
				self:Remove()
			end
			return self:OnClose()
		end,
		OnClose = function(self) end,
		Center = function(self)
			self:InvalidateLayout(true)
			self:CenterVertical()
			return self:CenterHorizontal()
		end,
		IsActive = function(self)
			if self:HasFocus() or vgui.FocusedHasParent(self) then
				return true
			end
		end,
		SetIcon = function(self, str)
			if not str and IsValid(self.imgIcon) then
				return self.imgIcon:Remove()
			end
			if not IsValid(self.imgIcon) then
				self.imgIcon = LImage()
			end
			if IsValid(self.imgIcon) then
				return self.imgIcon:SetMaterial(Material(str))
			end
		end,
		Think = function(self)
			local sW, sH = ScrW(), ScrH()
			local mX = Clamp(MouseX(), 1, sW - 1)
			local mY = Clamp(MouseY(), 1, sH - 1)
			local w, h = self:GetWide(), self:GetTall()
			if self.Dragging then
				local x = mX - self.Dragging[1]
				local y = mY - self.Dragging[2]
				if self.ScreenLock then
					x = Clamp(x, 0, sW - w)
					y = Clamp(y, 0, sH - h)
				end
				self:SetPos(x, y)
			end
			if self.Sizing then
				local x = mX - self.Sizing[1]
				local y = mY - self.Sizing[2]
				local pX, pY = self:GetPos()
				if x < self.MinWidth then
					x = self.MinWidth
				elseif x > sW - pX and self.ScreenLock then
					x = sW - pX
				end
				if y < self.MinHeight then
					y = self.MinHeight
				elseif y > sH - pY and self.ScreenLock then
					y = sH - pY
				end
				self:SetSize(x, y)
				return self:SetCursor('sizenwse')
			end
			local sX, sY = self:LocalToScreen(0, 0)
			if self.Hovered and self.Sizable and mX > (sX + w - 20) and mY > (sY + h - 20) then
				return self:SetCursor('sizenwse')
			end
			if self.Hovered and self.Draggable and mY < (sY + 24) then
				return self:SetCursor('sizeall')
			end
			self:SetCursor('arrow')
			if self.y < 0 then
				return self:SetPos(self.x, 0)
			end
		end,
		Paint = function(self, w, h)
			if self.BackgroundBlur then
				Derma_DrawBackgroundBlur(self, self.timeBirth)
			end
			derma.SkinHook('Paint', 'Frame', self, w, h)
			return true
		end,
		OnMousePressed = function(self)
			local sX, sY = self:LocalToScreen(0, 0)
			local mX, mY = MouseX(), MouseY()
			if self.Sizable and mX > (sX + w - 20) and mY > (sY + h - 20) then
				self.Sizing = {
					mX - w,
					mY - h
				}
				return self:MouseCapture(true)
			end
			if self.Draggable and mY < (sY + 24) then
				self.Dragging = {
					mX - self.x,
					mY - self.y
				}
				return self:MouseCapture(true)
			end
		end,
		OnMouseReleased = function(self)
			self.Dragging = nil
			self.Sizing = nil
			return self:MouseCapture(false)
		end,
		PerformLayout = function(self)
			local titlePush = 0
			if IsValid(self.imgIcon) then
				local _with_0 = self.imgIcon
				_with_0:SetPos(5, 5)
				_with_0:SetSize(16, 16)
				titlePush = 16
			end
			local w = self:GetWide()
			do
				local _with_0 = self.btnClose
				_with_0:SetPos(w - 31 - 4, 0)
				_with_0:SetSize(31, 24)
			end
			local _with_0 = self.lblTitle
			_with_0:SetPos(8 + titlePush, 2)
			_with_0:SetSize(w - 25 - titlePush, 20)
			return _with_0
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
			_class_0.__parent.__init(self, ...)
			self:SetFocusTopLevel(true)
			do
				local _with_0 = LButton()
				self.btnClose = _with_0
				self:Add(self.btnClose)
				_with_0:SetText('')
				_with_0.DoClick = function()
					return self:Close()
				end
				_with_0.Paint = function(panel, w, h)
					return derma.SkinHook('Paint', 'WindowCloseButton', panel, w, h)
				end
			end
			do
				local _with_0 = LLabel()
				self.lblTitle = _with_0
				self:Add(self.lblTitle)
				_with_0:SetMouseInputEnabled(false)
				_with_0.UpdateColours = function(label, skin)
					local color = skin.Colours.Window.TitleInactive
					if self:IsActive() then
						color = skin.Colours.Window.TitleActive
					end
					_with_0.TextStyleColor = color
				end
				_with_0:SetText(self.title)
			end
			self:SetPaintBackgroundEnabled(false)
			self:SetPaintBorderEnabled(false)
			self.timeBirth = SysTime()
			return self:DockPadding(5, 24 + 5, 5, 5)
		end,
		__base = _base_0,
		__name = "LFrame",
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
	LFrame = _class_0
end
local LPanel
do
	local _class_0
	local _parent_0 = VGUI
	local _base_0 = {
		Base = 'Panel',
		PaintBackground = true,
		IsMenu = false,
		TabbingDisabled = false,
		Disabled = false,
		BackgroundColor = nil,
		Paint = function(self, a, b, c, d)
			return derma.SkinHook('Paint', 'Panel', self, a, b, c, d)
		end,
		ApplySchemeSettings = function(self, a, b, c, d)
			return derma.SkinHook('Scheme', 'Panel', self, a, b, c, d)
		end,
		PerformLayout = function(self, a, b, c, d)
			return derma.SkinHook('Layout', 'Panel', self, a, b, c, d)
		end,
		SetDisabled = function(self, Disabled)
			self.Disabled = Disabled
			if self.Disabled then
				self:SetAlpha(75)
				return self:SetMouseInputEnabled(false)
			else
				self:SetAlpha(255)
				return self:SetMouseInputEnabled(true)
			end
		end,
		SetEnabled = function(self, bool)
			return self:SetDisabled(not bool)
		end,
		IsEnabled = function(self)
			return not self.Disabled
		end,
		OnMousePressed = function(self, mouse_code)
			if self:IsSelectionCanvas() and not dragndrop.IsDragging() then
				return self:StartBoxSelection()
			end
			if self:IsDraggable() then
				self:MouseCapture(true)
				return self:DragMousePress(mouse_code)
			end
		end,
		OnMouseReleased = function(self, mouse_code)
			if self:EndBoxSelection() then
				return
			end
			self:MouseCapture(false)
			if self:DragMouseRelease(mouse_code) then
				return
			end
		end,
		UpdateColours = function(self) end
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
			_class_0.__parent.__init(self, ...)
			self:SetPaintBackgroundEnabled(false)
			return self:SetPaintBorderEnabled(false)
		end,
		__base = _base_0,
		__name = "LPanel",
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
	LPanel = _class_0
end
local LTextEntry
local _class_0
local _parent_0 = VGUI
local _base_0 = {
	Base = 'DTextEntry',
	EnterAllowed = true,
	UpdateOnType = false,
	Numeric = false,
	HistoryEnabled = false,
	PlaceholderText = '...',
	Disabled = false,
	Colors = {
		Text = nil,
		Placeholder = nil,
		Highlight = nil,
		Cursor = nil
	},
	OnFocusChanged = function(self, focus)
		return print(focus)
	end,
	IsEditing = function(self)
		return self == vgui.GetKeyboardFocus()
	end,
	GetDisabled = function(self)
		return self.Disabled
	end,
	GetTextColor = function(self)
		return self.Colors.Text or self:GetSkin().colTextEntryText
	end,
	GetPlaceholderColor = function(self)
		return self.Colors.Placeholder or self:GetSkin().colTextEntryTextPlaceholder
	end,
	GetHighlightColor = function(self)
		return self.Colors.Highlight or self:GetSkin().colTextEntryTextHighlight
	end,
	GetCursorColor = function(self)
		return self.Colors.Cursor or self:GetSkin().colTextEntryTextCursor
	end,
	OnKeyCodeTyped = function(self, code)
		self:OnKeyCode(code)
		if KEY_ENTER == code then
			if self.EnterAllowed and not self:IsMultiline() then
				if IsValid(self.Menu) then
					self.Menu:Remove()
				end
				self:FocusNext()
				self:OnEnter()
				self.HistoryPos = 0
			end
		elseif KEY_UP == code then
			if self.HistoryEnabled or self.Menu then
				self.HistoryPos = self.HistoryPos - 1
				return self:UpdateFromHistory()
			end
		elseif KEY_DOWN == code or KEY_TAB == code then
			if self.HistoryEnabled or self.Menu then
				self.HistoryPos = self.HistoryPos + 1
				return self:UpdateFromHistory()
			end
		elseif KEY_BACKSPACE == code then
			local txt = self:GetText()
			txt = txt:sub(1, -1)
			self:SetText(txt)
			return self:SetCaretPos(txt:len())
		elseif KEY_LWIN == code or KEY_RWIN == code or KEY_LALT == code or KEY_RALT == code or KEY_LCONTROL == code or KEY_RCONTROL == code or KEY_LSHIFT == code or KEY_RSHIFT == code or KEY_CAPSLOCK == code then
		else
			local glyph = input.GetKeyName(code)
			if glyph then
				local txt = self:GetText()
				txt = txt .. glyph
				self:SetText(txt)
				return self:SetCaretPos(txt:len())
			end
		end
	end,
	OnKeyCode = function(self, code)
		if not self:GetParent() then
			return
		end
		local parent = self:GetParent()
		if parent.OnKeyCode then
			return parent:OnKeyCode(code)
		end
	end,
	UpdateFromHistory = function(self)
		if IsValid(self.Menu) then
			return self:UpdateFromMenu()
		end
		local pos = self.HistoryPos
		if pos < 0 then
			pos = #self.History
		end
		if pos > #self.History then
			pos = 0
		end
		local txt = self.History[pos]
		txt = txt or ''
		self:SetText(txt)
		self:SetCaretPos(txt:len())
		self:OnTextChanged()
		self.HistoryPos = pos
	end,
	UpdateFromMenu = function(self)
		local pos = self.HistoryPos
		local num = self.Menu:ChildCount()
		self.Menu:ClearHighlights()
		if pos < 0 then
			pos = num
		end
		if pos > num then
			pos = 0
		end
		do
			local child = self.Menu:GetChild(pos)
			if child then
				self.Menu:HighlightItem(child)
				local txt = child:GetText()
				self:SetText(txt)
				self:SetCaretPos(txt:len())
				self:OnTextChanged(true)
			else
				self:SetText('')
			end
		end
		self.HistoryPos = pos
	end,
	OnTextChanged = function(self, preserveMenu)
		self.HistoryPos = 0
		if self.UpdateOnType then
			self:OnValueChange(self:GetText())
		end
		if IsValid(self.Menu and not preserveMenu) then
			self.Menu:Remove()
		end
		do
			local tab = self:GetAutoComplete(self:GetText())
			if tab then
				self:OpenAutoComplete(tab)
			end
		end
		return self:OnChange()
	end,
	OnChange = function(self)
		local parent = self:GetParent()
		if parent and parent.OnChange then
			return parent:OnChange()
		end
	end,
	OpenAutoComplete = function(self, tab)
		if not tab then
			return
		end
		if #tab == 0 then
			return
		end
		self.Menu = DermaMenu()
		for _index_0 = 1, #tab do
			local option = tab[_index_0]
			self.Menu:AddOption(option, function()
				self:SetText(option)
				self:SetCaretPos(option:len())
				return self:RequestFocus()
			end)
		end
		local x, y = self:LocalToScreen(0, self:GetTall())
		local _with_0 = self.Menu
		_with_0:SetMinimumWidth(self:GetWide())
		_with_0:Open(x, y, true, self)
		_with_0:SetPos(x, y)
		_with_0:SetMaxHeight((ScrH() - y) - 10)
		return _with_0
	end,
	OnEnter = function(self)
		self:OnValueChange(self:GetText())
		local parent = self:GetParent()
		if parent and parent.OnEnter then
			return parent:OnEnter()
		end
	end,
	Paint = function(self, w, h)
		derma.SkinHook('Paint', 'TextEntry', self, w, h)
		return false
	end,
	PerformLayout = function(self)
		return derma.SkinHook('Layout', 'TextEntry', self)
	end,
	SetValue = function(self, value)
		if self:IsEditing() then
			return
		end
		self:SetText(value)
		self:OnValueChange(value)
		return self:SetCaretPos(self:GetCaretPos())
	end,
	OnValueChange = function(self, value)
		local parent = self:GetParent()
		return parent:OnValueChange(value)
	end,
	CheckNumeric = function(self, value)
		if not self.Numeric then
			return false
		end
		if not string.find(numerics, values, 1, true) then
			return true
		end
		return false
	end,
	AllowInput = function(self, value)
		if self.CheckNumeric then
			return true
		end
		local parent = self:GetParent()
		if parent and parent.AllowInput then
			return parent:AllowInput(value)
		end
	end,
	SetEditable = function(self, enabled)
		self:SetKeyboardInputEnabled(enabled)
		return self:SetMouseInputEnabled(enabled)
	end,
	OnGetFocus = function(self)
		hook.Run('OnTextEntryGetFocus', self)
		local parent = self:GetParent()
		if parent and parent.OnGetFocus then
			parent:OnGetFocus()
		end
		if self:GetText() == self.PlaceholderText then
			return self:SetText('')
		end
	end,
	OnLoseFocus = function(self)
		hook.Call('OnTextEntryLoseFocus', nil, self)
		if parent and parent.OnLoseFocus then
			parent:OnLoseFocus()
		end
		if self:GetText():len() == 0 then
			return self:SetText(self.PlaceholderText)
		end
	end,
	OnMousePressed = function(self, mcode)
		return self:OnGetFocus()
	end,
	AddHistory = function(self, txt)
		if txt == '' or not txt then
			return
		end
		table.RemoveByValue(self.History, txt)
		return table.insert(self.History, txt)
	end,
	GetAutoComplete = function(self, txt)
		local parent = self:GetParent()
		if parent and parent.GetAutoComplete then
			return parent:GetAutoComplete(txt)
		end
	end,
	GetInt = function(self)
		local num = tonumber(self:GetText())
		if not num then
			return
		end
		return math.floor(num + .5)
	end,
	GetFloat = function(self)
		return tonumber(self:GetText())
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
		_class_0.__parent.__init(self, ...)
		self.History = { }
		self.HistoryPos = 0
		self:SetPaintBorderEnabled(false)
		self:SetPaintBackgroundEnabled(false)
		self:SetAllowNonAsciiCharacters(true)
		self:SetTall(VGUI.Scale(34))
		self.m_bBackground = true
		self.m_bLoseFocusOnClickAway = true
		self:SetCursor('beam')
		self:SetFontInternal('ChatFont')
		return self:SetText(self.PlaceholderText)
	end,
	__base = _base_0,
	__name = "LTextEntry",
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
LTextEntry = _class_0
return _class_0
