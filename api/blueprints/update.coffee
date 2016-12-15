Promise = require 'promise'
actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports = (req, res) ->
	pk = actionUtil.requirePk(req)
	Model = actionUtil.parseModel(req)
	data = actionUtil.parseValues(req)

	Model.update({id: pk},data)
		.then (updatedRecords) ->
			updatedRecord = updatedRecords[0]
			if data.goNext				
				sails.services.webhook.callback pk, data.nextAction, req.user
			res.ok updatedRecord
		.catch (err) ->
			res.serverError err