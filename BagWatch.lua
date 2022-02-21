BagWatch = {}

BagWatch.name = "BagWatch"

function BagWatch:Initialize()
    self.inCombat = IsUnitInCombat("player")
    self.bagSpace = GetNumBagFreeSlots(1)
    -- Create the BagWatch frame
    EVENT_MANAGER:RegisterForEvent(self.name, EVENT_PLAYER_COMBAT_STATE, self.OnPlayerCombatState)
    self.savedVariables = ZO_SavedVars:NewAccountWide("BagWatchSavedVariables", 1, nil, {})

end

-- Event handler
function BagWatch.OnAddOnLoaded(event, addonName)
    if addonName == BagWatch.name then
        BagWatch:Initialize()
    end
end

function OnBagUpdate(event, bagId)
    -- Update the BagWatch frame
end

function BagWatch.OnPlayerCombatState(event, inCombat)
    if inCombat ~= BagWatch.inCombat then
        BagWatch.inCombat = inCombat

        BagWatchIndicator:SetHidden(not inCombat)

        -- Message in chat
        --if inCombat then
        --    d("Entering combat")
        --else
        --    d("Exiting combat.")
        --end
    end

end

-- Registering events
EVENT_MANAGER:RegisterForEvent(BagWatch.name, EVENT_ADD_ON_LOADED, BagWatch.OnAddOnLoaded)

-- GetNumBagFreeSlots(1)
