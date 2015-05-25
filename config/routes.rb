Rails.application.routes.draw do

  # Hack (tmp)
  match '/_betaworks/:id' => 'tmp_log#create', via: [:get]


  # Projects ---
  resources :projects, only: [:index, :show]

  # Client Work ---
  resources :client_works, path: 'work', only: [:index, :show]

  # Contact ---
  resources :contact_messages, path: 'contact', as: :contacts, only: [:index, :new, :create]

  # Search & Tags ---
  match '/search' => 'search#index', as: :search, via: [:get, :post]
  match '/tag/:id' => 'search#tags', as: :search_tag, via: [:get, :post]

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
    facebook_url:           'https://facebook.com/gleuchweb',
    facebook_profile_url:   'https://facebook.com/gleuch',
    twitter_url:            'https://twitter.com/gleuch',
    twitter_favorites_url:  'https://twitter.com/gleuch/favorites',
    github_url:             'https://github.com/gleuch',
    instagram_url:          'http://instagram.com/gleuch',
    linkedin_url:           'http://www.linkedin.com/in/gleuch',
    google_plus_url:        'https://plus.google.com/100780866870324876908',
    email_url:              'mailto:contact@gleu.ch',

    # Special URLs
    resume_url:             '/files/2014/resume.pdf',

    # Common URLs
    xolator_url:            'http://xolator.com',
    popblock_url:           'https://pop-block.com',
    metafetch_url:          'http://metafetch.com',
    fatlab_url:             'http://fffff.at',

  }.each do |name,url|
    define_method(name){ url }
  end


end