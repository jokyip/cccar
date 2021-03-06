_ = require 'lodash'
http = require 'needle'
Promise = require 'bluebird'
util = require 'util'

###
options = 
	timeout:	10000
	agent:		new agent('http://proxy1.scig.gov.hk:8080')
###
module.exports = (options = sails.config.http.opts || {}) ->
	
	get: (token, url) ->
		new Promise (fulfill, reject) ->
			opts =
				headers:
					Authorization:	"Bearer #{token}"
			_.extend opts, options
			http.get url, opts, (err, res) ->
				if err
					return reject err
				fulfill res
				
	post: (token, url, data) ->
		new Promise (fulfill, reject) ->
			opts =
				headers:
					Authorization:	"Bearer #{token}"
			_.extend opts, options
			http.post url, data, opts, (err, res) ->
				if err
					return reject err
				fulfill res
				
	put: (token, url, data) ->
		new Promise (fulfill, reject) ->
			opts =
				headers:
					Authorization:	"Bearer #{token}"
			_.extend opts, options
			http.put url, data, opts, (err, res) ->
				if err
					return reject err
				fulfill res			
					
	push: (token, roster, msg) ->
		# ensure roster.createdBy is populated
		rosterReady = (roster) ->
			if typeof roster.createdBy == 'string'
				sails.models.roster
					.findOne roster.id
					.populateAll()
			else
				Promise.resolve roster
				
		rosterReady(roster)
			.then (roster) ->
				data = _.mapValues sails.config.push.data, (value) ->
					_.template(value) {roster: roster, msg:	msg}
				sails.services.rest()
					.post token, sails.config.push.url, 
						users:	[roster.createdBy.email]
						data:	data
					.then (res) ->
						sails.log.debug util.inspect data
						sails.log.info util.inspect res.body
						Promise.resolve res
			.catch (err) ->
				sails.log.error err
				Promise.reject err
			
	gcmPush: (users, data) ->
		new Promise (fulfill, reject) ->
			opts = 
				headers:
					Authorization: 	"key=#{sails.config.push.gcm.apikey}"
					'Content-Type': 'application/json'
				json:		true
			_.extend opts, options
			devices = []
			_.each users, (user) ->
				_.each user.devices, (device) ->
					devices.push device.regid 
			defaultMsg =
				title:		'Instant Messaging'
				message:	' '
			data =
				registration_ids:	_.uniq(devices)
				data:				_.extend defaultMsg, data
			http.post sails.config.push.gcm.url, data, opts, (err, res) =>
				if err
					return reject(err)
				fulfill(res.body)
				
	# get token for Resource Owner Password Credentials Grant
	# url: 	authorization server url to get token 
	# client:
	#	id: 	registered client id
	#	secret:	client secret
	# user:
	#	id:		registered user id
	#	secret:	user password
	# scope:	[ "https://mob.myvnc.com/org/users", "https://mob.myvnc.com/mobile"]
	token: (url, client, user, scope) ->
		opts = 
			'Content-Type':	'application/x-www-form-urlencoded'
			username:		client.id
			password:		client.secret
		_.extend opts, options
		data =
			grant_type: 	'password'
			username:		user.id
			password:		user.secret 
			scope:			scope.join(' ')
		new Promise (fulfill, reject) ->
			http.post url, data, opts, (err, res) ->
				if err
					return reject err
				fulfill res
