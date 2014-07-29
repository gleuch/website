ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

require 'simplecov'
SimpleCov.start 'rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!


  config.before :each do
    ActionMailer::Base.deliveries.clear
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start
  end

  config.before(:suite) do
    Rails.cache.clear
    DatabaseCleaner.clean_with :deletion
    require File.expand_path("../../config/initializers/settings", __FILE__)
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.include SpecTestHelper, type: :feature
  config.include FactoryGirl::Syntax::Methods
  config.include RSpec::Rails::RequestExampleGroup, type: :feature
end
