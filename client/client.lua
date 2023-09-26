local QBCore = exports[Config.CoreName]:GetCoreObject()
local Vpn = false

Citizen.CreateThread(function()
    exports[Config.TargetName]:AddBoxZone('internet-disturbance', Config.InternetDisturbance.Coords, 1.5, 1.6, {
        name = "internet-disturbance",
        heading = Config.InternetDisturbance.Heading,
        debugPoly = false
    }, {
        options = {
            {
                type = "client",
                event = "rv_blackmarket:client:InternetDisturbance",
                icon = "fas fa-globe",
                label = Config.InternetDisturbance.Label
            }
        }
    })    
end)

RegisterNetEvent('rv_blackmarket:client:InternetDisturbance', function()
    if Vpn then
        QBCore.Functions.Notify(Locale.Error.vpn_on, 'error', 5000)
        return
    end
    local p = promise.new()
    local allowed
    QBCore.Functions.TriggerCallback('rv_blackmarket:server:HasVpnItem', function(result)
        p:resolve(result)
    end)
    allowed = Citizen.Await(p)
    if not allowed then
        return
    end
    QBCore.Functions.Progressbar("connecting", Locale.Info.connecting_vpn, 7500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true
    }, {
    }, {}, {}, function() -- Done
        exports['hacking']:OpenHackingGame(12, 3, 1, function(Success)
            TriggerServerEvent('rv_blackmarket:server:TakeVpnItem')
            if not Success then
                QBCore.Functions.Notify(Locale.Error.couldnt_enable_vpn, 'error', 5000) 
                return
            end
            Vpn = true
            lib.registerContext({
                id = 'vpn_locations',
                title = Locale.Info.vpn_locations,
                options = {
                    {
                        title = Locale.Info.united_states,
                        description = Locale.Info.united_states_desc,
                        icon = 'globe',
                        onSelect = function()
                            TriggerEvent('rv_blackmarket:client:VpnConnected', Locale.Info.united_states)
                        end
                    },
                    {
                        title = Locale.Info.russia,
                        description = Locale.Info.russia_desc,
                        icon = 'globe',
                        onSelect = function()
                            TriggerEvent('rv_blackmarket:client:VpnConnected', Locale.Info.russia)
                        end
                    },
                    {
                        title = Locale.Info.united_kingdom,
                        description = Locale.Info.united_kingdom_desc,
                        icon = 'globe',
                        onSelect = function()
                            TriggerEvent('rv_blackmarket:client:VpnConnected', Locale.Info.united_kingdom)
                        end
                    },
                    {
                        title = Locale.Info.japan,
                        description = Locale.Info.japan_desc,
                        icon = 'globe',
                        onSelect = function()
                            TriggerEvent('rv_blackmarket:client:VpnConnected', Locale.Info.japan)
                        end
                    },                
                },
            })
            lib.showContext('vpn_locations')
        end)
    end, function() -- Cancel
    end)
    
    
end)

RegisterNetEvent('rv_blackmarket:client:VpnConnected', function(location)
    QBCore.Functions.Notify(string.gsub(Locale.Success.connected_to, 'location', location), 'success', 5000)
    TriggerServerEvent(Config.PhoneMailEvent, {
        sender = Locale.Info.mail_sender,
        subject = Locale.Info.first_mail_subject,
        message = Locale.Info.first_mail_message,
        button = {}
    })
    exports[Config.TargetName]:AddBoxZone('fusebox', Config.Fusebox.Coords, 1.5, 1.6, {
        name = "fusebox",
        heading = Config.Fusebox.Heading,
        debugPoly = false
    }, {
        options = {
            {
                type = "client",
                event = "rv_blackmarket:client:BlowFusebox",
                icon = "fas fa-fire",
                label = Config.Fusebox.Label
            }
        }
    }) 
end)

RegisterNetEvent('rv_blackmarket:client:BlowFusebox', function()
    local p = promise.new()
    local allowed
    QBCore.Functions.TriggerCallback('rv_robberies:server:HasThermite', function(result)
        p:resolve(result)
    end)
    allowed = Citizen.Await(p)
    if not allowed then
        return
    end
    LoadAnimDict("amb@prop_human_bum_bin@idle_b")
    TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 4.0, 4.0, -1, 50, 0, false, false, false)
    QBCore.Functions.Progressbar("blowing_fusebox", Locale.Info.blowing_fusebox, 7500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true
    }, {
    }, {}, {}, function() -- Done
        LoadAnimDict("amb@prop_human_bum_bin@idle_b")
        TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "exit", 4.0, 4.0, -1, 50, 0, false, false, false)
        exports["memorygame"]:thermiteminigame(10, 5, 3, 15,
        function()
            TriggerServerEvent('rv_blackmarket:server:GiveLaptopItem')
            TriggerServerEvent(Config.PhoneMailEvent, {
                sender = Locale.Info.mail_sender,
                subject = Locale.Info.second_mail_subject,
                message = Locale.Info.second_mail_message,
                button = {}
            })
            SpawnBlackmarket()
        end,
        function()
            QBCore.Functions.Notify(Locale.Error.couldnt_blow_fusebox, 'error', 5000)
        end)
    end, function() -- Cancel
    end)
end)

RegisterNetEvent('rv_blackmarket:client:BlackmarketAccess', function()
    local p = promise.new()
    local allowed
    QBCore.Functions.TriggerCallback('rv_blackmarket:server:HasBlackmarketLaptop', function(result)
        p:resolve(result)
    end)
    allowed = Citizen.Await(p)
    if not allowed then
        return
    end
    local items = {
        label = Config.Blackmarket.Label,
        slots = Config.Blackmarket.Slots,
        items = Config.Blackmarket.Items
    }
    TriggerServerEvent('inventory:server:OpenInventory', 'shop', Config.Blackmarket.Label, items)
end)

function SpawnBlackmarket()
    RequestModel(GetHashKey(Config.BlackmarketNpc.Ped.Model))
    while not HasModelLoaded(GetHashKey(Config.BlackmarketNpc.Ped.Model)) do
        Wait(1)
    end
    local ped = CreatePed(5, GetHashKey(Config.BlackmarketNpc.Ped.Model), Config.BlackmarketNpc.Ped.Coords, false, false)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    exports['qb-target']:AddBoxZone('blackmarket-access', Config.BlackmarketNpc.Target.Coords, 1.5, 1.6, {
        name = "blackmarket-access",
        heading = Config.BlackmarketNpc.Target.Heading,
        debugPoly = false
    }, {
        options = {
            {
                type = "client",
                event = "rv_blackmarket:client:BlackmarketAccess",
                icon = "fas fa-gun",
                label = Config.BlackmarketNpc.Target.Label
            }
        }
    })
end

function LoadAnimDict(dict)
    if HasAnimDictLoaded(dict) then return end
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end