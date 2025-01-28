for k, v in pairs({
	FlipKeyValues = function(tbl)
		local _tbl_0 = { }
		for k, v in pairs(tbl) do
			_tbl_0[v] = k
		end
		return _tbl_0
	end
}) do
	table[k] = v
end
local eye_off_vec, eye_off_ang = Vector(0, 0, 30), Angle(20, 0, 0)
local TraceLine = util.TraceLine
local emeta = FindMetaTable('Entity')
for k, v in pairs({
	DistanceFrom = function(self, pos)
		if isentity(pos) then
			pos = pos:GetPos()
		end
		return self:GetPos():Distance(pos)
	end,
	DistanceFromSqr = function(self, pos)
		if isentity(pos) then
			pos = pos:GetPos()
		end
		return self:GetPos():DistToSqr(pos)
	end,
	GetBoneTransformation = function(self, bone)
		local pos, ang = self:GetBonePosition(bone)
		if (not pos) or pos:IsZero() or pos == self:GetPos() then
			local matrix = self:GetBoneMatrix(bone)
			if matrix and ismatrix(matrix) then
				local bone_tab = {
					Pos = matrix:GetTranslation(),
					Ang = matrix:GetAngles()
				}
				return bone_tab
			end
		end
		local bone_tab = {
			Pos = pos,
			Ang = ang
		}
		return bone_tab
	end,
	GetAttachmentPoint = function(self, pointtype)
		if 'hand' == pointtype then
			local lookup = self:LookupAttachment('anim_attachment_RH')
			if lookup == 0 then
				local bone = self:LookupBone('ValveBiped.Bip01_R_Hand')
				if not isnumber(bone) then
					local attach_tab = {
						Pos = self:WorldSpaceCenter(),
						Ang = self:GetForward():Angle()
					}
					return attach_tab
				end
				return self:GetBoneTransformation(bone)
			end
			return self:GetAttachment(lookup)
		elseif 'eyes' == pointtype then
			local lookup = self:LookupAttachment('eyes')
			if lookup == 0 then
				local attach_tab = {
					Pos = self.WorldSpaceCenter + eye_off_vec,
					Ang = self:GetForward():Angle() + eye_off_ang
				}
				return attach_tab
			end
			return self:GetAttachment(lookup)
		end
	end,
	CanSee = function(self, ent)
		if not IsValid(ent) then
			return
		end
		local tr = TraceLine({
			start = self:GetAttachmentPoint('eyes').Pos,
			endpos = ent:WorldSpaceCenter(),
			filter = self
		})
		return tr.Fractioon == 1.0 or tr.Entity == ent
	end,
	AttemptBoneScale = function(self, name, scale, networking)
		local id = self:LookupBone(name)
		if id then
			return self:ManipulateBoneScale(id, scale, networking)
		end
	end,
	IsDoor = function(self)
		local _exp_0 = self:GetClass()
		if "prop_door_rotating" == _exp_0 or "func_door_rotating" == _exp_0 or "func_door" == _exp_0 then
			return true
		else
			return false
		end
	end
}) do
	emeta[k] = v
end
