Config = {}
Config.CoreName = "qb-core"
Config.TargetName = "qb-target"
Config.PhoneMailEvent = "qb-phone:server:sendNewMail"
Config.VpnItem = 'vpn'
Config.LaptopItem = 'vpn_laptop'
Config.ThermiteItem = 'thermite'
Config.InternetDisturbance = {
    Coords = vector3(-1063.27, -246.53, 43.95),
    Heading = 300,
    Label = "Internet Disturbance"
}
Config.Fusebox = {
    Coords = vector3(1665.12, -0.75, 166.12),
    Heading = 220,
    Label = 'Disrupt Internal Systems'
}
Config.BlackmarketNpc = {
    Ped = {
        Coords = vector4(-1763.52, -259.84, 48.33, 153.05),
        Model = 'a_f_m_prolhost_01'
    },
    Target = {
        Coords = vector3(-1763.52, -259.84, 49.33),
        Heading = 330,
        Label = "Connect to the abyss"
    }
}
Config.Blackmarket = {
    Label = 'Blackmarket Items',
    Slots = 40,
    Items = {
        { name = 'binoculars', price = 5000, amount = 1, type = "item", slot = 1, info = {} },
        { name = 'weapon_pistol', price = 10000, amount = 1, type = "weapon", slot = 2, info = {} },
    }
}