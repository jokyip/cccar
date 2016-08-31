
module.exports = 
	policies:
		RecordController:
			'*':		false
			create:		['isAuth', 'setOwner']