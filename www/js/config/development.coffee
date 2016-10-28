io.sails.url = 'http://10.30.224.82:8030'
io.sails.path = "/cccar/socket.io"
io.sails.useCORSRouteToGetCookie = false
    
module.exports =
	isMobile: ->
		/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)
	isNative: ->
		/^file/i.test(document.URL)
	platform: ->
		if @isNative() then 'mobile' else 'browser'
	authUrl:	'https://mob.myvnc.com'
	
	path: 'cccar'		
	oauth2:
		authUrl: "#{@authUrl}/org/oauth2/authorize/"
		opts:
			authUrl: "https://mob.myvnc.com/org/oauth2/authorize/"
			response_type:  "token"
			scope:          "https://mob.myvnc.com/org/users"
			client_id:      'cccarDEV'
			
	orgChartUrl:	'http://10.30.224.82:8020'
	myOrgchartUrl: '#{@orgChartUrl}/api/user/me'					