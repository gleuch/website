$ -> 
  if window.console
    # TODO : MAKE COOLER
    window.console.log "\n\nHi!\n\nIf you like what you see, I'd be happy to talk more with you.\n\nSend me an email at contact@gleu.ch or tweet me @gleuch.\n\n"


  $(document).ready ->
    menu_toggle = (r) ->
      $(this).trigger('mouseout')
      $('body').toggleClass 'nav-open', r

    $('#menu-icon').removeAttr('href').on 'click', ->
      menu_toggle.bind(this).call()

    $('a.close-menu').removeAttr('href').on 'click', ->
      menu_toggle.bind(this).call(null, false)

    $('#menu-icon, a.close-menu').on('mouseover', ->
      $(this).addClass('hover')
    ).on('mouseout', ->
      $(this).removeClass('hover')
    )

    $(window).on('resize load', ->
      h = $(window).height() - $('#content').offset().top
      if h > 0
        $('#content').css('min-height', h)
    ).trigger 'resize'



    # CSS / JS Ability checks (simpler than using modernizer, etc.)
    test_can = document.createElement('div');
    unless test_can.style['mask'] == undefined
      $('html').addClass('can-css-mask')
    else
      'Webkit Moz O ms Khtml'.replace /([A-Za-z]*)/g, (v) ->
        unless test_can.style[v + 'Mask'] == undefined
          $('html').addClass('can-css-mask')