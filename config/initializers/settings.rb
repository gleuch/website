begin

  # Include defaults
  Setting.good_link_url ||= 'http://www.nytimes.com/2014/07/27/magazine/what-do-chinese-dumplings-have-to-do-with-global-warming.html?_r=1'
  Setting.good_gif_url  ||= 'http://media.giphy.com/media/soJtSkHcZzpDO/giphy.gif'

  # Explicity define
  Setting.admin_facebook_ids = [
    7002294,    # greg leuch
  ]
  Setting.facebook_app_id = ''

rescue => err
  puts "Settings Initializer Error: #{err}"
  nil
end