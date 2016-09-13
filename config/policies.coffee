
module.exports = 
	policies:
		RecordController:
			'*':		false
			find:		['isAuth']
			findOne:	['isAuth']
			create:		['isAuth', 'setOwner']
			update:		['isAuth', 'setHandlerNDate']