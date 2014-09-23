$ -> 
  @YoDawgIHeardYouLiekIncrements = 0
  @YoDawgIHeardYouLiekTheInternet = ->
    if @YoDawgIHeardYouLiekIncrements >= 2
      alert("Yo dawg, I heard you liek browsers, but browsing in a browser in a browser in a browser might be a little too much, ya think???")

    $('body').wrapInner("<div class='yodawgbrowser-viewport'></div>")
    $('body > .yodawgbrowser-viewport').before("<div class='yodawgbrowser-header'><div class='yodawgbrowser-buttons'><a class='yodawgbrowser-close' href='javascript:;'>Close</a><a class='yodawgbrowser-minimize' href='javascript:;'>Minimize</a><a class='yodawgbrowser-maximize' href='javascript:;'>Maximize</a></div><div class='yodawgbrowser-settings'>[x]</div><div class='yodawgbrowser-addressbar'><div class='yodawgbrowser-addressbar-bar' contenteditable>" + window.location.href + "</div></div></div>")
    $('body').wrapInner("<div class='yodawgbrowser'><div class='yodawgbrowser-window'></div></div>")

    @YoDawgIHeardYouLiekIncrements++

  if window.console
    # TODO : MAKE COOLER
    window.console.log "\n\nHi!\n\nIf you like what you see, I'd be happy to talk more with you.\n\nSend me an email at contact@gleu.ch or tweet me @gleuch.\n\n"


  $(window).on 'beforeunload', (e)->
    $('body').removeClass('nav-open').addClass('unload')
    return

  $(document).ready ->
    $('body').removeClass('unload')

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

    # Search overlay toggle
    $('#nav-search').on 'click', ->
      $('#search-overlay').addClass('open')
      return false
    $('#search-overlay .search-close').on 'click', ->
      $('#search-overlay').removeClass('open')
      return false

    try
      @gleuch_haha = @gleuch_haha || {}
      @gleuch_haha.keys = []
      @gleuch_haha.code = '38,38,40,40,37,39,37,39,66,65'

      $(document).on 'keydown', (e)->
        try
          @gleuch_haha.keys.push(e.keyCode)
          if @gleuch_haha.keys.toString().indexOf(@gleuch_haha.code) >= 0
            @gleuch_haha.keys = []
            @YoDawgIHeardYouLiekTheInternet()
        catch e
          #

    # Key navigations
    $(document).on 'keydown', (e)->
      # Skip if inside form element
      if ['input','textarea','select','button'].indexOf(e.target.nodeName.toLowerCase()) >= 0
        return true

      # 'esc' key, close overlay and menus by priority
      if e.keyCode == 27
        # Clear search overlay
        if $('#search-overlay').hasClass('open')
          $('#search-overlay').removeClass('open')
        # Clear open menu
        else if $('body').hasClass('nav-open')
          $('body').removeClass('nav-open')

      # 'm' key toggles menu
      else if e.keyCode == 77
        $('body').toggleClass('nav-open')

    # CSS / JS Ability checks (simpler than using modernizer, etc.)
    test_can = document.createElement('div');
    unless test_can.style['mask'] == undefined
      $('html').addClass('can-css-mask')
    else
      'Webkit Moz O ms Khtml'.replace /([A-Za-z]*)/g, (v) ->
        unless test_can.style[v + 'Mask'] == undefined
          $('html').addClass('can-css-mask')