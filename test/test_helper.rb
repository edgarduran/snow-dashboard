ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'mocha/mini_test'
require 'webmock'
require 'vcr'
require 'simplecov'
SimpleCov.start 'rails'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  VCR.configure do |config|
    config.cassette_library_dir = "test/cassettes"
    config.hook_into :webmock
    config.allow_http_connections_when_no_cassette = true
  end

end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    stub_omniauth
  end

  def teardown
    reset_session!
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new(
      {"provider"=>"spotify",
        "uid"=>nil,
        "info"=> "stuff"}
        )
    end


end
