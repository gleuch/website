Rails.application.routes.draw do


  # Projects ---
  resources :projects, only: [:index, :show]

  # Client Work ---
  resources :client_works, path: 'works', only: [:index, :show]

  # Contact ---
  resources :contact_messages, path: 'contact', only: [:index, :new, :create]


  # Static pages routing, use StaticPage to check if exists as constraint
  get '/*id' => 'static_pages#show', as: :static_page, constraints: StaticPage.new

  root 'static_pages#index'

end


# Now this is much better!
Gleuch::Application.routes.named_routes.module.module_eval do

  # Social Media URLs
  def facebook_url;   'https://facebook.com/gleuch'; end
  def twitter_url;    'https://twitter.com/gleuch'; end
  def github_url;     'https://github.com/gleuch'; end
  def instagram_url;  'http://instagram.com/gleuch'; end
  def linkedin_url;   'http://www.linkedin.com/in/gleuch'; end

  # Common URLs
  def xolator_url;    'http://xolator.com'; end
  def popblock_url;   'https://pop-block.com'; end
  def metafetch_url;  'http://metafetch.com'; end
  def fatlab_url;     'http://fffff.at'; end

end