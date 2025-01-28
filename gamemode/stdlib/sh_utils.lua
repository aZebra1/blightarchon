function Lighten( col, amt, a )
	if( amt == 0 ) then
		return col
	end
	local c = table.Copy( col )
	c.r = Lerp( amt, c.r, 255 )
	c.g = Lerp( amt, c.g, 255 )
	c.b = Lerp( amt, c.b, 255 )
	if( a ) then
		c.a = Lerp( amt, c.a, 0 )
	end
	return c
end

function Darken( col, amt, a )
	if( amt == 0 ) then
		return col
	end
	local c = table.Copy( col )
	c.r = Lerp( amt, c.r, 0 )
	c.g = Lerp( amt, c.g, 0 )
	c.b = Lerp( amt, c.b, 0 )
	if( a ) then
		c.a = Lerp( amt, c.a, 255 )
	end
	return c
end

function Alpha( col, a )
	local c = table.Copy( col )
	c.a = c.a * ( a / 255 )
	return c
end

