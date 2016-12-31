angular.module('art').constant('galleries'
	[	{
			"name" : "Beautiful Creatures"
			"description" : """Imaginative creatures and objects. All paintings are oil and encaustic on canvas.
				The larger than normal depth creates a sculptural element to the art, and eliminates the need for a traditional frame."""
			"filename" : "01SeaMonster_oil_and_encaustic.jpg"
			"galleryId" : "Beautiful_Creatures"
		}, {
			"name" : "Bugs",
			"description" : "Imaginative insects and bugs. The larger than normal depth creates a sculptural element to the art, and eliminates the need for a traditional frame."
			"filename" : "03Bee_oil_and_encaustic.jpg"
			"galleryId" : "Ugly_Bugs"
		}, {
			"name" : "Flower Power",
			"description" : "Flower perspective studies. The larger than normal depth creates a sculptural element to the art, and eliminates the need for a traditional frame."
			"filename" : "art-pieces/flowers/2016-01-dahlias-oil-and-encaustic.jpg"
			"galleryId" : "flowers"
		}, {
			"name" : "Wonderous Places",
			"description" : "Studies of perspective from various destinations of travel. All paintings are oil on canvas."
			"filename" : "01PacificAviationMuseum_oil_and_encaustic.jpg"
			"galleryId" : "Wonderous_Places"
		}, {
			"name" : "Boats"
			"description" : "Paintings of boats"
			"filename" : "boats.jpg"
			"galleryId" : "boats"
		}, {
			"name" : "Felt Creatures",
			"description" : "Creatures in Felt."
			"filename" : "art-pieces/felting/2016-felt-01-arachnid-creature.jpg"
			"galleryId" : "felting"
		}, {
			"name" : "Shapes"
			"description" : "Studies of oil and encaustic. The larger than normal depth creates a sculptural element to the art, and eliminates the need for a traditional frame."
			"filename" : "10_shapes_oil_and_encaustic.jpg"
			"galleryId" : "Shapes"
		}, {
			"name" : "Wood Blocks",
			"description" : "Sculptures made from reclaimed wood pieces."
			"filename" : "wood-blocks-gallery.jpg"
			"galleryId" : "Wood_Blocks"
		}, {
			"name" : "Gallery Views"
			"description" : "Art pieces in various galleries"
			"filename" : "gallery-pictures.jpg"
			"galleryId" : "Gallery_Views"
		}
	]
)

angular.module('art').service('GalleriesService'
(galleries) ->
	class GalleriesService
		constructor: ->

		getGallery: (galleryId) =>
			for gallery in galleries
				if gallery.galleryId == galleryId
					return gallery

		getGalleryPath: (gallery) =>
			"""images/galleries/#{gallery.filename}""" if gallery?

	return new GalleriesService()
)

angular.module('art').controller('Galleries'
($scope, galleries) ->
	$scope.galleries = galleries
)
