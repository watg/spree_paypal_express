# Setup simplecov first to make sure coverage happens through everything.
require 'simplecov'
SimpleCov.start do
  add_filter '/config/'
  add_group 'Controllers', 'app/controllers'
  add_group 'Helpers', 'app/helpers'
  add_group 'Mailers', 'app/mailers'
  add_group 'Models', 'app/models'
  add_group 'Libraries', 'lib'
  add_group 'Specs', 'spec'
end

# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'

require 'factory_girl'
FactoryGirl.find_definitions
require 'ffaker'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each {|f| require f }

# Requires factories defined in spree_core
require 'spree/core/testing_support/factories'
require 'spree/core/testing_support/fixtures'
require 'spree/core/testing_support/authorization_helpers'
require 'spree/core/url_helpers'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Spree::Core::UrlHelpers
  config.color = true

  config.use_transactional_fixtures = true
end

Spree::Zone.class_eval do
  def self.global
    find_by_name("GlobalZone") || FactoryGirl.create(:global_zone)
  end
end
