# -- Display Util -- #

class @DisplayUtil
  @view_height = (elem, ratio)->
    if !$(elem).get(0)
      return
    else
      $(elem).css('height', 'auto')
      if $(elem).outerHeight() < window.innerHeight / ratio
        $(elem).outerHeight(Math.ceil(window.innerHeight) / ratio)

  @vertical_center = (elem)->
    if !$(elem).get(0)
      return
    else
      do init = ->
        top = (window.innerHeight - $(elem).outerHeight(true)) / 2
        $(elem).css({ "top": top });
      $(window).on 'resize', init

  @blink = (elem, duration) ->
    window.setTimeout (->
      $(elem).addClass('hidden')
      window.setTimeout (->
        $(elem).remove()
      ), duration * 0.667
    ), duration
