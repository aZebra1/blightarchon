-- Define the save/load file path
local SAVE_FILE = "gmod_settings/saved_entities.txt"

if SERVER then
    -- Ensure the directory exists
    if not file.Exists("gmod_settings", "DATA") then
        file.CreateDir("gmod_settings")
        print("Directory 'gmod_settings' created.")
    end

    -- Function to save an entity's data to the file
    local function SaveEntityData(ent)
        if not IsValid(ent) then return end

        -- Gather necessary data
        local data = {
            model = ent:GetModel(),
            pos = ent:GetPos(),
            angles = ent:GetAngles(),
        }

        -- Append the entity data to the file
        local success, err = pcall(function()
            local fileData = util.TableToJSON(data) .. "\n"
            file.Append(SAVE_FILE, fileData)
        end)

        if not success then
            print("Error writing to file:", err)
        else
            print("Entity data saved!")
        end
    end

    -- Function to load saved entities after a server restart
    hook.Add("InitPostEntity", "LoadSavedEntities", function()
        if file.Exists(SAVE_FILE, "DATA") then
            local savedData = file.Read(SAVE_FILE, "DATA")
            local entities = string.Explode("\n", savedData)

            for _, entityData in ipairs(entities) do
                if entityData ~= "" then
                    local data = util.JSONToTable(entityData)

                    -- Recreate the entity
                    local ent = nil

                    local modelFleshGrinder = "models/props_wasteland/laundry_dryer002.mdl"
                    local modelRotPurifier = "models/props_wasteland/laundry_washer003.mdl"
                    local modelRotStove = "models/props_wasteland/kitchen_stove001a.mdl"
                    local modelRotRockWash = "models/props_wasteland/laundry_washer001a.mdl"
                    local modelRotOreRefinery = "models/props_c17/furniturewashingmachine001a.mdl"

                    if data.model == modelFleshGrinder then
                        ent = ents.Create("nonpickup/flesh.grinder")
                    elseif data.model == modelRotPurifier then
                        ent = ents.Create("nonpickup/rot.purifier")
                    elseif data.model == modelRotStove then
                        ent = ents.Create("nonpickup/rot.stove")
                    elseif data.model == modelRotRockWash then
                        ent = ents.Create("nonpickup/rot.rockwash")
                    elseif data.model == modelRotOreRefinery then
                        ent = ents.Create("nonpickup/rot.orerefinery")
                    else
                        print("Invalid ENT. contact chris.")
                        return
                    end

                    ent:SetModel(data.model)
                    ent:SetPos(data.pos)
                    ent:SetAngles(data.angles)
                    ent:Spawn()

                    -- Freeze the entity in place
                    local phys = ent:GetPhysicsObject()
                    if IsValid(phys) then
                        phys:EnableMotion(false)
                    end
                end
            end

            print("Saved entities loaded!")
        else
            print("No saved entities found.")
        end
    end)

    -- Function to remove an entity from the save file
    local function RemoveEntityData(ent)
        if not IsValid(ent) then return end

        -- Get all saved data
        local savedData = file.Read(SAVE_FILE, "DATA")
        if not savedData or savedData == "" then return end

        local entities = string.Explode("\n", savedData)
        local newEntities = {}
        local removed = false

        -- Filter out the entity to remove
        for _, entityData in ipairs(entities) do
            if entityData ~= "" then
                local data = util.JSONToTable(entityData)
                if data.model == ent:GetModel() and data.pos == ent:GetPos() and data.angles == ent:GetAngles() then
                    removed = true
                else
                    table.insert(newEntities, entityData)
                end
            end
        end

        -- Save the updated list back to the file
        file.Write(SAVE_FILE, table.concat(newEntities, "\n"))
        if removed then
            print("Entity data removed!")
        else
            print("Entity not found in saved data.")
        end
    end

    -- Console command to save the entity you're looking at
    concommand.Add("saveprop", function(ply)
        if not ply:IsAdmin() then
            ply:PrintMessage(HUD_PRINTTALK, "You do not have permission to use this command!")
            return
        end

        local tr = ply:GetEyeTrace()
        local ent = tr.Entity

        if IsValid(ent) and ent:GetClass() == "nonpickup/flesh.grinder" or "nonpickup/rot.purifier" or "nonpickup/rot.stove" or "nonpickup/rot.rockwash" or "nonpickup/rot.orerefinery" then
            SaveEntityData(ent)
        else
            ply:PrintMessage(HUD_PRINTTALK, "You must be looking at a valid prop!")
        end
    end)

    -- Console command to remove the entity you're looking at
    concommand.Add("removeprop", function(ply)
        if not ply:IsAdmin() then
            ply:PrintMessage(HUD_PRINTTALK, "You do not have permission to use this command!")
            return
        end

        local tr = ply:GetEyeTrace()
        local ent = tr.Entity

        if IsValid(ent) and ent:GetClass() == "nonpickup/flesh.grinder" or "nonpickup/rot.purifier" or "nonpickup/rot.stove" or "nonpickup/rot.rockwash" or "nonpickup/rot.orerefinery" then
            RemoveEntityData(ent)
        else
            ply:PrintMessage(HUD_PRINTTALK, "You must be looking at a valid prop to remove it!")
        end
    end)

    -- Console command to print the class of the entity you're looking at
    concommand.Add("getclass", function(ply)
        if not ply:IsAdmin() then
            ply:PrintMessage(HUD_PRINTTALK, "You do not have permission to use this command!")
            return
        end

        local tr = ply:GetEyeTrace()
        local ent = tr.Entity

        if IsValid(ent) then
            ply:PrintMessage(HUD_PRINTTALK, "The class of the entity you're looking at is: " .. ent:GetClass())
        else
            ply:PrintMessage(HUD_PRINTTALK, "You're not looking at a valid entity!")
        end
    end)
end
