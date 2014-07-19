require File.expand_path('../boot', __FILE__)
require 'rails/all'
Bundler.require(*Rails.groups)

module GleuchWebSite
  class Application < Rails::Application
    config.time_zone = 'Eastern Time (US & Canada)'
    config.active_record.default_timezone = :utc

    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en


    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += %W(#{config.root}/lib/**/)

    config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    config.assets.paths << Rails.root.join('vendor', 'assets', 'fonts')
  end
end

I18n.enforce_available_locales = false