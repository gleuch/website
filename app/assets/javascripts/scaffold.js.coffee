$ -> 
  if window.console
    # TODO : MAKE COOLER
    window.console.log "\n\nHi!\n\nIf you like what you see, I'd be happy to talk more with you.\n\nSend me an email at contact@gleu.ch or tweet me @gleuch.\n\n"


  $(document).ready ->
    $('#menu-icon').on 'click', ->
      $('body').toggleClass 'nav-open'
    $('a.close-menu').on 'click', ->
      $('body').toggleClass 'nav-open', false


    $(window).on('resize load', ->
      h = $(window).height() - $('#header').outerHeight()
      $('#content').css('min-height', h)
    ).trigger 'resize'