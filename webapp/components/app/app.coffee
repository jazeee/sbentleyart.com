angular.module('webapp', [
	'ngResource'
	'ngAnimate'
	'ui.router'

	'app'
	'site'
	'banner'
	'common'
	'webappTemplates'
	'navigation'
	'art'
	'galleries'
	'art-piece-detail'
	'buy-art-piece'
]
).run(($rootScope, FacebookService)->
	$rootScope.metaTags = {}
)