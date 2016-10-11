actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports = (req, res) ->
	Model = actionUtil.parseModel(req)
	pk = actionUtil.requirePk(req)
	
	Model.findOne(pk)
		.populateAll()
		.then (matchingRecord) ->    	
			if !matchingRecord
				res.notFound('No record found with the specified `id`.')
			if matchingRecord.nextHandler == req.user.username || matchingRecord.status == 'Draft'
				matchingRecord.showAction = true
			res.ok matchingRecord
		.catch res.serverError 	