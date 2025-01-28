local _class_0
local _base_0 = {
	text = "",
	font = "spleen_chat",
	confont = "spleen_chat_small",
	color = Color(0, 0, 0, 228),
	max_alpha = 168,
	text_color = Color(128, 128, 0),
	text_max_alpha = 255,
	margin = 4,
	growth = 0,
	lifespan = 25,
	clingy = false,
	alive = true,
	auditory = true,
	vol = 1,
	sndlvl = 66,
	speed = 2.5,
	move = Vector(0, 0, 0.025),
	char = NULL,
	Kill = function(self)
		self.death_time = CurTime()
		self.alive = false
	end,
	Remove = function(self)
		if BUBBLE.bubbles[self.id] and BUBBLE.bubbles[self.id] == self then
			BUBBLE.bubbles[self.id] = nil
		end
	end,
	Update = function(self)
		local ply = LocalPlayer()
		if ply.tinnitus_until and self.auditory then
			if CurTime() < ply.tinnitus_until then
				self:Remove()
			end
		end
		if self.move then
			self.pos = self.pos + self.move
		end
		if self.alive then
			self.growth = Lerp(0.2 * self.speed * FrameTime() * 3, self.growth, 1)
			self.color.a = self.max_alpha * self.growth
			self.text_color.a = self.text_max_alpha * self.growth
			if CurTime() >= (self.birth_time + self.lifespan) and (self.growth >= 0.95) and (not self.death_time) then
				return self:Kill()
			end
		else
			self.growth = Lerp(0.1 * self.speed * FrameTime() * 4, self.growth, 0)
			self.color.a = self.max_alpha * self.growth
			self.text_color.a = self.text_max_alpha * self.growth
			if self.growth < 0.01 then
				return self:Remove()
			end
		end
	end
}
if _base_0.__index == nil then
	_base_0.__index = _base_0
end
_class_0 = setmetatable({
	__init = function(self, spec)
		if spec == nil then
			spec = { }
		end
		for k, v in pairs(spec) do
			self[k] = v
		end
		self.id = self.__class.index
		self.birth_time = CurTime()
		self.__class.index = self.__class.index + 1
		self.__class.bubbles[self.id] = self
	end,
	__base = _base_0,
	__name = "BUBBLE"
}, {
	__index = _base_0,
	__call = function(cls, ...)
		local _self_0 = setmetatable({ }, _base_0)
		cls.__init(_self_0, ...)
		return _self_0
	end
})
_base_0.__class = _class_0
local self = _class_0;
self.bubbles = { }
self.index = 0
self.Draw = function(self)
	local sin = math.sin(CurTime())
	local valids = { }
	for id, b in pairs(self.bubbles) do
		b:Update()
		local xwave = (1 - (b.growth)) * (math.sin(CurTime() * 3) * 30) * 2
		if not b.glyph_count then
			b.glyph_count = 0
			b.next_glyph = 0
		end
		b.next_glyph = math.Approach(b.next_glyph, #b.text, 0.12 * b.speed)
		if (math.floor(b.next_glyph) ~= b.glyph_count) then
			b.glyph_count = math.floor(b.next_glyph)
			local glyph = string.sub(b.text, b.glyph_count, b.glyph_count)
			if (not b.sndlvl or b.sndlvl > 0) and glyph ~= "\"" and b.char and (b.glyph_count % 4 == 0) and b.char:IsValid() then
				b.char:EmitSound("Speech_Liverish_Deadwood")
			end
		end
		local text = string.sub(b.text, 0, b.glyph_count)
		text = text or " "
		local lines, bw, bh
		text, lines, bw, bh = util.FormatLine(text, b.font, ScrW() * 0.2)
		text = string.stutter(text, b.stutters, b.stutter_chance)
		bw = bw or 0
		bh = bh or 0
		local bx, by = 0, 0
		local toscreen
		if not (b.who or IsValid(b.who)) then
			b.who = b.char
		end
		local our_text = b.who == LocalPlayer()
		b.y = b.y or 0
		b.y = b.y - 0.25
		if our_text then
			b.clingy = false
			b.color = COLOR_DGRAY
			toscreen = {
				x = ScrW() / 2,
				y = ScrH() / 3 + b.y,
				visible = true
			}
		else
			if b.who and IsValid(b.who) then
				if b.who:IsPlayer() then
					toscreen = b.who:EyePos() + Vector(0, 0, 16)
				else
					toscreen = b.who:GetPos() + Vector(0, 0, 8)
				end
			else
				toscreen = b.pos
			end
			toscreen = toscreen:ToScreen()
			toscreen.y = toscreen.y + b.y
		end
		if not b.clingy then
			if toscreen.visible then
				bx, by = toscreen.x, toscreen.y
			else
				bx, by = ScrW(), ScrH()
			end
		else
			if toscreen.x + (bx - bw / 2) > ScrW() * 0.9 then
				bx = ScrW() * 0.9 - bw / 2
			elseif toscreen.x < ScrW() * 0.1 then
				bx = bw / 2 + ScrW() * 0.1
			else
				bx = toscreen.x
			end
			if toscreen.y + bh > ScrH() * 0.9 then
				by = ScrH() * 0.9 - bh
			elseif toscreen.y < ScrH() * 0.1 then
				by = ScrH() * 0.1
			else
				by = toscreen.y
			end
		end
		draw.RoundedBox(8, bx - bw / 2, by, bw, bh, b.color)
		if text and string.len(text) > 0 then
			draw.DrawTextShadow(text, b.font, bx + xwave, by, b.text_color, Color(0, 0, 0, b.text_color.a), TEXT_ALIGN_CENTER)
		end
	end
end
BUBBLE = _class_0
