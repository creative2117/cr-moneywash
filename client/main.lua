local washing = false
local time = Config.Time
local QBCore = exports['qb-core']:GetCoreObject()

local function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
CreateThread(function()
    while true do
        local sleep = 1
        local inRange = false
        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)
        for k, v in pairs(Config.Locations) do
            local coords = vector3(Config.Locations[k].x, Config.Locations[k].y, Config.Locations[k].z)
            local dist = #(PlayerPos - coords)
            if dist < 15 then
                inRange = true
                
                if dist < 0.5 then
                    if not washing then
                        DrawText3D(Config.Locations[k].x, Config.Locations[k].y, Config.Locations[k].z, Lang:t("text3d.3dtext"))
                        if IsControlJustPressed(0, Config.key) then
                            washing = true
                            TriggerServerEvent("cr-moneywash:server:checkinv", k)
                        end
                    end
                end
            else
                inRange = false
            end
        end
        if not inRange then
            sleep = 1000
        end
        Wait(sleep)
    end
end)

RegisterNetEvent("cr-moneywash:client:startTimer", function(worth, k)
    text(k, worth)
    while washing do
        Wait(1000)
        if time > 0 then
            time = time - 1
        end
    end
end)

function text(k, worth)
    CreateThread(function()
        while washing do 
            local PlayerPed = PlayerPedId()
            local PlayerPos = GetEntityCoords(PlayerPed)
            local coords = vector3(Config.Locations[k].x, Config.Locations[k].y, Config.Locations[k].z)
            local dist = #(PlayerPos - coords)
            local sleep = 1
            if dist < 15 then
                inrange = true
                if dist < 10 then
                    if washing and time > 0 then
                        DrawText3D(Config.Locations[k].x, Config.Locations[k].y, Config.Locations[k].z, Lang:t("text3d.3dtext_left", {timeleft = time}))
                    elseif washing and time == 0 then
                        DrawText3D(Config.Locations[k].x, Config.Locations[k].y, Config.Locations[k].z, Lang:t("text3d.3dtext_done"))
                        if IsControlJustPressed(0, Config.key) then
                            washing = false
                            time = Config.Time
                            TriggerServerEvent("cr-moneywash:server:GiveMoney", worth)
                        end
                    end
                end
            end
            if not inrange then
                sleep = 1000
            end
            Wait(sleep)
        end
    end)
end