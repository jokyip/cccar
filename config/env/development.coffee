winston = require 'winston'

module.exports =
	hookTimeout:	400000
	
	port:			1337
		
	oauth2:
		verifyURL:			"https://mob.myvnc.com/org/oauth2/verify/"
		tokenURL:			"https://mob.myvnc.com/org/oauth2/token/"
		scope:				["https://mob.myvnc.com/org/users"]

	promise:
		timeout:	10000 # ms

	models:
		connection: 'mongo'
		migrate:	'alter'
	
	connections:
		mongo:
			adapter:	'sails-mongo'
			driver:		'mongodb'
			url: 'mongodb://cccar_mongo/cccar' #dev
			
	todo:
		url: 		"http://10.30.224.82:8010/api/todo"
		client:
			id:		'todomsgUATAuth'
			secret: 'pass1234'
		user:
			id: 	'todoadmin'
			secret: 'pass1234'
		scope:  	[ "https://mob.myvnc.com/org/users", "https://mob.myvnc.com/mobile"]		
	
	log:
		level:		'silly'
		custom: new winston.Logger
			transports: [
				new winston.transports.Console
					level:		'silly'
					timestamp:	true
			]
		
			