angular.module("site").directive("socialTags"
(SiteService, ArtPiecesService) ->
	return {
		restrict: "E"
		replace: true
		templateUrl: "site/social-tags.html"
		link: (scope, element, attributes) ->
			scope.getUrl = SiteService.getUrl
	}
)