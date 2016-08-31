 # Visitor.coffee
 #
 # @description :: TODO: You might write a short summary of how this model works and what it represents here.
 # @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models

module.exports =

  	tableName:	'visitors'
  
  	schema:		true
	
	autoPK:		true

	attributes:
		name:
			type:	'string'
			required: true
			
		idType:
			type:	'string'
			enum:	['hkid','staffId']
			defaultTo:	'staffId'
			
		idNo:
			type:	'string'
			
		company:
			type:	'string'
			
		startDate:
			type: 	'datetime'
			defaultTo: ->
				new Date
			
		endDate:
			type: 	'datetime'
			defaultTo: ->
				new Date	