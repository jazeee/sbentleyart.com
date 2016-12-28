angular.module("galleries").directive('artPieces'
(SiteService) ->
	restrict: "E"
	replace: true
	templateUrl: "gallery/art-pieces.html"
	link: (scope, element, attributes) ->
		SiteService.setGalleryMetaTags(scope.gallery)
)