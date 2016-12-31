angular.module('art-piece-detail').directive("artPieceDetail"
(SiteService, ArtPiecesService, $timeout, $window, FacebookService) ->
	return {
		restrict: "E"
		replace: true
		templateUrl: "art-piece-detail/art-piece-detail.html"
		link: (scope, element, attributes) ->
			window = angular.element($window)
			unregisterScroll = window.on("scroll", ->
				$timeout( ->
					scrollPosition = $window.scrollY
					scope.translate = "translateY(-#{scrollPosition*5}px)"
					scope.$apply()
				)
			)
			scope.$on("$destroy", unregisterScroll)

			scope.randomArtPiece = ArtPiecesService.randomArtPiece

			scope.getLowResPathAsUrl = ArtPiecesService.getLowResPathAsUrl

			scope.artPieceOfTheDayAsUrl = ArtPiecesService.getLowResPathAsUrl(ArtPiecesService.artDealOfTheDay)

			scope.goToArtPiece = ArtPiecesService.goToArtPiece

			scope.mouseOffset = { x:0, y:0}

			scope.originalPrice = scope.artPiece.price
			scope.deliveryOption = "MadisonPickup"
			scope.discountPercent = ArtPiecesService.getArtPieceDiscount(scope.artPiece)

			scope.calculateDiscountedPrice = ->
				{discountPercent, deliveryOption, originalPrice} = scope
				discountPercent ?= 0
				discountPercent = Math.max(0, discountPercent)
				discountPercent = Math.min(40, discountPercent)
				price = originalPrice * ((100 - discountPercent) / 100)
				scope.discountedPrice = price
				scope.savings = originalPrice - price
				scope.shippingCost = 0
				if deliveryOption == "Shipping"
					scope.shippingCost = 50
					scope.shippingCost = Math.min(scope.originalPrice / 5, scope.shippingCost)

			scope.calculateDiscountedPrice()

			scope.processMouseOver = (event) ->
				{offsetX, offsetY} = event
				console.log offsetX, offsetY
				scope.mouseOffset.x = offsetX * 10
				scope.mouseOffset.y = offsetY * 10

			scope.getArtPiecePath = (artPiece) ->
				if /\//.test artPiece.filename
					return "images/#{artPiece.filename}"
				"images/#{scope.galleryId}/#{artPiece.filename}"

			scope.getArtPiecePathAsUrl = (artPiece) ->
				'url("../' + scope.getArtPiecePath(artPiece) + '")'

			scope.getUrl = SiteService.getUrl

			scope.shareToFacebook = SiteService.shareToFacebook

			SiteService.setArtPieceMetaTags(scope.artPiece)
			FacebookService.facebookLoadedPromise.done( ->
				$timeout( ->
					FB?.XFBML?.parse()
				)
			)
	}
)
