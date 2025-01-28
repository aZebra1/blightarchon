if SERVER then
	util.AddNetworkString("SendNotification")

	-- Function to send a notification to a specific player
	function SendNotification(ply, text, color)
    	net.Start("SendNotification")
    	net.WriteString(text)
    	net.WriteColor(color or Color(0, 255, 0))
    	net.Send(ply)
	end
end

local max = math.max
local Xombokom
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = (function()
			local _accum_0 = { }
			local _len_0 = 1
			for i = 1, 15 do
				_accum_0[_len_0] = "placenta/speech/chatter" .. tostring(i) .. ".ogg"
				_len_0 = _len_0 + 1
			end
			return _accum_0
		end)(),
		pitch = {
			115,
			135
		},
		level = SNDLVL_RADIO
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
		__name = "Xombokom",
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
	Xombokom = _class_0
end
local XombokomBroken
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = (function()
			local _accum_0 = { }
			local _len_0 = 1
			for i = 1, 3 do
				_accum_0[_len_0] = "placenta/radiokom" .. tostring(i) .. ".wav"
				_len_0 = _len_0 + 1
			end
			return _accum_0
		end)(),
		pitch = {
			115,
			135
		},
		level = SNDLVL_RADIO
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
		__name = "XombokomBroken",
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
	XombokomBroken = _class_0
