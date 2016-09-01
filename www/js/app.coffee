env = require './env.coffee'

angular.module 'starter', ['ngFancySelect', 'ionic', 'util.auth', 'starter.controller', 'starter.model', 'http-auth-interceptor', 'ngTagEditor', 'ActiveRecord', 'ngTouch', 'ngAnimate', 'pascalprecht.translate', 'locale', 'toaster']
	
	.run (authService) ->
		authService.login env.oauth2.opts
	        
	.run ($rootScope, platform, $ionicPlatform, $location, $http) ->
		$ionicPlatform.ready ->
			if (window.cordova && window.cordova.plugins.Keyboard)
				cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true)
			if (window.StatusBar)
				StatusBar.styleDefault()
						
	.config ($stateProvider, $urlRouterProvider, $translateProvider) ->
	
		$stateProvider.state 'app',
			url: ""
			abstract: true
			templateUrl: "templates/menu.html"
	
		$stateProvider.state 'app.create',
			url: "/cccar/create"
			cache: false
			views:
				'menuContent':
					templateUrl: "templates/registration/create.html"
					controller: 'RegistrationCtrl'
			resolve:
				resources: 'resources'
				model: (resources) ->
					new resources.Record()				
	
		$stateProvider.state 'app.edit',
			url: "/cccar/edit/:id"
			cache: false
			views:
				'menuContent':
					templateUrl: "templates/registration/edit.html"
					controller: 'RegistrationCtrl'
			resolve:
				id: ($stateParams) ->
					$stateParams.id
				resources: 'resources'
				model: (resources, id) ->
					ret = new resources.Record({id: id})
					ret.$fetch()			
		
		$stateProvider.state 'app.read',
			url: "/cccar/:id"
			cache: false
			views:
				'menuContent':
					templateUrl: "templates/registration/read.html"
					controller: 'RegistrationCtrl'
			resolve:
				id: ($stateParams) ->
					$stateParams.id
				resources: 'resources'
				model: (resources, id) ->
					ret = new resources.Record({id: id})
					ret.$fetch()
					
		$urlRouterProvider.otherwise('/cccar/create');
		