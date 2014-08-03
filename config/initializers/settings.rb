begin

  # Include defaults
  Setting.good_link_url ||= 'http://www.nytimes.com/2014/07/27/magazine/what-do-chinese-dumplings-have-to-do-with-global-warming.html?_r=1'
  Setting.good_gif_url  ||= 'http://media.giphy.com/media/soJtSkHcZzpDO/giphy.gif'

  # Explicity define
  Setting.admin_facebook_ids = [
    7002294,    # greg leuch
  ]
  Setting.facebook_app_id = ''

  # Personal Stats
  Setting.stats_github_repo_list  ||= {
    'rocketboom/magma'              => 1534,
    'rocketboom/knowyourmeme'       => 880,
    'buzzfeed/browser_extension'    => 113,
    'buzzfeed/anyone_say_search'    => 3,
    'buzzfeed/ga-tool'              => 16,
    'buzzfeed/buzzfeed'             => 364,
    'jess3/oil-plugin'              => 11,
    'jess3/exblocker'               => 39,
    'jess3/zagat_trucks'            => 103,
  }
  Setting.stats_github_commits    ||= 0
  Setting.stats_github_repos      ||= 0
  Setting.stats_miles_flown       ||= 0
  Setting.stats_favorited_tweets  ||= 0
  Setting.stats_tweets            ||= 0
  Setting.stats_all_nighters      ||= 0
  Setting.stats_c_and_ds          = 2


rescue => err
  puts "Settings Initializer Error: #{err}"
  nil
end