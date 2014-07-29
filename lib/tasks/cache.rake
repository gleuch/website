namespace :cache do

  task clear: :environment do
    # Clear static pages
    Rails.cache.delete_matched('page/.*')
  end

end