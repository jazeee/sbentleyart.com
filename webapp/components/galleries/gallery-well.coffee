angular.module("galleries").directive('galleryWell'
($state)->
	restrict: "E"
	replace: true
	templateUrl: "galleries/gallery-well.html"
	scope:
		gallery: '='
	link: (scope, element, attributes) ->
		scope.goToGallery = (gallery) ->
			$state.go("gallery"
				galleryId: gallery.galleryId
			)

)