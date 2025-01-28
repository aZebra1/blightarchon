local meta = FindMetaTable('Player')
for k, v in pairs({
	StanceIs = function(self, stance)
		return self:GetStance() == stance
	end
}) do
	meta[k] = v
end
STATE.HandleSquat = function(self, ply, vel, animset)
	if ply:StanceIs(STANCE_SQUAT) then
		ply.CalcSeqOverride = ply:FindSequence(vel:Length2D() > .5 and animset.creep or animset.squat)
		if ply:GetHoldingDown() then
			if not (ply:DoingSomething() or BIND.controls['ctrl']:IsDown(ply)) then
				ply:Do(ACT.STANCE_RISEN)
			end
		end
		return true
	end
	return false
end
STATE.HandleProne = function(self, ply, vel, animset)
	if ply:StanceIs(STANCE_PRONE) then
		ply.CalcSeqOverride = ply:FindSequence(vel:Length2D() > .5 and animset.crawl or animset.prone)
		if ply:GetHoldingDown() then
			if not (ply:DoingSomething() or BIND.controls['space']:IsDown(ply)) then
				ply:Do(ACT.STANCE_RISEN)
			end
		end
		return true
	end
	return false
end