end
local RadioSmack
do
	local _class_0
	local _parent_0 = SOUND
	local _base_0 = {
		sound = (function()
			local _accum_0 = { }
			local _len_0 = 1
			for i = 1, 15 do
				_accum_0[_len_0] = "ambient/levels/prison/radio_random" .. tostring(i) .. ".wav"
				_len_0 = _len_0 + 1
			end
			return _accum_0
		end)(),
		pitch = {
			115,
			135
		},
		level = SNDLVL_RADIO
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
		__name = "RadioSmack",
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
	RadioSmack = _class_0
end
local Machine
do
	local _class_0
	local _parent_0 = NONPICKUP
	local _base_0 = {
		IName = 'machine',
		Model = 'models/props_interiors/VendingMachineSoda01a.mdl',
		Spawnable = true,
		SizeClass = SIZE_IMMOBILE,
		Durability = 200,
		Radius = 2048,
		Damage = 666,
		Detonate = function(self)
			local pos = self:WorldSpaceCenter()
			util.ScreenShake(pos, 25, 150, 1, self.Radius)
			do
				local _with_0 = ents.Create('env_explosion')
				_with_0:SetOwner(self:GetOwner())
				_with_0:SetPos(pos)
				_with_0:SetKeyValue('iMagnitude', self.Damage)
				_with_0:SetKeyValue('iRadiusOverride', self.Radius)
				_with_0:Spawn()
				_with_0:Activate()
				_with_0:Fire('Explode')
			end
			return self:Remove()
		end,
		OnTakeDamage = function(self, dmg)
			if dmg:IsDamageType(DMG_CRUSH) then
				return
			end
			self.Durability = self.Durability - dmg:GetDamage()
			self.Durability = max(self.Durability, 0)
			if self.Durability <= 0 then
				return self:Detonate()
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
		__name = "Machine",
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
	Machine = _class_0
end
-- start ----------------------------------------------------------------------------------------------------------------------
local FleshGrinder
do
	local _class_0
	local _parent_0 = NONPICKUP
	local _base_0 = {
		IName = 'flesh.grinder - closest fucklet gets the flesh',
		Model = 'models/props_wasteland/laundry_dryer002.mdl',
		Spawnable = true,
		SizeClass = SIZE_IMMOBILE,
		Durability = 200,
		Radius = 2048,
		Damage = 666,
		Detonate = function(self)
			local pos = self:WorldSpaceCenter()
			util.ScreenShake(pos, 25, 150, 1, self.Radius)
			do
				local _with_0 = ents.Create('env_explosion')
				_with_0:SetOwner(self:GetOwner())
				_with_0:SetPos(pos)
				_with_0:SetKeyValue('iMagnitude', self.Damage)
				_with_0:SetKeyValue('iRadiusOverride', self.Radius)
				_with_0:Spawn()
				_with_0:Activate()
				_with_0:Fire('Explode')
			end
			return self:Remove()
		end,
		OnTakeDamage = function(self, dmg)
			if dmg:IsDamageType(DMG_CRUSH) then
				return
			end
			self.Durability = self.Durability - dmg:GetDamage()
			self.Durability = math.max(self.Durability, 0)
			if self.Durability <= 0 then
				return self:Detonate()
			end
		end,

		Touch = function(self, other)
			-- Check if the grinder is currently busy
			if self.isBusy then
				return -- If busy, ignore any new ragdolls
			end
		
			-- Check if the object is a ragdoll
			if other:IsRagdoll() then
				-- Set the grinder as busy
				self.isBusy = true
		
				-- Play a sound when the ragdoll touches the flesh grinder
				self:EmitSound("ambient/misc/flush1.wav") -- Replace with your desired sound
		
				-- Destroy the ragdoll
				other:Remove()
		
				-- Play the spin sound when cleaning starts
				self:EmitSound("ambient/machines/spin_loop.wav", 75, 100, 1, CHAN_STATIC)
				
				-- Set flags for cleaning state
				self.isCleaning = true
				self.isCleaningStart = true
		
				-- Start a timer to spawn the new entity after 10 seconds
				timer.Create("SpawnEntityTimer_" .. self:EntIndex(), 20, 1, function()
					-- Spawn a new entity at the grinder's position
					local spawnEntity = ents.Create("thing/food/meat/gore/char") -- Replace with the class name of the entity to spawn
					if IsValid(spawnEntity) then
						spawnEntity:SetPos(self:GetPos() + self:GetForward() * 50)
						spawnEntity:Spawn()
					end
		
					-- Stop sounds and reset cleaning state
					self:StopSound("ambient/machines/spin_loop.wav")
					self.isCleaning = false
					self.isCleaningStart = false
		
					-- Set the grinder as not busy
					self.isBusy = false
				end)
			
				-- Find the nearest player to the Flesh Grinder
				local pos = self:GetPos()
				local nearestPlayer = nil
				local nearestDistance = math.huge
		
				for _, ply in ipairs(player.GetAll()) do
					if IsValid(ply) and ply:Alive() then
						local dist = pos:DistToSqr(ply:GetPos()) -- Use squared distance for efficiency
						if dist < nearestDistance then
							nearestDistance = dist
							nearestPlayer = ply
						end
					end
				end
				
				local reward = math.random(1, 3)
				-- Reward the nearest player with 5 coins
				if IsValid(nearestPlayer) then
					nearestPlayer.Currency = (nearestPlayer.Currency or 0) + reward
					-- Update the player's currency on the client
					net.Start("UpdateCurrency")
					net.WriteInt(nearestPlayer.Currency, 32)
					net.Send(nearestPlayer)
				end
				SendNotification(nearestPlayer, "> money.awarded.for.corpse=".. reward, Color(0, 255, 0))
			end
		end
	}

	-- Set up the base class and metatables
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
		__name = "flesh.grinder",
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
			local _self_0 = setmetatable({}, _base_0)
			cls.__init(_self_0, ...)
			return _self_0
		end
	})
	_base_0.__class = _class_0
	if _parent_0.__inherited then
		_parent_0.__inherited(_parent_0, _class_0)
	end
	FleshGrinder = _class_0
end

