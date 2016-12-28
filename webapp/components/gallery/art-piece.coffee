angular.module("galleries").directive('artPiece'
($state, ArtPiecesService)->
	restrict: "E"
	replace: true
	templateUrl: "gallery/art-piece.html"
	scope:
		artPiece: '='
		galleryId: '='
	link: (scope, element, attributes) ->
		scope.getLowResPath = ArtPiecesService.getLowResPath
		
		scope.goToArtPiece = ArtPiecesService.goToArtPiece
		
		scope.isDealOfTheDay = ArtPiecesService.isDealOfTheDay
)