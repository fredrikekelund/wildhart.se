---
---

###
requestAnimationFrame polyfill by Erik Möller
Fixes from Paul Irish and Tino Zijdel
http://paulirish.com/2011/requestanimationframe-for-smart-animating/
MIT license
###
do ->
	lastTime = 0
	vendors = ["ms", "moz", "webkit", "o"]
	x = 0

	for vendor in vendors
		unless window.requestAnimationFrame
			window.requestAnimationFrame = window[vendor + "RequestAnimationFrame"]
			window.cancelAnimationFrame = window[vendor + "CancelAnimationFrame"] or window[vendor + "CancelRequestAnimationFrame"]

	unless window.requestAnimationFrame
		window.requestAnimationFrame = (callback, element) ->
			currTime = new Date().getTime()
			timeToCall = Math.max(0, 16 - (currTime - lastTime))
			id = window.setTimeout(->
				callback currTime + timeToCall
				return
			, timeToCall)
			lastTime = currTime + timeToCall
			return id

	unless window.cancelAnimationFrame
		window.cancelAnimationFrame = (id) ->
			clearTimeout id
			return

	return



header = document.querySelector ".background > .wildhart-image"
lastPosition = 0

parallaxBackground = =>
	scrollTop = window.pageYOffset

	unless lastPosition == scrollTop
		lastPosition = scrollTop
		bgPositionY = (scrollTop / 20)
		header.style["WebkitTransform"] = header.style["MozTransform"] = header.style["transform"] = "translate3d(0, -#{bgPositionY}%, 0)"

	requestAnimationFrame parallaxBackground

parallaxBackground()