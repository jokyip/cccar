Promise = require 'promise'
actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports = (req, res) ->
	pk = actionUtil.requirePk(req)
	Model = actionUtil.parseModel(req)
	data = actionUtil.parseValues(req)
	
	sails.log data
	sails.log req.user
	Model.update({id: pk},data)
		.then (updatedRecords) ->
			updatedRecord = updatedRecords[0]
			sails.log updatedRecord
			if data.goNext
				sails.log.warn 'Trigger webhook'
				sails.services.webhook.callback pk, data.nextAction, req.user
			res.ok updatedRecord
		.catch (err) ->
			sails.log.error err
			res.serverError err