recalcAds = ->

  w = $(window).width()
  space = 0
  if w < 1000
    return

  space = w - 1000

  if space > 320
    $('#ads-right').show()
  else
    $('#ads-right').hide()

  if space < 620
    $('.content').css {
      'margin-left': '1em'
    }
  else
    $('.content').css {
      'margin': '0 auto'
    }


$ ->
  recalcAds()
  $(window).resize recalcAds
