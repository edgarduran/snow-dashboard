require 'test_helper'

class UserLogsInWithGoogleTest < ActionDispatch::IntegrationTest

  test "user logs in with google" do
    VCR.use_cassette('login') do
      visit "/"

      assert_equal 200, page.status_code

      click_link "Login with Google"

      assert_equal dashboard_index_path, current_path
      assert page.has_content?("Edgar Duran's Dashboard")
      assert page.has_link?("Logout")
    end
  end

  test "logged in user can logout" do
    VCR.use_cassette('login') do
      login_user

      click_link "Logout"

      assert_equal "/", current_path
      assert_equal 200, page.status_code
      assert page.has_content?("Login with Google")
    end
  end

  test "user sees profile and favorite resorts after logging in" do
    VCR.use_cassette('login') do
      login_user

      assert page.has_content?("Edgar Duran's Dashboard")
      assert page.has_content?("Favorite Resorts")
      assert page.has_link?("Logout")
      assert page.has_content?("Edgar Duran")
      assert page.has_content?("eduran1")
      assert page.has_content?("edgarduran86@gmail.com")
      assert page.has_link?("Add Resorts to Dashboard")
      assert page.has_link?("Enter your phone number to receive snow text alerts")
    end
  end
end
