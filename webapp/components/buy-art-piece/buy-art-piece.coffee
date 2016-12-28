angular.module('buy-art-piece').directive('buyArtPiece'
(ArtPiecesService) ->
	return {
		restrict: 'E'
		replace: true
		templateUrl: 'buy-art-piece/buy-art-piece.html'
		scope:
			artPiece: '='
			price: '='
			savings: '='
		link: (scope, element, attributes) ->
	}
)