draw.DrawTextShadow = function(text, font, x, y, col1, col2, align)
	if col1 == nil then
		col1 = Color(200, 200, 200, 255)
	end
	if col2 == nil then
		col2 = Color(0, 0, 0, 255)
	end
	if align == nil then
		align = 0
	end
	if not (align == 0) then
		draw.DrawText(text, font, x + (3 * math.sin(CurTime())) + math.Rand(0.666, -0.666), y + (3 * math.cos(CurTime())) + math.Rand(0.666, -0.666), col2, align)
		return draw.DrawText(text, font, x, y, col1, align)
	else
		local _with_0 = surface
		_with_0.SetFont(font)
		_with_0.SetTextColor(col2)
		_with_0.SetTextPos(x + 1, y + 1)
		_with_0.DrawText(text)
		_with_0.SetTextColor(col1)
		_with_0.SetTextPos(x, y)
		_with_0.DrawText(text)
		return _with_0
	end
end
surface.DrawTexturedRectRotatedPoint = function(x, y, w, h, rot, x0, y0)
	local c = math.cos(math.rad(rot))
	local s = math.sin(math.rad(rot))
	local newx = y0 * s - x0 * c
	local newy = y0 * c + x0 * s
	return surface.DrawTexturedRectRotated(x + newx, y + newy, w, h, rot)
end
util.FormatLine = function(str, font, size)
	if str == nil then
		str = ""
	end
	if string.len(str) == 1 then
		surface.SetFont(font)
		local w, h = surface.GetTextSize(str)
		return str, 0, w, h
	end
	local start = 1
	local c = 1
	surface.SetFont(font)
	local endstr = ""
	local n = 1
	local last_space = 0
	local last_space_made = 0
	local w, h = 0, 0
	while string.len(str) > c do
		local sub = string.sub(str, start, c)
		if string.sub(str, c, c) == " " then
			last_space = c
		end
		local sw, sh = surface.GetTextSize(sub)
		h = sh
		if (sw >= size) and last_space ~= last_space_made then
			local sub2
			if last_space == 0 then
				last_space = c
				last_space_made = c
			end
			if last_space > 1 then
				sub2 = string.sub(str, start, last_space - 1)
				c = last_space
			else
				sub2 = string.sub(str, start, c)
			end
			endstr = endstr .. tostring(sub2) .. "\n"
			last_space = c + 1
			last_space_made = last_space
			start = c + 1
			n = n + 1
		end
		c = c + 1
		if start < string.len(str) then
			endstr = endstr .. string.sub(str, start)
		end
		local _list_0 = string.Explode("\n", endstr)
		for _index_0 = 1, #_list_0 do
			local v = _list_0[_index_0]
			local w2 = surface.GetTextSize(v)
			if w2 > w then
				w = w2
			end
		end
		return endstr, n, w, h * n
	end
end
