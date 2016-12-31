angular.module('art').controller('ArtPieceDetail'
($scope, $stateParams, ArtPiecesService) ->

	$scope.galleryId = $stateParams.galleryId
	$scope.artPieceId = $stateParams.artPieceId.replace />/g, "/"
	console.log $scope.artPieceId, $stateParams.artPieceId

	$scope.artPiece = ArtPiecesService.getArtPiece($stateParams.galleryId, $scope.artPieceId)

	$scope.isDealOfTheDay = ArtPiecesService.isDealOfTheDay
)
