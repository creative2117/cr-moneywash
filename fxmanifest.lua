fx_version 'cerulean'
game 'gta5'

description 'cr-moneywash'
version '1.0.0'

server_script 'server/main.lua'

client_script 'client/main.lua'

shared_scripts {
	'@qb-core/shared/locale.lua',
	 'config.lua',
	 'locales/sv.lua', -- change to your language
}

lua54 'yes'