local RotPurifier
do
	local _class_0
	local _parent_0 = NONPICKUP
	local _base_0 = {
		IName = 'rot.purifier - fucklet purifier',
		Model = 'models/props_wasteland/laundry_washer003.mdl',
		Spawnable = true,
		SizeClass = SIZE_IMMOBILE,
		Durability = 200,
		Radius = 2048,
		Damage = 666,
		Detonate = function(self)
			local pos = self:WorldSpaceCenter()
			util.ScreenShake(pos, 25, 150, 1, self.Radius)
			do
				local _with_0 = ents.Create('env_explosion')
				_with_0:SetOwner(self:GetOwner())
				_with_0:SetPos(pos)
				_with_0:SetKeyValue('iMagnitude', self.Damage)
				_with_0:SetKeyValue('iRadiusOverride', self.Radius)
				_with_0:Spawn()
				_with_0:Activate()
				_with_0:Fire('Explode')
			end
			return self:Remove()
		end,
		OnTakeDamage = function(self, dmg)
			if dmg:IsDamageType(DMG_CRUSH) then
				return
			end
			self.Durability = self.Durability - dmg:GetDamage()
			self.Durability = max(self.Durability, 0)
			if self.Durability <= 0 then
				return self:Detonate()
			end
		end,
		

		Touch = function(self, other)
			if self.isBusy then
				return -- If busy, ignore any new entities
			end
		
			-- List of allowed entities
			local FoodWaterEnts = {
				"thing/food/meat/gore/char",
				"thing/food/meat/gore",
				"thing/food/purified.water",
				"thing/food/dirty.water",
				"thing/food/meat/blood.clot",
				"thing/food/meat"
			}
		
			-- Check if the entity is in the allowed list
			if not table.HasValue(FoodWaterEnts, other:GetClass()) then
				return
			end
		
			self.isBusy = true
			self:EmitSound("ambient/machines/sputter1.wav") -- Play sound when touched
		
			-- Remove the entity
			other:Remove()
		
			-- Play the spin sound while processing
			self:EmitSound("ambient/machines/spin_loop.wav", 75, 100, 1, CHAN_STATIC)
		
			-- Determine the resulting entity based on the class of the input entity
			local spawnEntityClass
			local spawnEntityClass2
			if other:GetClass() == "thing/food/purified.water" then
				spawnEntityClass = "thing/food/distilled.vodka" -- Purified Water → Distilled Vodka
			elseif other:GetClass() == "thing/food/meat/gore/char" or other:GetClass() == "thing/food/meat/gore" then
				spawnEntityClass = "thing/food/meat" -- Human Meat → Rotten Meat
			elseif other:GetClass() == "thing/food/dirty.water" then
				spawnEntityClass = "thing/food/purified.water" -- Dirty Water → Purified Water
			elseif other:GetClass() == "thing/food/meat/blood.clot" then
				spawnEntityClass = "thing/food/dirty.water" -- Blood Clot → Dirty Water
			elseif other:GetClass() == "thing/food/meat" then
				spawnEntityClass = "thing/food/meat/human.sausage" -- Rotten Meat → Rotten Human Sausage
			end
		
			-- Spawn the resulting entity after a delay
			if spawnEntityClass then
				timer.Create("SpawnEntityTimer_" .. self:EntIndex(), 10, 1, function()
					local spawnEntity = ents.Create(spawnEntityClass)
					if IsValid(spawnEntity) then
						spawnEntity:SetPos(self:GetPos() + self:GetRight() * -50)
						spawnEntity:Spawn()
					end
		
					-- Stop the spin sound and reset the busy state
					self:StopSound("ambient/machines/spin_loop.wav")
					self.isBusy = false
				end)
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
		__name = "rot.purifier",
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
	RotPurifier = _class_0
end

local RotStove
do
	local _class_0
	local _parent_0 = NONPICKUP
	local _base_0 = {
		IName = 'rot.stove - fucklet cooker',
		Model = 'models/props_wasteland/kitchen_stove001a.mdl',
		Spawnable = true,
		SizeClass = SIZE_IMMOBILE,
		Durability = 200,
		Radius = 2048,
		Damage = 666,
		Detonate = function(self)
			local pos = self:WorldSpaceCenter()
			util.ScreenShake(pos, 25, 150, 1, self.Radius)
			do
				local _with_0 = ents.Create('env_explosion')
				_with_0:SetOwner(self:GetOwner())
				_with_0:SetPos(pos)
				_with_0:SetKeyValue('iMagnitude', self.Damage)
				_with_0:SetKeyValue('iRadiusOverride', self.Radius)
				_with_0:Spawn()
				_with_0:Activate()
				_with_0:Fire('Explode')
			end
			return self:Remove()
		end,
		OnTakeDamage = function(self, dmg)
			if dmg:IsDamageType(DMG_CRUSH) then
				return
			end
			self.Durability = self.Durability - dmg:GetDamage()
			self.Durability = max(self.Durability, 0)
			if self.Durability <= 0 then
				return self:Detonate()
			end
		end,
		

		Touch = function(self, other)
			if self.isBusy then
				return -- If busy, ignore any new entities
			end
		
			-- List of allowed entities
			local FoodWaterEnts = {
				"thing/food/meat/human.sausage"
			}
		
			-- Check if the entity is in the allowed list
			if not table.HasValue(FoodWaterEnts, other:GetClass()) then
				return
			end
		
			self.isBusy = true
			self:EmitSound("ambient/gas/steam2.wav") -- Play sound when touched
		
			-- Remove the entity
			other:Remove()
		
			-- Play the spin sound while processing
			self:EmitSound("ambient/machines/diesel_engine_idle1.wav", 75, 100, 1, CHAN_STATIC)
		
			-- Determine the resulting entity based on the class of the input entity
			local spawnEntityClass
			local spawnEntityClass2
			if other:GetClass() == "thing/food/meat/human.sausage" then
				spawnEntityClass = "thing/food/meat/human.sausage.bread" -- Purified Water → Distilled Vodka
			--[[elseif other:GetClass() == "thing/food/meat/gore/char" or other:GetClass() == "thing/food/meat/gore" then
				spawnEntityClass = "thing/food/meat" -- Human Meat → Rotten Meat
			elseif other:GetClass() == "thing/food/dirty.water" then
				spawnEntityClass = "thing/food/purified.water" -- Dirty Water → Purified Water
			elseif other:GetClass() == "thing/food/meat/blood.clot" then
				spawnEntityClass = "thing/food/dirty.water" -- Blood Clot → Dirty Water
			elseif other:GetClass() == "thing/food/meat" then
				spawnEntityClass = "thing/food/meat/human.sausage" -- Rotten Meat → Rotten Human Sausage]]--
			end
		
			-- Spawn the resulting entity after a delay
			if spawnEntityClass then
				timer.Create("SpawnEntityTimer_" .. self:EntIndex(), 15, 1, function()
					local spawnEntity = ents.Create(spawnEntityClass)
					if IsValid(spawnEntity) then
						spawnEntity:SetPos(self:GetPos() + self:GetForward() * 50)
						spawnEntity:Spawn()
					end
		
					-- Stop the spin sound and reset the busy state
					self:StopSound("ambient/machines/diesel_engine_idle1.wav")
					self:StopSound("ambient/gas/steam2.wav")
					self.isBusy = false
				end)
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
		__name = "rot.stove",
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
	RotStove = _class_0
end

local RockWash
do
	local _class_0
	local _parent_0 = NONPICKUP
	local _base_0 = {
		IName = 'rot.rockwash - a fucking rock washer',
		Model = 'models/props_wasteland/laundry_washer001a.mdl',
		Spawnable = true,
		SizeClass = SIZE_IMMOBILE,
		Durability = 200,
		Radius = 2048,
		Damage = 666,
		Detonate = function(self)
			local pos = self:WorldSpaceCenter()
			util.ScreenShake(pos, 25, 150, 1, self.Radius)
			do
				local _with_0 = ents.Create('env_explosion')
				_with_0:SetOwner(self:GetOwner())
				_with_0:SetPos(pos)
				_with_0:SetKeyValue('iMagnitude', self.Damage)
				_with_0:SetKeyValue('iRadiusOverride', self.Radius)
				_with_0:Spawn()
				_with_0:Activate()
				_with_0:Fire('Explode')
			end
			return self:Remove()
		end,
		OnTakeDamage = function(self, dmg)
			if dmg:IsDamageType(DMG_CRUSH) then
				return
			end
			self.Durability = self.Durability - dmg:GetDamage()
			self.Durability = max(self.Durability, 0)
			if self.Durability <= 0 then
				return self:Detonate()
			end
		end,
		

		Touch = function(self, other)
			if self.isBusy then
				return -- If busy, ignore any new entities
			end
		
			-- List of allowed entities
			local RockEnts = {
				"thing/junk/rock"
			}
		
			-- Check if the entity is in the allowed list
			if not table.HasValue(RockEnts, other:GetClass()) then
				return
			end
		
			self.isBusy = true
			self:EmitSound("ambient/machines/sputter1.wav") -- Play sound when touched
		
			-- Remove the entity
			other:Remove()
		
			-- Play the spin sound while processing
			self:EmitSound("ambient/machines/engine4.wav", 75, 100, 1, CHAN_STATIC)
		
			-- Determine the resulting entity based on the class of the input entity
			local spawnEntityClass
			local spawnEntityClass2
			if other:GetClass() == "thing/junk/rock" then
				spawnEntityClass = "thing/junk/rock.ore" -- Purified Water → Distilled Vodka
			--[[elseif other:GetClass() == "thing/food/meat/gore/char" or other:GetClass() == "thing/food/meat/gore" then
				spawnEntityClass = "thing/food/meat" -- Human Meat → Rotten Meat
			elseif other:GetClass() == "thing/food/dirty.water" then
				spawnEntityClass = "thing/food/purified.water" -- Dirty Water → Purified Water
			elseif other:GetClass() == "thing/food/meat/blood.clot" then
				spawnEntityClass = "thing/food/dirty.water" -- Blood Clot → Dirty Water
			elseif other:GetClass() == "thing/food/meat" then
				spawnEntityClass = "thing/food/meat/human.sausage" -- Rotten Meat → Rotten Human Sausage]]--
			end
		
			-- Spawn the resulting entity after a delay
			if spawnEntityClass then
				timer.Create("SpawnEntityTimer_" .. self:EntIndex(), 15, 1, function()
					local spawnEntity = ents.Create(spawnEntityClass)
					if IsValid(spawnEntity) then
						spawnEntity:SetPos(self:GetPos() + self:GetRight() * 50)
						spawnEntity:Spawn()
					end
		
					-- Stop the spin sound and reset the busy state
					self:StopSound("ambient/machines/engine4.wav")
					self.isBusy = false
				end)
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
		__name = "rot.rockwash",
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
	RockWash = _class_0
end

local OreRefiner
do
	local _class_0
	local _parent_0 = NONPICKUP
	local _base_0 = {
		IName = 'rot.orerefinery - a fucking ore refinery',
		Model = 'models/props_c17/FurnitureWashingmachine001a.mdl',
		Spawnable = true,
		SizeClass = SIZE_IMMOBILE,
		Durability = 200,
		Radius = 2048,
		Damage = 666,
		Detonate = function(self)
			local pos = self:WorldSpaceCenter()
			util.ScreenShake(pos, 25, 150, 1, self.Radius)
			do
				local _with_0 = ents.Create('env_explosion')
				_with_0:SetOwner(self:GetOwner())
				_with_0:SetPos(pos)
				_with_0:SetKeyValue('iMagnitude', self.Damage)
				_with_0:SetKeyValue('iRadiusOverride', self.Radius)
				_with_0:Spawn()
				_with_0:Activate()
				_with_0:Fire('Explode')
			end
			return self:Remove()
		end,
		OnTakeDamage = function(self, dmg)
			if dmg:IsDamageType(DMG_CRUSH) then
				return
			end
			self.Durability = self.Durability - dmg:GetDamage()
			self.Durability = max(self.Durability, 0)
			if self.Durability <= 0 then
				return self:Detonate()
			end
		end,
		

		Touch = function(self, other)
			if self.isBusy then
				return -- If busy, ignore any new entities
			end
		
			-- List of allowed entities
			local RockEnts = {
				"thing/junk/rock.ore"
			}
		
			-- Check if the entity is in the allowed list
			if not table.HasValue(RockEnts, other:GetClass()) then
				return
			end
		
			self.isBusy = true
			self:EmitSound("ambient/machines/sputter1.wav") -- Play sound when touched
		
			-- Remove the entity
			other:Remove()
		
			-- Play the spin sound while processing
			self:EmitSound("ambient/machines/engine1.wav", 75, 100, 1, CHAN_STATIC)
		
			-- Determine the resulting entity based on the class of the input entity
			local spawnEntityClass
			local spawnEntityClass2
			if other:GetClass() == "thing/junk/rock.ore" then
				spawnEntityClass = "thing/junk/scrap.metal" -- Purified Water → Distilled Vodka
			--[[elseif other:GetClass() == "thing/food/meat/gore/char" or other:GetClass() == "thing/food/meat/gore" then
				spawnEntityClass = "thing/food/meat" -- Human Meat → Rotten Meat
			elseif other:GetClass() == "thing/food/dirty.water" then
				spawnEntityClass = "thing/food/purified.water" -- Dirty Water → Purified Water
			elseif other:GetClass() == "thing/food/meat/blood.clot" then
				spawnEntityClass = "thing/food/dirty.water" -- Blood Clot → Dirty Water
			elseif other:GetClass() == "thing/food/meat" then
				spawnEntityClass = "thing/food/meat/human.sausage" -- Rotten Meat → Rotten Human Sausage]]--
			end
		
			-- Spawn the resulting entity after a delay
			if spawnEntityClass then
				timer.Create("SpawnEntityTimer_" .. self:EntIndex(), 20, 1, function()
					local spawnEntity = ents.Create(spawnEntityClass)
					if IsValid(spawnEntity) then
						spawnEntity:SetPos(self:GetPos() + self:GetForward() * 50)
						spawnEntity:Spawn()
					end
		
					-- Stop the spin sound and reset the busy state
					self:StopSound("ambient/machines/engine1.wav")
					self.isBusy = false
				end)
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
		__name = "rot.orerefinery",
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
	OreRefiner = _class_0
end
-- end ----------------------------------------------------------------------------------------------------------------------
local Radio
local _class_0
local NextSpeak, Interval, IntervalRange
local _parent_0 = Machine
local _base_0 = {
	IName = 'fucking radio',
	Model = 'models/props_lab/citizenradio.mdl',
	SetupDataTables = function(self)
		_class_0.__parent.__base.SetupDataTables(self)
		return self:AddNetworkVar('Bool', 'Malfunctioning')
	end,
	Radius = 512,
	Damage = 60,
	Element = 'metal/copper',
	TalkLines = {
		"The Kommandant has created over 8000 jobs for the Liverish economy.",
		'New SS initiatives have eradicated the red plague.',
		"The Kommandant has been working tirelessly to improve the quality of life for all Liverish citizens.",
		"The Kommandant's S.W.I. has improved drinking water quality by 80%.",
		"The Kommandant has reclaimed 20,000 acres of wasteland.",
		"The Kommandant has increased the lifespan of the working livermann by 2 years.",
		"W.A.S.P. has lowered workplace accidents by 50%.",
		"Liver Failure Forever!",
		"Liver Failure's economy is revitalized!",
		"Workers remember, Work Always Safely Protocol.",
		"The National Housing Initiative has eradicated homelessness.",
		"SOTLA is watching.",
		"The demoness democracy is dead! Long live the Kommandant!",
		"We all love our Kommandant.",
		"The SS has cleansed our capital of criminal violence.",
		"The Laboring Livermann's wage provides for food, drink, clothing and comfort.",
		"Tensions rise with Kidneystan's inhumane, kommunist regime.",
		"Under Sotla's watchful eye, the Kommandant leads us to a bright future.",
		"Today's ocular eclipse will make it a day to remember.",
		"Never open computer files from strangers!",
		"See a hacker? Report a hacker.",
		"An unguarded computer is the hacker's playground!",
		"Death before democracy!",
		"Respirators save lives and lungs, do not fear them.",
		"Kommandant's F.A.R.M. program has produced surplus food for the first time in history.",
		"WORK HARDER.",
		"WORK WORK WORK WORK WORK WORK WORK.",
		"DO NOT leave dead corpses unattended. Report them to your nearest Sanitar immediately!",
		"Respect the respirator! Acknowledge its significance in your survival.",
		"A dead worker is a useless worker.",
		"When you're burning bridges, the fire burns forever.",
		"Our strength shall prevail.",
		"Be kind to each other.",
		"Keep your workspace in good condition or you'll regret it.",
		"You will get what you deserve.",
		"You'll wish that you had done some of the hard things when they were easier to do.",
		"You will be surprised by a loud noise.",
		"You are always busy.",
		"Expect the worst, it's the least you can do.",
		"You should go home.",
		"You will regret that.",
		"Your attention, please! Thank you for your attention.",
		"Respect is not for those who ask for it.",
		"Delay is decay, always leave early for work!",
		"Maintenance is cheaper than replacement.",
		"D.E.A.D. accidents have fallen by 75% under the SS.",
		"Brush your teeth, or the SS will do it for you with a board of nails.",
		"Enemy machinations will not deter us.",
		"Cleansed cities under the watch of the SS remain plague-free.",
		"W.A.S.P.: Work Always Safely Protocol. Don't sting yourself.",
		"This land or death! Democracy, never again!",
		"Compliance today means breathing easy tomorrow.",
		"F.E.E.D. has reduced starvation by 40%.",
		"Beware of the consequences.",
		"Report a Bug. Make a Difference.",
		"Hail to the new age! Democracy is obsolete.",
		"The reward for good work is more work.",
		"A broken hand can't hold a hammer.",
		"You're not just a number, you're an important number.",
		"Discretion is Fascism's protection. Keep discourse to a minimum.",
		"Your every action can make or break the regime. Beware!",
		"Work is the perfect cure for despair.",
		"Failure will never overtake you if your determination to succeed is strong enough.",
		"Under the shadow of the Kommandant, we shine together.",
		"Report suspicious activities! Don't let them compromise our values.",
		"Failure is never an option.",
		"Idle hands are a friend to Kidneystan!",
		"When my spring began, I wanted only you.",
		"It hurts more, it hurts, it hurts more.",
		"A pure white awakening will open your eyes."
	},
	OnTakeDamage = function(self, ...)
		_class_0.__parent.__base.OnTakeDamage(self, ...)
		if IsValid(self) then
			self:EmitSound('RadioSmack')
			return self:SetMalfunctioning(true)
		end
	end,
	Think = function(self)
		_class_0.__parent.__base.Think(self)
		if SERVER then
			return
		end
		if not self.NextSpeak then
			self.NextSpeak = CurTime()
		end
		if self.NextSpeak > CurTime() then
			return
		end
		self.NextSpeak = CurTime() + math.random(10, 20)
		if LocalPlayer():GetPos():DistToSqr(self:GetPos()) > 512 * 512 then
			return
		end
		local broken = self:GetMalfunctioning()
		local snd
		if broken then
			snd = 'XombokomBroken'
		else
			snd = 'Xombokom'
		end
		for i = 1, _ud83c_udfb2(2, 5) do
			timer.Simple(i - 1, function()
				if IsValid(self) then
					return self:EmitSound(snd)
				end
			end)
		end
		return self:Talk(table.Random(self.TalkLines), broken)
	end,
	Talk = function(self, line, broken)
		local stutters
		if broken then
			stutters = {
				'scramble'
			}
		else
			stutters = {
				'upper'
			}
		end
		local stutter_chance
		if broken then
			stutter_chance = 65
		else
			stutter_chance = 10
		end
		return BUBBLE({
			text = tostring(line),
			font = "spleen_chat_small",
			pos = self:GetPos(),
			who = self,
			char = NULL,
			text_color = Color(128, 128, 0),
			vol = 0.5,
			move = Vector(0, 0, 0.025),
			speed = 1,
			lifespan = 9,
			clingy = false,
			auditory = true,
			speech = true,
			stutters = stutters,
			stutter_chance = stutter_chance
		})
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
	__name = "Radio",
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
local self = _class_0;
NextSpeak = 0
Interval = 6
IntervalRange = 2
if _parent_0.__inherited then
	_parent_0.__inherited(_parent_0, _class_0)
end
Radio = _class_0
return _class_0