 # History.coffee
 #
 # @description :: TODO: You might write a short summary of how this model works and what it represents here.
 # @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models

module.exports =

	tableName:	'historys'
	
	schema:		true
	
	autoPK:		true

	attributes:
		cccarId:
			type:	'string'
			
		msg:
			type:	'string'
			
		msgAt:
			type: 	'datetime'	