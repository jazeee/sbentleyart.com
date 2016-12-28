angular.module("banner").directive('banner'
(SiteService, FacebookService, ArtPiecesService) ->
	return {
		restrict: "E"
		replace: true
		templateUrl: "banner/banner.html"
		link: (scope, element, attributes) ->
			scope.askAQuestion = ->
				FB.ui(
					method: 'send'
					app_id: FacebookService.facebookAppId
					link: SiteService.getUrl()
					to: 1425182015
				)

			scope.goToFacebookSite = SiteService.goToFacebookSite

			scope.artDealOfTheDay = ArtPiecesService.artDealOfTheDay

			scope.randomArtPiece = ArtPiecesService.randomArtPiece

			scope.getLowResPathAsUrl = ArtPiecesService.getLowResPathAsUrl

			scope.artPieceOfTheDayAsUrl = ArtPiecesService.getLowResPathAsUrl(ArtPiecesService.artDealOfTheDay)

			scope.goToArtPiece = ArtPiecesService.goToArtPiece
	}
)
