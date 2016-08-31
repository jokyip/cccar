 # Record.coffee
 #
 # @description :: TODO: You might write a short summary of how this model works and what it represents here.
 # @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models

module.exports =

	tableName:	'records'
	
	schema:		true
	
	autoPK:		true

	attributes:
		number:
			type:	'integer'
			unique: true
			autoIncrement: true
			defaultTo:	0
			
		status:
			type:	'string'
			defaultTo:	'Draft'

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
			
		endorsedBy:
			type:	'string'
			
		endorsedAt:
			type: 	'datetime'
			defaultTo: ->
				new Date
			
		approvedBy:
			type:	'string'
			
		approvedAt:
			type: 	'datetime'
			defaultTo: ->
				new Date		