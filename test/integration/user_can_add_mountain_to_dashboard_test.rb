require 'test_helper'

class UserCanAddMountainToDashboardTest < ActionDispatch::IntegrationTest

  test "user can search for resorts" do
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

  test "user can add a resort to their dashboard" do
    
  end


end
