local QBCore = exports[Config.CoreName]:GetCoreObject()

QBCore.Functions.CreateCallback('rv_blackmarket:server:HasVpnItem', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Player.Functions.GetItemByName(Config.VpnItem)
    if item == nil then
        TriggerClientEvent('QBCore:Notify', src, Locale.Error.need_vpn, 'error')
        cb(false)
        return
    end
    cb(true)
end)

QBCore.Functions.CreateCallback('rv_blackmarket:server:HasBlackmarketLaptop', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Player.Functions.GetItemByName(Config.LaptopItem)
    if item == nil then
        TriggerClientEvent('QBCore:Notify', src, Locale.Error.need_laptop, 'error')
        cb(false)
        return
    end
    cb(true)
end)

QBCore.Functions.CreateCallback('rv_blackmarket:server:HasThermite', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Player.Functions.GetItemByName(Config.ThermiteItem)
    if item == nil then
        TriggerClientEvent('QBCore:Notify', src, Locale.Error.need_thermite, 'error')
        return
    end
    Player.Functions.RemoveItem(Config.ThermiteItem, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.ThermiteItem], 'remove')
    cb(true)
end)

RegisterNetEvent('rv_blackmarket:server:TakeVpnItem', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(Config.VpnItem, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.VpnItem], 'remove')
end)

RegisterNetEvent('rv_blackmarket:server:GiveLaptopItem', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(Config.LaptopItem, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.LaptopItem], 'add')
end)