actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports = (req, res) ->
	Model = actionUtil.parseModel req
	cond = actionUtil.parseCriteria req
	count = Model.count()
		.where( cond )
		.toPromise()
	query = Model
		.find()
		.where cond
		.limit actionUtil.parseLimit(req)
		.skip actionUtil.parseSkip(req)
		.sort actionUtil.parseSort(req)

	Promise.all([count, query])
		.then (data) ->
			res.ok
				count:		data[0]
				results:	data[1]
		.catch res.serverError			