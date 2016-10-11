
module.exports = 
	policies:
		RecordController:
			'*':		false
			find:		['isAuth', 'setOwner']
			findOne:	['isAuth']
			create:		['isAuth', 'setOwner']
			update:		['isAuth', 'setHandlerNDate']
		WebhookController:
			'*':		false
			find:		['isAuth']
			findOne:	['isAuth']
			create:		['isAuth', 'setOwner']
				