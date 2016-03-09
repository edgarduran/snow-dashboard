require 'test_helper'

class UserCanRemoveResortsFromDashboardTest < ActionDispatch::IntegrationTest

  def setup
    stub_omniauth
  end

  test "user can delete a resort from dashboard" do
    VCR.use_cassette("remove_resort") do
      login_user
      user = User.first

      assert_equal 0, user.resorts.count
      within('.resort-search') do
        select 'CO', from: "state"
        fill_in "city", with: "georgetown"
        click_on "Search"
      end
      click_on "Add to Dashboard"

      assert_equal 1, User.first.resorts.count
      assert page.has_link?("X")

      click_on "X"

      assert_equal 0, user.resorts.count

      assert page.has_content?("You have removed Loveland Ski Area")
      assert page.has_content?("Your dashboard is empty add your favorite resorts to begin playing")
    end
  end

end
