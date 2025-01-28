local meta = FindMetaTable('Player')
for k, v in pairs({
	Stuck = function(self)
		local pos = self:GetPos()
		local tr = util.TraceEntity({
			start = pos,
			endpos = pos,
			filter = self,
			mask = MASK_PLAYERSOLID
		}, self)
		return tr.StartSolid
	end,
	WouldNotGetStuckIn = function(self, tile, mins, maxs)
		if not (mins and maxs) then
			mins, maxs = self:GetHull()
		end
		local tr = util.TraceHull({
			start = tile,
			endpos = tile,
			filter = self,
			mask = MASK_PLAYERSOLID,
			mins = mins,
			maxs = maxs
		})
		return (not tr.StartSolid) or (not tr.AllSolid)
	end,
	GetClearPaths = function(self, tiles)
		local pos = self:GetPos()
		local clear_paths = { }
		local filter = player.GetAll()
		local classes = {
			'prop_physics',
			'prop_physics_multiplayer',
			'prop_door_rotating',
			'func_door',
			'func_door_rotating'
		}
		for _index_0 = 1, #classes do
			local cls = classes[_index_0]
			local _list_0 = ents.FindByClass(cls)
			for _index_1 = 1, #_list_0 do
				local ent = _list_0[_index_1]
				filter[#filter + 1] = ent
			end
		end
		for _index_0 = 1, #tiles do
			local tile = tiles[_index_0]
			local tr = util.TraceLine({
				start = pos,
				endpos = tile,
				filter = filter,
				mask = MASK_PLAYERSOLID
			})
			if not tr.Hit and util.IsInWorld(tile) then
				clear_paths[#clear_paths + 1] = tile
			end
		end
		return clear_paths
	end,
	GetSurroundingTiles = function(self, range)
		local pos = self:GetPos()
		local tiles = { }
		local min_bound, max_bound = self:GetHull()
		local check_range = math.max(range, max_bound.x, max_bound.y)
		local coords = {
			0,
			-1,
			1
		}
		for _index_0 = 1, #coords do
			local z = coords[_index_0]
			for _index_1 = 1, #coords do
				local y = coords[_index_1]
				for _index_2 = 1, #coords do
					local x = coords[_index_2]
					local test_tile = Vector(x, y, z)
					test_tile:Mul(check_range)
					tiles[#tiles + 1] = pos + test_tile
				end
			end
		end
		return tiles
	end,
	Unstuck = function(self)
		local ranges = {
			16,
			32,
			64,
			72
		}
		for _index_0 = 1, #ranges do
			local range = ranges[_index_0]
			local surrounding = self:GetSurroundingTiles(range)
			local clear_paths = self:GetClearPaths(surrounding)
			local min_bound, max_bound = self:GetHull()
			for _index_1 = 1, #clear_paths do
				local tile = clear_paths[_index_1]
				if self:WouldNotGetStuckIn(tile, min_bound, max_bound) then
					self:SetPos(tile)
					return true
				end
			end
		end
	end
}) do
	meta[k] = v
end
