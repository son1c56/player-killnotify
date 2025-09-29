ESX = exports["es_extended"]:getSharedObject()

-- This event is triggered by the client when a ped dies
RegisterNetEvent("killfeed:requestDetails", function(victimServerId, killerServerId, weaponLabel, distance)
    local result = {
        victimName = nil,
        victimId = victimServerId,
        killerName = nil,
        killerId = killerServerId,
        weaponLabel = weaponLabel,
        distance = distance or nil
    }

    -- Get victim name
    if victimServerId then
        local xVictim = ESX.GetPlayerFromId(victimServerId)
        result.victimName = xVictim and xVictim.getName() or ("Player "..victimServerId)
    end

    -- Get killer name
    if killerServerId then
        local xKiller = ESX.GetPlayerFromId(killerServerId)
        result.killerName = xKiller and xKiller.getName() or ("Player "..killerServerId)
    end

    -- Send notification ONLY to the killer
    if killerServerId then
        TriggerClientEvent("killfeed:sendDetailsToClient", killerServerId, result)
    end

    -- Send notification ONLY to the victim
    if victimServerId then
        TriggerClientEvent("killfeed:sendVictimNotify", victimServerId, result)
    end
end)
