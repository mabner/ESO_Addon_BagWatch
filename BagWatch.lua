BagWatch = {}

BagWatch.name = "BagWatch"

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

function BagWatch.OnIndicatorMoveStop()
    BagWatch.savedVariables.left = BagWatchIndicator:GetLeft()
    BagWatch.savedVariables.top = BagWatchIndicator:GetTop()
end

function BagWatch:RestorePosition()
    local left = self.savedVariables.left
    local top = self.savedVariables.top

    -- TODO: When using the saved position, the element is not displayed
    --BagWatchIndicator:ClearAnchors()
    --BagWatchIndicator:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, left, top)
end

function BagWatch:Initialize()
    self.inCombat = IsUnitInCombat("player")
    self.bagSpace = GetNumBagFreeSlots(1)

    -- Create the BagWatch frame
    EVENT_MANAGER:RegisterForEvent(self.name, EVENT_PLAYER_COMBAT_STATE, self.OnPlayerCombatState)

    -- Account wide saved variable
    self.savedVariables = ZO_SavedVars:NewAccountWide("BagWatchSavedVariables", 1, nil, {})

    -- Restore saved position
    self:RestorePosition()

end

-- Registering events
EVENT_MANAGER:RegisterForEvent(BagWatch.name, EVENT_ADD_ON_LOADED, BagWatch.OnAddOnLoaded)

-- GetNumBagFreeSlots(1)
