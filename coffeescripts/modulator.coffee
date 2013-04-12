$ ->

RM = ->

$iframe = $('#master-modules')
$iframe_contents = $iframe.contents()

RM.iframeHeight = ->
	$w_height = $(window).height()
	$iframe.css( 
		height:$w_height-85+"px"
	)
	$iframe_contents.find('#grid .row > .col .in').css( 
		height:$w_height-85+"px"
	)

RM.modulatorDisplayWidth = ->
	$iframe_width = $iframe.width()
	$modulator_display = $('#modulator-display')
	$modulator_display.css( 
		width:$iframe_width+"px"
	)

RM.displayViewportWidth = ->
	$iframe_width = $iframe.width()
	$("#viewport-width-container p").html($iframe_width+" px")

RM.checkboxStates = ->
	$(".module-type input[type='checkbox']").on("change", ->
		$(@).parent().toggleClass("active")
		setter = $(@).data("module")
		RM.showHideModules(setter)
	)
	
RM.radioStates = ->
	$radio = $(".device-type input[type='radio']")
	$radio.on("change", ->
		current = $(@)
		$radio.parent().removeClass('active')
		current.parent().toggleClass("active")
		RM.deviceWidths(current)
	)

RM.deviceWidths = (current) ->
	device_w = current.next().data('res-width')
	device_h = current.next().data('res-height')
	if device_w is 100 then $iframe.css(maxWidth:100+"%",height:RM.iframeHeight())
	else
		$iframe.css( 
			maxWidth:device_w+"px"
			height:device_h+"px"
		)
	RM.displayViewportWidth()
	RM.modulatorDisplayWidth()

RM.showHideModules = (setter) ->
	$iframe_contents.find('#'+setter).toggle()
	
$(window).on('resize', ->
	RM.iframeHeight()
	RM.modulatorDisplayWidth()
	RM.displayViewportWidth()
	)		

$(document).ready ->
	RM.iframeHeight()
	RM.modulatorDisplayWidth()
	RM.displayViewportWidth()
	RM.radioStates()
	RM.checkboxStates()