require 'test_helper'

class UserCanAddMountainToDashboardTest < ActionDispatch::IntegrationTest

  test "user can search for resorts" do
    VCR.use_cassette("resort_search") do
      login_user

      within('.resort-search') do
        select 'CO', from: "state"
        fill_in "city", with: "dillon"
        fill_in "Resort name", with: "keystone"
        click_on "Search"
      end

      assert page.has_content?("Keystone Ski Resort")
      assert page.has_content?("Colorado")
      assert page.has_button?("Add to Dashboard")
    end
  end

  test "user can add a resort to their dashboard" do
    VCR.use_cassette("add_resort") do
      login_user
      user = User.first

      assert_equal 0, user.resorts.count
      within('.resort-search') do
        select 'CO', from: "state"
        fill_in "city", with: "georgetown"
        click_on "Search"
      end

      assert page.has_content?("Loveland Ski Area")
      assert page.has_content?("Colorado")
      assert page.has_button?("Add to Dashboard")

      click_on "Add to Dashboard"

      assert_equal dashboard_index_path, current_path
      assert page.has_content?("Loveland Ski Area")
      assert page.has_link?("X")
      assert_equal 1, User.first.resorts.count
      assert_equal "Loveland Ski Area", user.resorts.first.name
    end
  end


end
