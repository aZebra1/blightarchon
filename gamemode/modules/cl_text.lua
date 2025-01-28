local ceil, maxWidth = math.ceil, math.maxWidth
local SetFont, GetTextSize, SetTextPos, SetTextColor, DrawText = surface.SetFont, surface.GetTextSize, surface.SetTextPos, surface.SetTextColor, surface.DrawText
local find, gmatch, left, sub = string.find, string.gmatch, string.left, string.sub
local char_wrap
char_wrap = function(text, width_left, max_width)
	local total_width = 0
	text = text:gsub('.', function(char)
		total_width = total_width + GetTextSize(char)
		if total_width >= width_left then
			total_width = GetTextSize(char)
			width_left = max_width
			return "\n" .. tostring(char)
		end
		return char
	end)
	return text, total_width
end
local wrap_cache = { }
local ellipse_cache = { }
TEXT = {
	DrawSimple = function(text, font, x, y, col, x_align, y_align)
		SetFont(font)
		local w, h = GetTextSize(text)
		if TEXT_ALIGN_CENTER == x_align then
			x = x - (w / 2)
		elseif TEXT_ALIGN_RIGHT == x_align then
			x = x - w
		end
		if TEXT_ALIGN_CENTER == y_align then
			y = y - (h / 2)
		elseif TEXT_ALIGN_BOTTOM == y_align then
			y = y - h
		end
		SetTextPos(ceil(x), ceil(y))
		local r, g, b, a = col.r, col.g, col.b, col.a
		SetTextColor(r, g, b, a)
		DrawText(text)
		return w, h
	end,
	Draw = function(text, font, x, y, col, x_align, y_align)
		local cur_x, cur_y = x, y
		SetFont(font)
		local line_height = select(2, GetTextSize('\n'))
		local tab_width = 50
		for str in gmatch(text, '[^\n]*') do
			if #str > 0 then
				if find(str, '\t') then
					for tabs, str2 in gmatch(str, '(\t*)([^\t]*)') do
						cur_x = ceil((cur_x + tab_width * max(#tabs - 1, 0)) / tab_width) * tab_width
						if #str2 > 0 then
							TEXT.DrawSimple(str2, font, cur_x, cur_y, col, x_align)
							cur_x = cur_x + GetTextSize(str2)
						end
					end
				else
					TEXT.DrawSimple(str, font, cur_x, cur_y, col, x_align)
				end
			else
				cur_x = x
				cur_y = cur_y + (line_height / 2)
			end
		end
	end,
	Shadow = function(text, font, x, y, col, x_align, y_align, depth, shadow)
		if shadow == nil then
			shadow = 50
		end
		for i = 1, depth do
			TEXT.DrawSimple(text, font, x + i, y + i, Color(0, 0, 0, i * shadow), x_align, y_align)
		end
		return TEXT.DrawSimple(text, font, x, y, col, x_align, y_align)
	end,
	Dual = function(title, subtitle, x, y)
		if x == nil then
			x = 0
		end
		if y == nil then
			y = 0
		end
		SetFont(title[2])
		local th = select(2, GetTextSize(title[1]))
		SetFont(subtitle[2])
		local sh = select(2, GetTextSize(subtitle[1]))
		TEXT.Shadow(title[1], title[2], x, y - sh / 2, title[3], title[4], TEXT_ALIGN_CENTER, title[5], title[6])
		return TEXT.Shadow(subtitle[1], subtitle[2], x, y - th / 2, subtitle[3], subtitle[4], TEXT_ALIGN_CENTER, subtitle[5], subtitle[6])
	end,
	Wrap = function(text, width, font)
		local cached = tostring(text) .. tostring(width) .. tostring(font)
		if wrap_cache[cached] then
			return wrap_cache[cached]
		end
		SetFont(font)
		local tw = GetTextSize(text)
		if tw <= width then
			wrap_cache[cached] = text
			return text
		end
		local total_width = 0
		local space_width = GetTextSize(' ')
		text = text:gsub('(%s?[%S]+)', function(word)
			local char = sub(word, 1, 1)
			if ('\n' == char or '\t' == char) then
				total_width = 0
			end
			local wordlen = GetTextSize(word)
			total_width = total_width + wordlen
			if wordlen then
				local split_word, split_point = char_wrap(word, width - (total_width - wordlen), width)
				total_width = split_point
				return split_word
			elseif total_width < width then
				return word
			end
			if char == ' ' then
				total_width = wordlen - space_width
				return "\n" .. tostring(sub(word, 2))
			end
			total_width = wordlen
			return "\n" .. tostring(word)
		end)
		wrap_cache[cached] = text
		return text
	end,
	Ellipses = function(text, width, font)
		local cached = tostring(text) .. tostring(width) .. tostring(font)
		if ellipse_cache[cached] then
			return ellipse_cache[cached]
		end
		SetFont(font)
		local tw = GetTextSize(text)
		if tw <= width then
			ellipse_cache[cached] = text
			return text
		end
		local inf_loop_prevent = 0
		while true do
			text = left(text, #text - 1)
			local text_width = GetTextSize(tostring(text) .. "...")
			inf_loop_prevent = inf_loop_prevent + 1
			if text_width <= width or inf_loop_prevent > 10000 then
				break
			end
		end
		text = text .. '...'
		ellipse_cache[cached] = text
		return text
	end
}
