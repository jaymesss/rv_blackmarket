
Copy the images in the /images directory to `qb-inventory/html/images`

Add the following to your qb-core/shared/items.lua:

['vpn'] = {['name'] = 'vpn', ['label'] = 'VPN Servers', ['weight'] = 100, ['type'] = 'item', ['image'] = 'vpn.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Use this for connecting your VPN.'},
['vpn_laptop'] = {['name'] = 'vpn_laptop', ['label'] = 'VPN Servers', ['weight'] = 100, ['type'] = 'item', ['image'] = 'vpn_laptop.png', ['unique'] = false, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['description'] = 'Beaver Dam!'},