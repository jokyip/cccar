 # Webhook.coffee
 #
 # @description :: TODO: You might write a short summary of how this model works and what it represents here.
 # @docs        :: http://sailsjs.org/documentation/concepts/models-and-orm/models

module.exports =

	tableName:	'webhooks'
	
	schema:		true
	
	autoPK:		true

	attributes:
		cccarId:
			type:	'string'
			
		event:
			type:	'string'
			
		method:
			type:	'string'	
	
		callbackUrl:
			type:	'string'
			
		data:
			type:	'json'
			
	beforeValidate: (values, cb) ->
		@destroy cccarId:values.cccarId, event:values.event
			.then (result) ->				
		  		if (result)
		    		sails.log('Webhook deleted')		  		
				cb()