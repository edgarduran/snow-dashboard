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
    Capybara.app = SnowDashboard::Application
    stub_omniauth
  end

  def teardown
    reset_session!
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
      {"provider"=>"google",
       "uid"=>"104436580263943299126",
       "info"=>
          {"name"=>"Edgar Duran",
           "email"=>"edgar.eduran@gmail.com",
           "first_name"=>"Edgar",
           "last_name"=>"Duran",
           "image"=>"https://lh3.googleusercontent.com/-BdFiwpam_1k/AAAAAAAAAAI/AAAAAAAAEUo/fPFVSiHSZ_4/photo.jpg",
           "urls"=>{"Google"=>"https://plus.google.com/104436580263943299126"}},
       "credentials"=>{"token"=>"ya29.nQK7UbxFTpMRCHxBNUwFaBFOWvZYf9o9cDKIkENqJBa9zRumJe4wEnZ-zATI95J-tJg", "expires_at"=>1457304606, "expires"=>true},
       })
    end

  def login_user
    visit "/"

    assert_equal 200, page.status_code

    click_link "Login with Google"

    assert_equal dashboard_index_path, current_path
    assert page.has_content?("Edgar Duran's Dashboard")
    assert page.has_link?("Logout")
  end

end
