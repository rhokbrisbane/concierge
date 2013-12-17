class @Message
  @flash : (class_name, message) ->
    msg = $("<div class='flash #{class_name}'><span class='wrap'>#{message}<div class='close-button'><a href='#' class='close-button-link' data-no-turbolink='true'></a></div></span></div>")

    $('.flash').remove()
    $('body').append(msg)
    $('.flash').addClass('animated');
    DisplayUtil.blink('.flash', 4000)

$ ->
  $(document).on 'click', '.flash', ->
    $(this).remove()

  if $('.flash').is(':visible')
    $('.flash').addClass('animated')
    DisplayUtil.blink('.flash', 4000)
