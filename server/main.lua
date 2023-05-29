local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent("cr-moneywash:server:checkinv", function(k)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local markedBills = Player.Functions.GetItemByName("markedbills")
    
    if markedBills ~= nil then
        local amt = markedBills.amount
        local worth = markedBills.info.worth * amt
        worth = worth * Config.percent
        Player.Functions.RemoveItem('markedbills', amt)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['markedbills'], "remove")
        TriggerClientEvent('cr-moneywash:client:startTimer', src, worth, k)
        TriggerClientEvent('QBCore:Notify', src, Lang:t("notify.Start_washing", {value = worth}), 'primary')
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("notify.no_markedbills"), "error")
    end
end)

RegisterServerEvent("cr-moneywash:server:GiveMoney", function(worth)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    if player then
        player.Functions.AddMoney("cash", worth)
    end
end)
