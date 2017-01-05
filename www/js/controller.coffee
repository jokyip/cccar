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
		window.info = (msg) ->
			toaster.pop
				type:			'info'
				body:			util.inspect(msg)
				bodyOutputType: 'trustedHtml'		
				

	.controller 'MenuCtrl', ($scope) ->
		$scope.env = env
		$scope.navigator = navigator

	.controller 'RegistrationListCtrl', ($scope, collection, $state) ->
		_.extend $scope,
			collection: collection
			doRefresh: ->
				$state.go($state.current, {}, {reload: true});
			openurl: (model) ->				
				url = "#/cccar/#{model.id}"
				if model.status == 'Draft'
					url = "#/cccar/edit/#{model.id}"
				window.open(url, '_blank')	
			loadMore: ->
				collection.$fetch()
					.then ->
						$scope.$broadcast('scroll.infiniteScrollComplete')
					.catch alert						

	.controller 'RegistrationCtrl', ($scope, model, historys, canEdit, id, $location, $http, $timeout, $state) ->
		if !canEdit
			$location.url "/cccar/#{id}"
		_.extend $scope,
			model: model
			historys: historys
			location: ['WCDC','TWDC']
			reject: ->
				$scope.model.showAction = false
				$scope.model.goNext = true
				$scope.model.nextAction = 'Reject'
				$scope.model.$save()
					.then ->
						info "Rejected"
						$timeout (=> $state.reload()), env.loadPage.timeout
					.catch (err) ->
						alert "Error: #{err}"
			withdraw: ->
				$scope.model.showAction = false
				$scope.model.goNext = true
				$scope.model.nextAction = 'Withdraw'
				$scope.model.$save()
					.then ->
						info "Withdrawn"
						if !canEdit
							$timeout (=> $state.reload()), env.loadPage.timeout
						else		
							$timeout (=> $location.url "/cccar/#{id}"), env.loadPage.timeout
					.catch (err) ->
						alert "Error: #{err}"
			save: ->
				$scope.model.$save()
					.then ->
						info "Saved"
					.catch (err) ->
						alert "Error: #{err}"
			submit: ->
				$scope.model.showAction = false
				$scope.model.goNext = true
				$scope.model.$save()
					.then ->						
						info "#{$scope.model.nextAction}d successfully."
						if !canEdit
							$timeout (=> $state.reload()), env.loadPage.timeout
						else		
							$timeout (=> $location.url "/cccar/#{id}"), env.loadPage.timeout					
					.catch (err) ->
						alert "Error: #{err}"
						
	.filter 'regFilter', ->
		(collection, search) ->
			r = new RegExp(search, 'i')
			if search
				return _.filter collection, (item) ->
					r.test(item?.status)
			else
				return collection					
						
	.filter 'keywordFilter', ->
		(collection, search) ->
			r = new RegExp(search, 'i')
			if search
				return _.filter collection, (item) ->
					r.test(item?.number) or r.test(item?.project) or r.test(item?.status)
			else
				return collection