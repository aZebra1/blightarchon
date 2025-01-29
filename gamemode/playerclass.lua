local Fucklet
local _class_0
local _parent_0 = PLYCLASS

-- Define base class with methods and data tables
local _base_0 = {
    WalkSpeed = 80,
    RunSpeed = 160,

    -- Loadout function to initialize player state and inventory
    Loadout = function(self)
        self.Player:SetState(STATE.IDLE)
        self.Player:SetStance(STANCE_RISEN)

        return timer.Simple(0.1, function()
            self.Player:Give('hands', true)
            INVENTORY_SLOTTED(self.Player)
        end)
    end,

    -- Set model for the player
    SetModel = function(self)
        self.Player:SetModel("models/in/player/everyman.mdl")
    end,

    -- Command handler
    StartCommand = function(self, cmd)
        if self.Player:GetBodyEntity() ~= self.Player then
            return cmd:ClearMovement()
        elseif self.Player.GetState then
            local state = self.Player:GetStateTable()
            if state and state.StartCommand then
                return state:StartCommand(self.Player, cmd)
            end
        end
    end,

    -- Define data tables
    DataTables = {
        String = { 'RPName' },
        Entity = { 'Ragdoll', 'StateEntity', 'Dragging' },
        Bool = { 'IsRagdoll', 'Watching', 'HoldingDown', 'Chatting' },
        Float = { 'Speed', 'SpeedTarget', 'StateStart', 'StateEnd', 'StateNumber' },
        Int = { 'State', 'Stance', 'Caste', 'Fate' },
        Vector = { 'StateVector' },
        Angle = { 'StateAngles' }
    },

    -- Setup data tables for the player
    SetupDataTables = function(self)
        for var_type, vars in pairs(self.DataTables) do
            local idx = 0
            for _, var in ipairs(vars) do
                self.Player:NetworkVar(var_type, idx, var)
                idx = idx + 1
            end
        end
    end
}

-- Merge parent class methods if not already defined in the base
for _key_0, _val_0 in pairs(_parent_0.__base) do
    if _base_0[_key_0] == nil and _key_0:match("^__") and not (_key_0 == "__index" and _val_0 == _parent_0.__base) then
        _base_0[_key_0] = _val_0
    end
end

-- Set the index of the base class if not already defined
if _base_0.__index == nil then
    _base_0.__index = _base_0
end

-- Set the metatable for the base class
setmetatable(_base_0, _parent_0.__base)

-- Define the class with inheritance from parent
_class_0 = setmetatable({
    __init = function(self, ...)
        return _class_0.__parent.__init(self, ...)
    end,
    __base = _base_0,
    __name = "fucklet",
    __parent = _parent_0
}, {
    -- Lookup function for properties
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

    -- Class instantiation
    __call = function(cls, ...)
        local _self_0 = setmetatable({}, _base_0)
        cls.__init(_self_0, ...)
        return _self_0
    end
})

-- Set the class reference in the base
_base_0.__class = _class_0

-- Call inherited methods if any
if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
end

-- Return the class definition
Fucklet = _class_0
return _class_0
