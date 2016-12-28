angular.module("site").service("FacebookService"
->
	facebookAppId = 505787579524800
	fbAsyncInit = ->
		FB.init(
			appId: facebookAppId
			status: false
			cookie: true
			xfbml: true
			version: 'v2.0'
		)
		fbAsyncInit.facebookLoadedPromise.resolve()
	fbAsyncInit.facebookLoadedPromise = $.Deferred()

	window.fbAsyncInit = fbAsyncInit

	((d, s, id) ->
		fjs = d.getElementsByTagName(s)[0]
		return  if d.getElementById(id)
		js = d.createElement(s)
		js.id = id
		js.src = "//connect.facebook.net/en_US/sdk.js"
		fjs.parentNode.insertBefore(js, fjs)
		return
	)( document, "script", "facebook-jssdk" )

	class FacebookService
		constructor: ->
			@facebookAppId = facebookAppId
			@facebookLoadedPromise = fbAsyncInit.facebookLoadedPromise

	return new FacebookService()
)

angular.module("site").service("SiteService"
($location, $rootScope, ArtPiecesService, GalleriesService, FacebookService) ->
	class SiteService
		constructor: ->
			@siteUrl = "http://www.sbentleyart.com"
			$rootScope.$on('$stateChangeSuccess', =>
				$("html, body").animate(scrollTop: 0 , 200)
				$rootScope.metaTags.url = @getUrl()
			)

		getUrl: () =>
			$location.absUrl().replace("http://localhost:9000", @siteUrl)

		goToFacebookSite: ->
			window.open("https://www.facebook.com/sbentleystudio?ref=hl")

		setGalleryMetaTags: (gallery) =>
			$rootScope.metaTags.image = @getLowResGalleryUrl(gallery)

		setArtPieceMetaTags: (artPiece) =>
			$rootScope.metaTags.image = @getLowResArtPieceUrl(artPiece)

		getLowResGalleryUrl: (gallery) =>
			@siteUrl + "/" + GalleriesService.getGalleryPath(gallery)

		getLowResArtPieceUrl: (artPiece) =>
			@siteUrl + "/" + ArtPiecesService.getLowResPath(artPiece)

		shareToFacebook: (artPiece) =>
			caption = artPiece.name
			{description} = artPiece
			caption ?= "Sarah Bentley Art"
			description ?= "Sarah Bentley Art"

			FB.XFBML.parse()
			FB.login( (response) =>
				if( response.authResponse)
					console.log """Logged in #{response}"""
					FB.getLoginStatus( (response) =>
						if (response.status == 'connected')
							uid = response.authResponse.userID
							accessToken = response.authResponse.accessToken
							FB.api('/me/feed', 'post', {
								app_id: FacebookService.facebookAppId
								link: @getUrl()
								picture: @getLowResArtPieceUrl(artPiece)
								description
								message: 'I like this'
							}
							(response) ->
								console.log response
							)
						else if (response.status == 'not_authorized')
							console.error "The user is logged in to Facebook,  but has not authenticated your app"
						else
							console.error "The user isn't logged in to Facebook."
					 )
				else
					console.error "The user cancelled login or did not authorize"
			scope: 'publish_actions'
			)
	return new SiteService()
)
