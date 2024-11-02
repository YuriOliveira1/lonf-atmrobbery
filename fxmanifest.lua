fx_version 'cerulean'
games { 'gta5' }

author 'Yuri de Oliveira'
description 'Atm Robbery For QBX'
version '1.0.0'

dependencies {
    'qbx_core',
    'ox_lib',
	'ox_inventory'
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
    '@qbx_core/modules/playerdata.lua',
}

server_scripts {
    'server/server.lua'
}

client_scripts {
    'client/client.lua'
}

lua54 'yes'
