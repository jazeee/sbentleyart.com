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
			
			scope.mouseOffset = { x:0, y:0}
			
			scope.originalPrice = scope.artPiece.price
			scope.deliveryOption = "Shipping"
			scope.discountPercent = ArtPiecesService.getArtPieceDiscount(scope.artPiece)
			
			scope.calculateDiscountedPrice = ->
				{discountPercent, deliveryOption, originalPrice} = scope
				discountPercent ?= 20
				discountPercent = Math.max(0, discountPercent)
				discountPercent = Math.min(40, discountPercent)
				price = originalPrice * ((100 - discountPercent) / 100)
				switch deliveryOption
					when "MadisonPickup", "MankatoPickup"
						localPickupDiscount = 50
					else
						localPickupDiscount = 0
				localPickupDiscount = Math.min(price / 5, localPickupDiscount)
				price -= localPickupDiscount
				scope.discountedPrice = price
				scope.savings = originalPrice - price
			
			scope.calculateDiscountedPrice()
		
			scope.processMouseOver = (event) ->
				{offsetX, offsetY} = event
				console.log offsetX, offsetY
				scope.mouseOffset.x = offsetX * 10
				scope.mouseOffset.y = offsetY * 10
			
			scope.getArtPiecePath = (artPiece) ->
				'images/' + scope.galleryId + '/' + artPiece.filename
			
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