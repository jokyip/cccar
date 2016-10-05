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

	.controller 'RegistrationCtrl', ($scope, model, canEdit, id, $location, $state) ->
		if !canEdit
			$location.url "/cccar/#{id}"
		_.extend $scope,
			model: model
			location: ['WCDC','TWDC']
			save: ->
				$scope.model.$save()
					.then ->
						alert "Saved"
					.catch (err) ->
						alert "Error: #{err}"
			submit: ->
				$scope.model.showAction = false
				$scope.model.goNext = true
				$scope.model.$save()
					.then ->						
						alert "#{$scope.model.nextAction}d successfully."
						$location.url "/cccar/#{id}"					
					.catch (err) ->
						alert "Error: #{err}"				