local LFrame, LButton, LListView, LTextEntry, LLabel, LNumSlider
do
	local _obj_0 = VGUI.registered
	LFrame, LButton, LListView, LTextEntry, LLabel, LNumSlider = _obj_0.LFrame, _obj_0.LButton, _obj_0.LListView, _obj_0.LTextEntry, _obj_0.LLabel, _obj_0.LNumSlider
end
local round = math.round
local Seqview
local _class_0
local _parent_0 = LFrame
local _base_0 = {
	Title = 'Seqview',
	Width = 320,
	Height = 280,
	IsMenu = true
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
		local search, seqlist
		do
			search = LTextEntry(self)
			search:Dock(TOP)
			search.OnKeyCode = function(self, code)
				_class_0.__parent.__init(self, code)
				return seqlist:UpdateList(search:GetText())
			end
		end
		do
			seqlist = LListView(self)
			seqlist:Dock(FILL)
			seqlist:SetMultiSelect(false)
			seqlist:AddColumn("Sequence")
			seqlist.UpdateList = function(self, txt)
				if not txt then
					return
				end
				for i = #seqlist:GetLines(), 1 do
					print(i)
					seqlist:RemoveLine(i)
				end
				local seqs = LocalPlayer():GetSequenceList()
				txt = txt:trim():lower()
				print(txt, "yeah")
				for _index_0 = 1, #seqs do
					local seq = seqs[_index_0]
					if seq:find(txt) then
						seqlist:AddLine(seq)
					end
				end
			end
			local _list_0 = LocalPlayer():GetSequenceList()
			for _index_0 = 1, #_list_0 do
				local v = _list_0[_index_0]
				seqlist:AddLine(v)
			end
			seqlist.OnRowSelected = function(self, idx, panel)
				return LocalPlayer():Spasm({
					sequence = panel:GetColumnText(1)
				})
			end
		end
		return self:MakePopup()
	end,
	__base = _base_0,
	__name = "Seqview",
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
Seqview = _class_0
return _class_0
