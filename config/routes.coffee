module.exports = 
	routes:
		'GET /api/record':
			controller:		'RecordController'
			action:			'find'
			sort:			
				number:	'desc'