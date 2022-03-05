BagWatch = {}

BagWatch.name = "BagWatch"

-- Event handler
function BagWatch.OnAddOnLoaded(event, addonName)
    if addonName == BagWatch.name then
        BagWatch:Initialize()
    end
end

function BagWatch.OnBagUpdate(event, bagId)


end

local function _onInventoryChanged(eventCode, bagId, slotIndex, isNewItem, itemSoundCategory, updateReason, stackCountChange)
    local link = GetItemLink(bagId, slotIndex)
    d("Item: " .. link .. ".")
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
    BagWatchSpace:SetText(bagSpace)

    -- Create the BagWatch frame
    EVENT_MANAGER:RegisterForEvent(self.name, EVENT_PLAYER_COMBAT_STATE, self.OnPlayerCombatState)

    -- Account wide saved variable
    self.savedVariables = ZO_SavedVars:NewAccountWide("BagWatchSavedVariables", 1, nil, {})

    -- Restore saved position
    self:RestorePosition()

end

-- Registering events
EVENT_MANAGER:RegisterForEvent(BagWatch.name, EVENT_ADD_ON_LOADED, BagWatch.OnAddOnLoaded)
--EVENT_MANAGER:RegisterForEvent(BagWatch.name, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, BagWatch.OnBagUpdate)

EVENT_MANAGER:RegisterForEvent("ItemPickUp", EVENT_INVENTORY_SINGLE_SLOT_UPDATE, _onInventoryChanged)
EVENT_MANAGER:AddFilterForEvent("ItemPickUp", EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_IS_NEW_ITEM, true)
EVENT_MANAGER:AddFilterForEvent("ItemPickUp", EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_BACKPACK)
EVENT_MANAGER:AddFilterForEvent("ItemPickUp", EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_INVENTORY_UPDATE_REASON, INVENTORY_UPDATE_REASON_DEFAULT)

--ZO_CreateStringId("SI_BINDING_NAME_DELETE_CHEAPEST", "Delete cheapest")
-- GetNumBagFreeSlots(1)
