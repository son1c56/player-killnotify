ESX = exports["es_extended"]:getSharedObject()

local processedEntities = {} -- Tracks processed ped entities

-- Weapon hash → readable name table
local weaponNames = setmetatable({
    
    --MELEE WEAPONS
    [0x92A27487] = "Dolch",
    [0x958A4A8F] = "Baseballschläger",
    [0xF9E6AA4B] = "Flasche",
    [0x84BD7BFD] = "Brechstange",
    [0x0] = "Faust",
    [0x8BB05FD7] = "Taschenlampe",
    [0x440E4788] = "Golfschläger",
    [0x4E875F73] = "Hammer",
    [0xF9DCBF2D] = "Beil",
    [0xD8DF3C3C] = "Schlagring",
    [0x99B507EA] = "Messer",
    [0xDD5DF8D9] = "Machete",
    [0xDFE37640] = "Klappmesser",
    [0x678B81B1] = "Schlagstock",
    [0x19044EE0] = "Rohrzange",
    [0xCD274149] = "Kampfaxt",
    [0x94117305] = "Billiardqueue",
    [0x3813FC08] = "STein-Kriegsbeil",
    [0x6589186A] = "Zuckerstange",
    [0xDAC00025] = "Schocker",

    --PISTOLS
    [0x1B06D571] = "Pistole",
    [-1075685676] = "Pistole MK2",
    [-1716589765] = "Pistole .50",
    [0x5EF9FEC4] = "Kampfpistole",
    [0x22D8FE39] = "AP-Pistole",
    [0x3656C8C1] = "Elektroschocker",
    [-1076751822] = "SNS Pistole",
    [-2009644972] = "SNS Pistole MK2",
    [-771403250] = "Schwere Pistole",
    [0x83839C4] = "Vintage Pistole",
    [0x47757124] = "Leuchtpistole",
    [-598887786] = "Präzisionspistole",
    [-1045183535] = "Revolver",
    [-879347409] = "Revolver MK2",
    [-1746263880] = "Double-Action-Revolver",
    [-1355376991] = "Up-n-Atomisierer",
    [0x2B5EF5EC] = "Keramik Pistole",
    [-1853920116] = "Navy Revolver",
    [0x57A4368C] = "Perico-Pistole",
    [0x1BC4FDB9] = "WM-29 Pistole",

    --SMG
    [0x13532244] = "Mikro-MP",
    [0x2BE6766B] = "SMG",
    [0x78A97CD0] = "SMG MK2",
    [-270015777] = "Sturm-MP",
    [0x0A3D4D34] = "Einsatz-PDW",
    [-619010992] = "Reihenfeuerpistole",
    [-1121678507] = "Mini-SMG",
    [0x476BF155] = "Unheiliger Höllenbringer",
    [0x14E5AFD5] = "Taktische MP",
    
    --SHOTGUNS
    [0x1D073A89] = "Pump-Action Schrotflinte",
    [0x555AF99A] = "Pump-Action Schrotflinte MK2",
    [0x7846A318] = "Abgesägte Schrotflinte",
    [-494615257] = "Sturm-Schortflinte",
    [-1654528753] = "Bullpup-Schortflinte",
    [0x3AABBBAA] = "Schwere Schrotflinte",
    [-275439685] = "Doppelläufige Schrotflinte",
    [0x12E82D3D] = "Automatische Schrotflinte",
    [0x5A96BA4] = "Kampfschrotflinte",

    --ASSAULT RIFLES
    [-1074790547] = "Sturmgewehr",
    [0x394F415C] = "Sturmgewehr MK2",
    [-2084633992] = "Karabiner",
    [-86904375] = "Karabiner MK2",
    [-1357824103] = "Advanced-Gewehr",
    [-1063057011] = "Spezialkarabiner",
    [-1768145561] = "Spezialkarabiner MK2",
    [0x7F229F94] = "Bullpup-Gewehr",
    [-2066285827] = "Bullpup-Gewehr MK2",
    [0x624FE830] = "Kompaktgewehr",
    [-1658906650] = "Militärgewehr",
    [-947031628] = "Schweres Gewehr",
    [-774507221] = "Dienstgewehr",

    --LMG
    [-1660422300] = "MG",
    [0x7FD62962] = "Gefechts-MG",
    [-608341376] = "Gefechts-MG MK2",
    [0x61012683] = "Gusenberg",

    --SNIPER RIFLES
    [0x05FC3C11] = "Scharfschützengewehr",
    [0x0C472FE2] = "Schweres Scharfschützengewehr",
    [0xA914799] = "Schweres Scharfschützengewehr MK2",
    [-952879014] = "Präzisionsgewehr",
    [0x6A6C02E0] = "Präzisionsgewehr MK2",
    [0x6E7DDDEC] = "Päzisionsschützengewehr",
    [-1466123874] = "Muskete",

    -- HEAVY WEAPONS
    [-1312131151] = "RPG",
    [-1568386805] = "Granatwerfer",
    [0x42BF8A85] = "Minigun",
    [0x7F7497E5] = "Feuerwerkabschussgerät",
    [0x6D544C99] = "Railgun",
    [0x63AB0442] = "Lenkraketenwerfer",
    [0x0781FE4A] = "Kompakter Granatwerfer",
    [-1238556825] = "Witwenmacher",
    [-22923932] = "Railgun XM3",
    
    --THROWABLES
    [-1813897027] = "Granate",
    [-1600701090] = "BZ Gas",
    [615608432] = "Molotov Cocktail",
    [0x2C3731D9] = "Haftbombe",
    [-1420407917] = "Annäherungsmine",
    [0x787F0BB] = "Schneeball",
    [-1169823560] = "Rohrbombe",
    [0x23C9F95C] = "Baseball",
    [-37975472] = "Tränengas",
    [0x497FACC3] = "Flare",
    [0xF7F1E25E] = "LSD-Päckchen",
   
    --MISC
    [0x34A67B97] = "Benzinkanister",
    [0x060EC506] = "Feuerlöscher",
    [0xBA536372] = "Gefährlicher Kanister",

}, { __index = function() return "Unknown" end })



