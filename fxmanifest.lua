fx_version 'cerulean'
game 'gta5'

description 'cr-moneywash'
version '1.0.1'

server_script 'server/*.lua'

client_script 'client/*.lua'

shared_scripts {
	'@qb-core/shared/locale.lua',
	 'config.lua',
	 'locales/en.lua', -- change to your language
}

lua54 'yes'