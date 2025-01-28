local TranslatePlayerModel, TranslatePlayerHands, TranslateToPlayerModelName, RunClass, RegisterClass, SetPlayerClass, GetPlayerClass, GetPlayerClasses = player_manager.TranslatePlayerModel, player_manager.TranslatePlayerHands, player_manager.TranslateToPlayerModelName, player_manager.RunClass, player_manager.RegisterClass, player_manager.SetPlayerClass, player_manager.GetPlayerClass, player_manager.GetPlayerClasses
local meta = FindMetaTable('Player')
for k, v in pairs({
	RunClass = function(self, fn, ...)
		local cls = self:ClassTable()
		if cls and cls[fn] then
			return RunClass(self, fn, ...)
		end
	end,
	ClassName = function(self)
		return GetPlayerClass(self)
	end,
	ClassTable = function(self)
		return GetPlayerClasses()[self:ClassName()]
	end
}) do
	meta[k] = v
end
local id = "eclipse_plyclass"
hook.Add('StartCommand', id, function(ply, cmd)
	return ply:RunClass('StartCommand', cmd)
end)
hook.Add('PlayerPostThink', id, function(ply)
	return ply:RunClass('Think')
end)
if CLIENT then
	hook.Add('PrePlayerDraw', id, function(ply, flags)
		return ply:RunClass('PrePlayerDraw', flags)
	end)
	hook.Add('PostPlayerDraw', id, function(ply, flags)
		return ply:RunClass('PostPlayerDraw', flags)
	end)
	hook.Add('HUDPaint', id, function()
		return LocalPlayer():RunClass('HUDPaint')
	end)
	hook.Add('HUDDrawTargetID', id, function()
		return LocalPlayer():RunClass('HUDDrawTargetID')
	end)
	hook.Add('PostDrawOpaqueRenderables', id, function()
		return LocalPlayer():RunClass('PostDrawOpaqueRenderables')
	end)
	hook.Add('InputMouseApply', id, function(...)
		return LocalPlayer():RunClass('InputMouseApply', ...)
	end)
else
	hook.Add('PostPlayerDeath', id, function(ply)
		return ply:RunClass('PostPlayerDeath')
	end)
	hook.Add('SetupPlayerVisibility', id, function(ply, viewEntity)
		if IsValid(viewEntity) then
			AddOriginToPVS(viewEntity:WorldSpaceCenter())
		end
		return ply:RunClass('SetupPlayerVisibility', viewEntity)
	end)
end
local _class_0
local _base_0 = { }
if _base_0.__index == nil then
	_base_0.__index = _base_0
end
_class_0 = setmetatable({
	__init = function() end,
	__base = _base_0,
	__name = "PLYCLASS"
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
self.__inherited = function(self, child)
	return RegisterClass(string.lower(child.__name), child.__base, child.baseclass or "player_default")
end
PLYCLASS = _class_0
