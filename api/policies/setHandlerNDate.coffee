module.exports = (req, res, next) ->
	req.options.values = req.options.values || {}
	sails.log req.body.goNext	
	if req.body.goNext
		sails.log req.body.nextAction
		switch req.body.nextAction
			when "Issue" then req.options.values.issuedBy = req.user.username
			when "Endorse" then req.options.values.endorsedBy = req.user.username
			when "Approve" then req.options.values.approvedBy = req.user.username
		if req.options.values.issuedBy
			req.options.values.issuedAt = new Date
		if req.options.values.endorsedBy
			req.options.values.endorsedAt = new Date
		if req.options.values.approvedBy
			req.options.values.approvedAt = new Date
	next()