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
      assert page.has_content?("Your dashboard is empty add your favorite resorts to begin playing")
      assert page.has_link?("Logout")
    end
  end
end
