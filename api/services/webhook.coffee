http = require 'needle'

module.exports =
	callback: (cccarId, event, user) ->
		cond =
			cccarId:	cccarId
			event:		event
		sails.log.warn cond	
		sails.models.webhook
			.findOne cond
			.populateAll()
			.then (obj) ->
				sails.log.warn obj
				sails.log.warn user.token
				sails.services.rest()[obj.method] user.token, obj.callbackUrl, obj.data
			.then (cbResult) ->
				sails.log cbResult.statusCode	
				sails.log cbResult.body
			.catch (err) ->
				sails.log.error err