itizen.CreateThread(function()
    while true do
        Wait(100)

        for _, playerId in ipairs(GetActivePlayers()) do
            local ped = GetPlayerPed(playerId)

            if DoesEntityExist(ped) and IsPedDeadOrDying(ped, true) then
                if not processedEntities[ped] then
                    processedEntities[ped] = true

                    local victimServerId = GetPlayerServerId(playerId)
                    local killerEntity = GetPedSourceOfDeath(ped)

                    if killerEntity and DoesEntityExist(killerEntity) and IsPedAPlayer(killerEntity) then
                        local killerPlayerIndex = NetworkGetPlayerIndexFromPed(killerEntity)
                        local killerServerId = GetPlayerServerId(killerPlayerIndex)

                        -- Only the killer client sends the event
                        if killerServerId == GetPlayerServerId(PlayerId()) then
                            local weaponHash = GetPedCauseOfDeath(ped) or 0
                            local weaponLabel = weaponNames[weaponHash] or "Unknown"

                            local killerCoords = GetEntityCoords(PlayerPedId())
                            local victimCoords = GetEntityCoords(ped)
                            local distance = #(victimCoords - killerCoords)

                            TriggerServerEvent("killfeed:requestDetails", victimServerId, killerServerId, weaponLabel, distance)
                            print(weaponHash)
                        end
                    end
                end
            else
                if processedEntities[ped] then
                    processedEntities[ped] = nil
                end
            end
        end
    end
end)


-- Notifications for killer
RegisterNetEvent("killfeed:sendDetailsToClient", function(data)
    if not data then return end
    ESX.ShowNotification(("Du hast [ID: %s] %s mit %s aus %.1f Metern getötet"):format(
        data.victimId or "?",
        data.victimName or "Unbekannt",
        data.weaponLabel or "Unbekannt",
        data.distance or 0.0
    ))
end)

-- Notifications for victim
RegisterNetEvent("killfeed:sendVictimNotify", function(data)
    if not data then return end
    ESX.ShowNotification(("Du wurdest von [ID: %s] %s mit %s aus %.1f Metern getötet"):format(
        data.killerId or "?",
        data.killerName or "Unbekannt",
        data.weaponLabel or "Unbekannt",
        data.distance or 0.0
    ))
end)

