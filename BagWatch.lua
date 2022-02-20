BagWatch = {}

BagWatch.name = "BagWatch"

function BagWatch.Initialize()
    -- Create the BagWatch frame
end

-- Event handler
function BagWatch.OnAddOnLoaded(event, addonName)
    if addonName == BagWatch.name then
        BagWatch.Initialize()
    end
end

-- Registering events
EVENT_MANAGER:RegisterForEvent(BagWatch.name, EVENT_ADD_ON_LOADED, BagWatch.OnAddOnLoaded)

-- GetNumBagFreeSlots(1)
