Promise = require 'promise'
actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports = (req, res) ->
	pk = actionUtil.requirePk(req)
	Model = actionUtil.parseModel(req)
	data = actionUtil.parseValues(req)
	
	sails.log.warn data
	Model.update({id: pk},data)
		.then (updatedRecords) ->
			updatedRecord = updatedRecords[0]
			sails.log 'Update.coffee is called'
			sails.log updatedRecord
			if data.goNext  
				sails.log.warn 'Going to complete task'
				sails.services.rest().token sails.config.oauth2.tokenURL, sails.config.todo.client, sails.config.todo.user, sails.config.todo.scope
					.then (tokenResult) ->
						todoData =
							progress: 100
							type: 'activiti'
							taskId: updatedRecord.taskId
						sails.log 'todoData'	
						sails.log todoData
						sails.services.rest().put tokenResult.body.access_token, "#{sails.config.todo.url}/#{updatedRecord.todoId}", todoData
							.then (todoResult) ->
								sails.log 'Todo updated'
							.catch (err) ->
								sails.log.error err
			res.ok updatedRecord
		.catch (err) ->
			sails.log.error err
			res.serverError err