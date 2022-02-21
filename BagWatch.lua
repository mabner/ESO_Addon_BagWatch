BagWatch = {}

BagWatch.name = "BagWatch"

function BagWatch:Initialize()
    self.inCombat = IsUnitInCombat("player")
    -- Create the BagWatch frame
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

        if inCombat then
            d("Entering combat")
        else
            d("Exiting combat.")
        end
    end
end

-- Registering events
EVENT_MANAGER:RegisterForEvent(BagWatch.name, EVENT_ADD_ON_LOADED, BagWatch.OnAddOnLoaded)

-- GetNumBagFreeSlots(1)
