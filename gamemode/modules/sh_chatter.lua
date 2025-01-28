local NETMSG_CHATTER, NETMSG_CHAT_SEND, NETMSG_CHAT_RECV
local Speech_Liverish_Deadwood
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = (function()
			local _accum_0 = { }
			local _len_0 = 1
			for i = 1, 21 do
				_accum_0[_len_0] = "dysphoria/vocal/speech/liverish_deadwood" .. tostring(i) .. ".wav"
				_len_0 = _len_0 + 1
			end
			return _accum_0
		end)(),
		pitch = {
			95,
			105
		},
		chan = CHAN_VOICE_BASE
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
		__name = "Speech_Liverish_Deadwood",
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
	Speech_Liverish_Deadwood = _class_0
end
GM.StartChat = function(self)
	return true
end
local chat_keys = {
	KEY_ENTER,
	KEY_CAPSLOCK,
	KEY_BACKSPACE,
	KEY_SPACE,
	KEY_LSHIFT,
	KEY_RSHIFT,
	KEY_LCONTROL,
	KEY_RCONTROL,
	KEY_LALT,
	KEY_RALT,
	KEY_SPACE,
	KEY_COMMA,
	KEY_PERIOD,
	KEY_APOSTROPHE,
	KEY_SEMICOLON,
	KEY_SLASH,
	KEY_EQUAL
}
for i = 1, 36 do
	chat_keys[#chat_keys + 1] = i
end
local chat_key_array = { }
for i = 1, #chat_keys do
	chat_key_array[chat_keys[i]] = true
end
local _anon_func_0 = function(key, self)
	local _check_0 = self.chat_shifts
	for _index_0 = 1, #_check_0 do
		if _check_0[_index_0] == key then
			return true
		end
	end
	return false
end
local Chatter
do
	local _class_0
	local _parent_0 = MODULE
	local _base_0 = {
		chatter_color = Color(0, 200, 0),
		chatter_color_default = Color(0, 200, 0),
		chat_keys = chat_keys,
		chat_key_array = chat_key_array,
		chat_length_limit = 256,
		chat_keys_held = { },
		chat_keys_preheld = { },
		chat_line = '',
		chat_commands = { },
		chat_shifts = {
			KEY_LSHIFT,
			KEY_RSHIFT
		},
		chat_command_shortcuts = {
			[KEY_EQUAL] = "/w",
			[KEY_1] = "/y",
			[KEY_8] = "/me"
		},
		shift_glyphs = {
			[KEY_1] = "!",
			[KEY_2] = " at ",
			[KEY_3] = " number ",
			[KEY_4] = " koins ",
			[KEY_5] = " percent ",
			[KEY_6] = " to the power of ",
			[KEY_7] = " and ",
			[KEY_9] = " -- ",
			[KEY_0] = " -- ",
			[KEY_MINUS] = ", ",
			[KEY_EQUAL] = " plus ",
			[KEY_SEMICOLON] = "... ",
			[KEY_APOSTROPHE] = "\"",
			[KEY_SLASH] = "?",
			[KEY_COMMA] = " lesser than ",
			[KEY_PERIOD] = " greater than "
		},
		swap_glyphs = {
			[KEY_MINUS] = " minus ",
			[KEY_EQUAL] = " equals ",
			[KEY_SLASH] = " or "
		},
		audible_ranges = {
			talking = {
				450,
				150
			},
			yelling = {
				1000,
				800
			},
			whispering = {
				100,
				0
			}
		},
		prompt_icons = {
			speaking = {
				solid = Material("skeleton/icons/prompt/chat.png"),
				lines = Material("skeleton/icons/prompt/chat-outline.png")
			},
			backspace = {
				solid = Material("skeleton/icons/prompt/backspace.png"),
				lines = Material("skeleton/icons/prompt/backspace-outline.png")
			},
			command = {
				solid = Material("skeleton/icons/prompt/terminal.png"),
				lines = Material("skeleton/icons/prompt/terminal-outline.png")
			}
		},
		error_fl = 0,
		jumpy_fl = 0,
		caps_lock = false,
		PlayerBindPress = function(self, ply, bind, down)
			if ply.GetChatting and ply:GetChatting() and input.LookupBinding(bind) then
				local key = input.GetKeyCode(input.LookupBinding(bind))
				if self.chat_key_array[key] then
					return true
				end
			end
		end,
		HUDPaint = function(self)
			if self.error_fl > 0 then
				self.error_fl = math.Approach(self.error_fl, 0, 0.03)
			end
			self.jumpy_fl = Lerp(FrameTime() * 2, self.jumpy_fl, 0)
			local x, y = ScrW() / 2, ScrH() * 0.8
			local c = Color(0, 200, 0)
			local r = c.r - (255 * self.error_fl)
			local g = c.g - (255 * self.error_fl)
			local b = c.b - (255 * self.error_fl)
			local a = 150 + 50 * math.abs(math.sin(CurTime()))
			if LocalPlayer():GetChatting() then
				surface.SetFont("spleen_chat")
				local tw, th = surface.GetTextSize(self.chat_line)
				local icon
				if string.len(self.chat_line) == 0 then
					icon = self.prompt_icons.backspace
				else
					icon = self.prompt_icons.speaking
				end
				surface.SetMaterial(icon.solid)
				surface.SetDrawColor(Color(32, 32, 32, 255))
				local mul = 1 + self.jumpy_fl
				surface.DrawTexturedRectRotatedPoint(x - tw / 2 + math.cos(CurTime() * mul), y + math.sin(CurTime() * mul), 32 + math.sin(CurTime()) * 4, 32 + math.sin(CurTime()) * 4, 0, 16, 16)
				surface.SetMaterial(icon.lines)
				surface.SetDrawColor(Color(r, g, b, a))
				surface.DrawTexturedRectRotatedPoint(x - tw / 2 + math.Rand(0.666, -0.666) * mul, y + math.Rand(0.666, -0.666) * mul, 32 + math.Rand(0.666, -0.666), 32 + math.Rand(0.666, -0.666), 0, 16, 16)
				return draw.DrawTextShadow(self.chat_line, "spleen_chat", x, y, Color(r, g, b, a), Color(0, 0, 0), TEXT_ALIGN_CENTER)
			end
		end,
		ToggleChat = function(self, toggled, keyed)
			local snd = "dysphoria/ui/chatter_" .. tostring(toggled and "enable" or "disable") .. ".ogg"
			LocalPlayer():EmitSound(snd, 75, math.random(95, 105), 0.4)
			self.chat_keys_preheld = { }
			local _list_0 = self.chat_keys
			for _index_0 = 1, #_list_0 do
				local key = _list_0[_index_0]
				if input.IsButtonDown(key) then
					self.chat_keys_preheld[key] = true
				end
			end
			self.caps_lock = false
			if keyed then
				net.Start("NETMSG_CHATTER")
				net.WriteBool(toggled)
				return net.SendToServer()
			end
		end,
		ToggleCapsLock = function(self)
			local snd
			if self.caps_lock then
				snd = "unlock"
			else
				snd = "lock"
			end
			LocalPlayer():EmitSound("dysphoria/ui/chatter_caps" .. tostring(snd) .. ".ogg", 75, math.random(95, 105), 0.4)
			self.caps_lock = not self.caps_lock
		end,
		StringHasCommand = function(self, str)
			local tab = self.chat_commands
			table.sort(tab, function(a, b)
				return string.len(a[1]) > string.len(b[1])
			end)
			if str then
				local first = string.Explode(" ", str)[1]
				if tab[first] then
					return first, tab[first]
				end
			end
			return false
		end,
		ChatInput = function(self, add)
			local new = self.chat_line
			if #add > 1 then
				local firstchar = string.sub(add, 1, 1)
				if string.sub(new, -1, -1) == " " then
					add = string.sub(add, 2)
				end
			end
			new = tostring(new) .. tostring(add)
			if #new > self.chat_length_limit then
				self:ChatError()
				return
			end
			local pitch = 75 + (#new / 5)
			LocalPlayer():EmitSound("dysphoria/ui/chatter_type.ogg", 75, pitch, 0.4)
			self.jumpy_fl = self.jumpy_fl + 0.666
			self.chat_line = new
		end,
		ChatBackspace = function(self)
			if #self.chat_line == 0 then
				if self.chat_command then
					self:ChatClearCommand()
				elseif not self.chat_keys_held[KEY_BACKSPACE] then
					self:ToggleChat(false, true)
				end
				return
			end
			local new = string.sub(self.chat_line, 1, #self.chat_line - 1)
			local pitch = 75 + (#new / 5)
			LocalPlayer():EmitSound("dysphoria/ui/chatter_delete.ogg", 75, pitch, 0.4)
			self.chat_line = new
		end,
		ChatEnter = function(self)
			if #self.chat_line > 0 then
				local nchat = self.chat_line
				if self.chat_command then
					nchat = tostring(self.chat_command) .. " " .. tostring(nchat)
				end
				net.Start("NETMSG_CHAT_SEND")
				net.WriteString(nchat)
				net.SendToServer()
				self:OnChat(LocalPlayer(), nchat)
			else
				self:ToggleChat(false, true)
				return
			end
			self.chat_line = ""
			self.chat_command = ""
			self.chatter_color = self.chatter_color_default
		end,
		ChatClear = function(self, close)
			if close == nil then
				close = true
			end
			self.chat_line = ""
			self.chat_command = nil
			self.chatter_color = self.chatter_color_default
			if close then
				return self:ToggleChat(false, true)
			end
		end,
		ChatClearCommand = function(self)
			self.chatter_color = self.chatter_color_default
			self.chat_command = nil
			return LocalPlayer():EmitSound("dysphoria/ui/chatter_delete.ogg", 75, 100, 0.4)
		end,
		ChatError = function(self)
			LocalPlayer():EmitSound("dysphoria/ui/chatter_limit.ogg", 75, math.random(95, 105), 0.4)
			self.error_fl = 1
		end,
		OnChat = function(self, ply, text, inclself)
			local cc, cctable = self:StringHasCommand(text)
			if cctable then
				if cctable.admin and not ply:IsAdmin() then
					return
				end
				local f = string.Trim(string.sub(text, string.len(cc) + 1))
				local ret = cctable.func(ply, f)
			else
				return self:ChatLocal(ply, text, inclself)
			end
		end,
		GetChatLocation = function(self, ply)
			local rag = ply:GetRagdoll()
			if rag and IsValid(rag) then
				local head_id = rag:LookupBone("ValveBiped.Bip01_Head1")
				if head_id then
					local head_pos, head_ang = rag:GetBonePosition(head_id)
					head_pos = head_pos + head_ang:Forward() * 8
					head_pos = head_pos + head_ang:Right() * 4
					return head_pos
				end
			end
			return ply:EyePos() + ply:GetAimVector() * 12
		end,
		ChatLocal = function(self, ply, arg, inclself)
			if string.len(arg) == 0 then
				return
			end
			if not ply:Alive() then
				return
			end
			if SERVER then
				local rc, rm = unpack(self.audible_ranges.talking)
				local rf = ply:GetRF(rc, rm, inclself)
				net.Start("NETMSG_CHAT_RECV")
				net.WriteEntity(ply)
				net.WriteString(arg)
				net.Send(rf)
				local sequence = table.Random(GESTURES.speak)
				if (CLIENT and IsFirstTimePredicted()) or SERVER then
					ply:Spasm({
						sequence = sequence
					})
					return ply:EmitSound("Speech_Liverish_Deadwood")
				end
			else
				return BUBBLE({
					text = tostring(arg),
					font = "spleen_chat",
					pos = self:GetChatLocation(ply),
					char = ply,
					vol = 0.5,
					move = Vector(0, 0, 0.025),
					speed = 2.5,
					lifespan = 14,
					clingy = true
				})
			end
		end,
		Think = function(self)
			if not CLIENT then
				return
			end
			local ply = LocalPlayer()
			if ply.GetChatting and ply:GetChatting() then
				if gui.IsConsoleVisible() or gui.IsGameUIVisible() then
					return
				end
				local shift = false
				local _list_0 = self.chat_keys
				for _index_0 = 1, #_list_0 do
					local key = _list_0[_index_0]
					local _continue_0 = false
					repeat
						if (not self.chat_keys_preheld[key]) and input.IsButtonDown(key) then
							if _anon_func_0(key, self) then
								shift = true
								_continue_0 = true
								break
							end
							if (not self.chat_keys_held[key]) or CurTime() >= self.chat_keys_held[key] then
								if KEY_ENTER == key then
									if string.sub(self.chat_line, -1, -1) == "/" then
										self:ChatClear()
									else
										self:ChatEnter()
									end
								elseif KEY_SPACE == key then
									if (#self.chat_line == 0) or (string.sub(self.chat_line, -1, -1) == " ") then
										if #self.chat_line == 0 then
											self:ChatClear()
										else
											self:ChatError()
										end
									else
										self:ChatInput(" ")
									end
								elseif KEY_BACKSPACE == key then
									if (#self.chat_line == 0) and (self.chat_command) then
										self:ChatClearCommand()
									else
										self:ChatBackspace()
									end
								elseif KEY_CAPSLOCK == key then
									self:ToggleCapsLock()
								else
									if shift and (self.chat_command_shortcuts[key] or self.shift_glyphs[key]) then
										local glyph
										if self.shift_glyphs[key] and (#self.chat_line > 0 or not self.chat_command_shortcuts[key]) then
											glyph = self.shift_glyphs[key]
											if self.caps_lock then
												glyph = string.upper(glyph)
											end
										end
										if (not glyph) and #self.chat_line == 0 and self.chat_command_shortcuts[key] then
											glyph = tostring(self.chat_command_shortcuts[key]) .. " "
										end
										if glyph then
											self:ChatInput(glyph)
										else
											self:ChatError()
										end
									elseif self.swap_glyphs[key] and (key ~= KEY_SLASH or #self.chat_line > 0) then
										local glyph = self.swap_glyphs[key]
										if shift or self.caps_lock then
											glyph = string.upper(glyph)
										end
										if (not shift) and (key == KEY_SLASH) then
											self:ChatClear()
											return
										end
										self:ChatInput(glyph)
									else
										local glyph = input.GetKeyName(key)
										if #glyph == 1 then
											if shift or self.caps_lock then
												glyph = string.upper(glyph)
											end
											self:ChatInput(glyph)
										end
									end
								end
								if not self.chat_keys_held[key] then
									self.chat_keys_held[key] = CurTime() + 0.5
								elseif CurTime() >= self.chat_keys_held[key] then
									self.chat_keys_held[key] = CurTime() + 0.02
								end
							end
						elseif self.chat_keys_held[key] then
							self.chat_keys_held[key] = nil
						elseif self.chat_keys_preheld[key] and not input.IsButtonDown(key) then
							self.chat_keys_preheld[key] = nil
						end
						_continue_0 = true
					until true
					if not _continue_0 then
						break
					end
				end
			elseif #table.GetKeys(self.chat_keys_held) > 0 then
				self.chat_keys_held = { }
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
		__name = "Chatter",
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
	Chatter = _class_0
end
BIND('toggle_chat', KEY_Y, {
	Press = function(self, ply)
		if ply.GetChatting and not ply:GetChatting() then
			if SERVER then
				ply:SetChatting(true)
				net.Start("NETMSG_CHATTER")
				net.WriteBool(true)
				return net.Send(ply)
			end
		end
	end
})
if SERVER then
	local _list_0 = {
		"NETMSG_CHATTER",
		"NETMSG_CHAT_RECV",
		"NETMSG_CHAT_SEND"
	}
	for _index_0 = 1, #_list_0 do
		local netmsg = _list_0[_index_0]
		util.AddNetworkString(netmsg)
	end
	net.Receive("NETMSG_CHATTER", function(len, ply)
		local toggled = net.ReadBool()
		return ply:SetChatting(toggled)
	end)
	return net.Receive("NETMSG_CHAT_SEND", function(len, ply)
		local msg = net.ReadString()
		ply:SetChatting(false)
		ply.last_chat = ply.last_chat or 0
		if CurTime() - ply.last_chat < 0.05 then
			return
		end
		ply.last_chat = CurTime()
		if string.len(msg) > Chatter.chat_length_limit then
			return
		end
		return Chatter:OnChat(ply, msg)
	end)
elseif CLIENT then
	net.Receive("NETMSG_CHATTER", function(len)
		local toggled = net.ReadBool()
		return Chatter:ToggleChat(toggled)
	end)
	return net.Receive("NETMSG_CHAT_RECV", function(len)
		local who = net.ReadEntity()
		local str = net.ReadString()
		local cc = net.ReadString()
		if #cc > 0 and Chatter.chat_commands[cc] then
			local com = Chatter.chat_commands[cc]
			if com.admin and not LocalPlayer():IsAdmin() then
				return
			end
		else
			return Chatter:OnChat(who, str)
		end
	end)
end
