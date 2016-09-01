util = require 'util'
env = require './env.coffee'

require './model.coffee'

angular.module 'starter.controller', [ 'ionic', 'http-auth-interceptor', 'ngCordova',  'starter.model', 'platform', 'toaster']
		
	.run (toaster) ->
		window.alert = (msg) ->
			toaster.pop
				type:			'error'
				body:			util.inspect(msg)
				bodyOutputType: 'trustedHtml'	

	.controller 'MenuCtrl', ($scope) ->
		$scope.env = env
		$scope.navigator = navigator

	.controller 'RegistrationListCtrl', ($scope, collection) ->
		_.extend $scope,
			collection: collection

	.controller 'RegistrationCtrl', ($scope, model, $location) ->
		_.extend $scope,
			model: model
			save: ->
				$scope.model.$save()
					.then ->
						alert 'Saved!'
					.catch ->
						alert 'Error!'	