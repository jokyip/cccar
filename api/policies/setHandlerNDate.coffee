module.exports = (req, res, next) ->
	req.options.values = req.options.values || {}
	if req.body.goNext
		switch req.body.nextAction
			when "Issue" then req.options.values.issuedBy = req.user.username
			when "Endorse" then req.options.values.endorsedBy = req.user.username
			when "Approve" then req.options.values.approvedBy = req.user.username
			when "Withdraw" then req.options.values.withdrawnBy = req.user.username
			when "Reject" then req.options.values.rejectedBy = req.user.username
		if req.options.values.issuedBy
			req.options.values.issuedAt = new Date
		if req.options.values.endorsedBy
			req.options.values.endorsedAt = new Date
		if req.options.values.approvedBy
			req.options.values.approvedAt = new Date
		if req.options.values.withdrawnBy
			req.options.values.withdrawnAt = new Date
		if req.options.values.rejectedBy
			req.options.values.rejectedAt = new Date		
	next()