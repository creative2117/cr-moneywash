local QBCore = exports['qb-core']:GetCoreObject()
local time = Config.Time

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
            local coords = vector3(Config.Locations[k].coords.x, Config.Locations[k].coords.y, Config.Locations[k].coords.z)
            local dist = #(PlayerPos - coords)
            if dist < 15 then
                inRange = true
                
                if dist < 0.5 then
                    if Config.Locations[k].useing == -1 then
                        DrawText3D(coords.x, coords.y, coords.z, Lang:t("text3d.3dtext"))
                        if IsControlJustReleased(0, Config.key) then
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

RegisterNetEvent("cr-moneywash:client:startTimer")
AddEventHandler("cr-moneywash:client:startTimer", function(worth, k)
    text(k, worth)
    Config.Locations[k].useing = time
    while Config.Locations[k].useing > 0 do
        Wait(1000)
        Config.Locations[k].useing = Config.Locations[k].useing - 1
    end
end)

function text(k, worth)
    CreateThread(function()
        local coords = vector3(Config.Locations[k].coords.x, Config.Locations[k].coords.y, Config.Locations[k].coords.z)
        while Config.Locations[k].useing ~= -1 do 
            local PlayerPed = PlayerPedId()
            local PlayerPos = GetEntityCoords(PlayerPed)
            local dist = #(PlayerPos - coords)
            local sleep = 1
            local inrange = false
            if dist < 15 then
                inrange = true
                if dist < 0.5 then
                    if Config.Locations[k].useing > 0 then
                        DrawText3D(coords.x, coords.y, coords.z, Lang:t("text3d.3dtext_left", {timeleft = Config.Locations[k].useing}))
                    elseif Config.Locations[k].useing == 0 then
                        DrawText3D(coords.x, coords.y, coords.z, Lang:t("text3d.3dtext_done"))
                        if IsControlJustPressed(0, Config.key) then
                            washing = false
                            -- time = Config.Time
                            TriggerServerEvent("cr-moneywash:server:GiveMoney", worth, k)
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

RegisterNetEvent("cr-moneywash:client:resetWash")
AddEventHandler("cr-moneywash:client:resetWash", function(k)
    Config.Locations[k].useing = -1
end)