exports['qb-target']:AddTargetModel({-1978741854, 2057317573, -232023078}, { --Yoga mats
    options = {
        {
            type = "client",
            event = "yoga:start",
            icon = "fas fa-yin-yang",
            label = "Do yoga",
        },
    },
    distance = 2.5
})

local succeededAttempts = 0
local neededAttempts = 2

RegisterNetEvent('yoga:start', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local skillbar = exports['qb-skillbar']:GetSkillbarObject()

    TriggerEvent('animations:client:EmoteCommandStart', {"yoga"})
    FreezeEntityPosition(ped, true)

    skillbar.Start({
        duration = math.random(7500, 15000),
        pos = math.random(10, 30),
        width = math.random(10, 20),
    }, function()
        if succeededAttempts + 1 >= neededAttempts then
            ClearPedTasks(ped)
            SucceededAttempts = 0
            FreezeEntityPosition(ped, false)
            TriggerServerEvent('hud:server:RelieveStress', 5)
            QBCore.Functions.Notify("You have a bit less stress", "success")
        else
            skillbar.Repeat({
                duration = math.random(700, 1250),
                pos = math.random(10, 40),
                width = math.random(10, 13),
            })
            succeededAttempts = succeededAttempts + 1
        end
    end, function()
        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)
        QBCore.Functions.Notify("Failed, focus..", "error")
        SetPedToRagdollWithFall(ped, 1000, 2000, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
        succeededAttempts = 0
    end)
end)

CreateThread(function()
    local coords = vector3(-1493.59, 829.14, 181.6)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, 197)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, 24)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Yoga")
    EndTextCommandSetBlipName(blip)
end)
