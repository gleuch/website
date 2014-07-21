Rails.application.routes.draw do

  # Projects ---
  resources :projects, only: [:index, :show]


  # Client Work ---
  resources :client_works, path: 'works', only: [:index, :show]


  # Contact ---
  resources :contact_messages, path: 'contact', only: [:index, :new, :create]


  # Static Pages --- 
  # (Use constraint on StaticPage to check if page exists.)
  get '/*id' => 'static_pages#show', as: :static_page, constraints: StaticPage.new


  # Homepage
  root 'static_pages#index'

end


# Now this is much better!
Gleuch::Application.routes.named_routes.module.module_eval do

  {
    # Social Media URLs
    facebook_url:         'https://facebook.com/gleuchweb',
    facebook_profile_url: 'https://facebook.com/gleuch',
    twitter_url:          'https://twitter.com/gleuch',
    github_url:           'https://github.com/gleuch',
    instagram_url:        'http://instagram.com/gleuch',
    linkedin_url:         'http://www.linkedin.com/in/gleuch',
    google_plus_url:      'https://plus.google.com/100780866870324876908',

    # Common URLs
    xolator_url:          'http://xolator.com',
    popblock_url:         'https://pop-block.com',
    metafetch_url:        'http://metafetch.com',
    fatlab_url:           'http://fffff.at',
  }.each do |name,url|
    define_method(name){ url }
  end


end