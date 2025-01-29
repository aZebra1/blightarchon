-- Define spawn locations and entity classes
local spawnLocations = {
    {pos = Vector(4284.491699, 3626.202637, -105.891708), ang = Angle(0, 0, 0)},
    {pos = Vector(4077.406738, 3625.102051, -101.484657), ang = Angle(0, 0, 0)},
    {pos = Vector(3837.185791, 3618.208984, -105.380974), ang = Angle(0, 0, 0)},
    {pos = Vector(3591.357178, 3611.704102, -66.831902), ang = Angle(0, 0, 0)},
    {pos = Vector(3560.144287, 3342.927490, -108.946838), ang = Angle(0, 0, 0)},
    {pos = Vector(3566.256592, 3122.000488, -99.823402), ang = Angle(0, 0, 0)},
    {pos = Vector(3754.015137, 3125.470947, -98.955864), ang = Angle(0, 0, 0)},
    {pos = Vector(3955.535156, 3130.627930, -80.536987), ang = Angle(0, 0, 0)},
    {pos = Vector(4086.195557, 3343.132324, -83.289673), ang = Angle(0, 0, 0)},
    {pos = Vector(3777.854736, 3388.355713, -108.796173), ang = Angle(0, 0, 0)}
}

local entityClasses = {
    "thing/junk/rock",
    "thing/junk/rock",
    "thing/junk/rock",
    "thing/junk/rock",
    "thing/junk/rock",
    "thing/junk/rock",
    "thing/junk/rock",
    "thing/junk/rock",
    "thing/junk/rock",
    "thing/junk/rock"
}

-- Store entities and their original positions
local spawnedEntities = {}

-- Function to spawn an entity at a specific location
local function SpawnEntity(index)
    local location = spawnLocations[index]
    local entityClass = entityClasses[index]

    if not location or not entityClass then return end

    -- Remove the existing entity if it exists
    if IsValid(spawnedEntities[index]) then
        spawnedEntities[index]:Remove()
    end

    -- Trace down to find the ground
    local traceData = {
        start = location.pos,
        endpos = location.pos - Vector(0, 0, 1000), -- Trace 1000 units downward
        filter = nil -- Ignore all entities
    }
    local traceResult = util.TraceLine(traceData)

    -- Adjust position to the hit point, if ground is found
    local spawnPos = traceResult.Hit and traceResult.HitPos or location.pos

    -- Spawn the new entity
    local ent = ents.Create(entityClass)
    if not IsValid(ent) then return end

    ent:SetPos(spawnPos)
    ent:SetAngles(location.ang)
    ent:Spawn()

    -- Freeze the entity to prevent immediate movement
    local phys = ent:GetPhysicsObject()
    if IsValid(phys) then
        phys:EnableMotion(false)
    end

    spawnedEntities[index] = ent
end

-- Function to check if an entity has moved or been destroyed
local function HasEntityMovedOrDestroyed(index)
    local ent = spawnedEntities[index]
    
    -- If the entity doesn't exist, treat it as destroyed
    if not IsValid(ent) then
        return true
    end

    local location = spawnLocations[index]
    if not location then
        return true
    end

    -- Check if the entity's position has changed
    local currentPos = ent:GetPos()
    return currentPos:DistToSqr(location.pos) > 1 -- Using squared distance for performance
end

-- Timer to periodically check entities and respawn if necessary
local function StartEntityCheckTimer()
    timer.Create("EntityCheckTimer", 300, 0, function()
        for i = 1, #spawnLocations do
            if HasEntityMovedOrDestroyed(i) then
                SpawnEntity(i)
            end
        end
    end)
end

-- Initialize the entities
hook.Add("InitPostEntity", "SpawnInitialEntities", function()
    for i = 1, #spawnLocations do
        SpawnEntity(i)
    end
    StartEntityCheckTimer()
end)