angular.module('common').service('DateUtil'
->
	class DateUtil
		constructor: ->
		
		getDayOfYear: ->
			date = new Date()
			dayOfYear = date.getDate()
			for month in [0 .. date.getMonth()]
				switch month
					when 0,2,4,6,7,9,11
						dayOfYear += 31
					when 3,5,8,10
						dayOfYear += 30
					when 1
						#Ignoring Leap year
						dayOfYear += 28
			return (dayOfYear)

	return new DateUtil()
)