local seek_weapon
seek_weapon = function(bot)
	if IsValid(bot:Wielding()) then
		return
	end
	local _list_0 = ents.FindByClass("thing/*")
	for _index_0 = 1, #_list_0 do
		local thing = _list_0[_index_0]
		local _continue_0 = false
		repeat
			if not thing:InWorld() then
				_continue_0 = true
				break
			end
			if not (thing:DistanceFrom(bot) <= 256) then
				_continue_0 = true
				break
			end
			if not bot:CanSee(thing) then
				_continue_0 = true
				break
			end
			local wishes = {
				'thing/junk/rebar',
				'thing/weapon'
			}
			local acceptable = false
			for _index_1 = 1, #wishes do
				local cls = wishes[_index_1]
				if thing:GetClass():starts(cls) then
					acceptable = true
					break
				end
			end
			if not acceptable then
				_continue_0 = true
				break
			end
			bot.Targeting = thing
			do
				return true
			end
			_continue_0 = true
		until true
		if not _continue_0 then
			break
		end
	end
end
local Bots
local _class_0
local _parent_0 = MODULE
local _base_0 = {
	StartCommand = function(self, bot, cmd)
		if not (bot:IsBot() and bot:Alive()) then
			return
		end
		cmd:ClearMovement()
		cmd:ClearButtons()
		if bot:GetIsRagdoll() then
			bot.GetUpNow = bot.GetUpNow or (CurTime() + math.random(3, 8))
			if CurTime() >= bot.GetUpNow then
				bot.GetUpNow = nil
				bot:Do(ACT.STAND_UP)
			end
			return
		end
		local weapon = bot:Wielding()
		if IsValid(bot.Targeting) then
			local enemy = bot.Opinions.enemies[bot.Targeting]
			if not enemy then
				seek_weapon(bot)
			end
		end
		if not IsValid(bot.Targeting) then
			if not seek_weapon(bot) then
				local _list_0 = player.GetAll()
				for _index_0 = 1, #_list_0 do
					local ply = _list_0[_index_0]
					local _continue_0 = false
					repeat
						if not ply:Alive() then
							_continue_0 = true
							break
						end
						if ply == bot then
							_continue_0 = true
							break
						end
						if not bot:CanSee(ply) then
							_continue_0 = true
							break
						end
						bot.Targeting = ply
						_continue_0 = true
					until true
					if not _continue_0 then
						break
					end
				end
			end
		end
		if not IsValid(bot.Targeting) then
			return
		end
		bot.Opinions = bot.Opinions or {
			friends = { },
			enemies = { }
		}
		local friend = false
		local enemy = false
		local targ = bot.Targeting
		if targ:IsPlayer() then
			friend = bot.Opinions.friends[targ]
			enemy = bot.Opinions.enemies[targ]
			if (not friend) and (not enemy) then
				bot.Opinions.friends[targ] = true
				friend = true
			end
		end
		local dist_targ
		if friend then
			dist_targ = 128
		else
			dist_targ = 64
		end
		local dist_from = bot:DistanceFrom(targ)
		if dist_from >= dist_targ then
			cmd:SetForwardMove(bot:GetSpeed())
		end
		local ang
		if targ:IsPlayer() then
			ang = (targ:GetShootPos() - bot:GetShootPos()):GetNormalized():Angle()
		else
			ang = (targ:GetPos() - bot:GetShootPos()):GetNormalized():Angle()
		end
		cmd:SetViewAngles(ang)
		bot:SetEyeAngles(ang)
		if enemy then
			cmd:SetButtons(IN_ATTACK2)
			bot.NextAttack = bot.NextAttack or CurTime()
			if CurTime() >= bot.NextAttack and (dist_from <= dist_targ) then
				bot.NextAttack = CurTime() + math.Rand(1, 4)
				if IsValid(weapon) then
					bot:Do(ACT.SWING, weapon)
				else
					local act = ACT.PUNCH
					if math.random(1, 5) == 3 then
						act = ACT.SHOVE
					end
					bot:Do(act)
				end
			end
		elseif (targ:GetClass():starts('thing')) then
			bot:Do(ACT.PICK_UP, targ)
		end
		if targ:IsPlayer() then
			if not targ:Alive() then
				bot.Opinions.friends[targ] = false
				bot.Opinions.enemies[targ] = false
				bot.Targeting = nil
			end
		else
			local has_weapon = IsValid(bot:Wielding())
			if has_weapon then
				bot.Targeting = nil
			end
		end
		return
	end,
	PlayerHurt = function(self, victim, attacker)
		if victim.Opinions then
			victim.Opinions.friends[attacker] = false
			victim.Opinions.enemies[attacker] = true
			victim.Targeting = attacker
		end
		return
	end,
	PlayerDeath = function(self, victim, ...)
		if victim.Opinions then
			victim.Opinions = {
				friends = { },
				enemies = { }
			}
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
	__name = "Bots",
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
Bots = _class_0
return _class_0
