 # Record.coffee
 #
 # @description :: TODO: You might write a short summary of how this model works and what it represents here.
 # @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models

module.exports =

	tableName:	'records'
	
	schema:		true
	
	autoPK:		true

	attributes:
		location:
			type:	'string'
			enum:	['WCDC','TWDC']
			
		number:
			type:	'integer'
			unique: true
			
		status:
			type:	'string'
			defaultsTo:	'Draft'

		project:
			type:	'string'
			
		purpose:
			type:	'string'
			
		detail:
			type:	'string'
			
		area:
			type:	'string'
			
		cabinet:
			type:	'string'
			
		visitors:
			collection:	'visitor'
		
		createdBy:
			type:	'string'	
			
		issuedBy:
			type:	'string'
			
		issuedAt:
			type: 	'datetime'	
			
		endorsedBy:
			type:	'string'
			
		endorsedAt:
			type: 	'datetime'
			
		approvedBy:
			type:	'string'
			
		approvedAt:
			type: 	'datetime'
			
		nextHandler:
			type:	'string'	
			
	beforeUpdate: (values, cb) ->
		if values.issuedBy
			values.issuedAt = new Date
		if values.endorsedBy
			values.endorsedAt = new Date
		if values.approvedBy
			values.approvedAt = new Date		
		cb()		