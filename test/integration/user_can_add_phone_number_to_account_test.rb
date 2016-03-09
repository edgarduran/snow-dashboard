require 'test_helper'

class UserCanAddPhoneNumberToAccountTest < ActionDispatch::IntegrationTest

  def setup
    stub_omniauth
  end

  test "user add phone number to account" do
    VCR.use_cassette("add_number") do
      login_user
      user = User.first

      within('.phone-form') do
        fill_in "Phone number", with: "7203279102"
        click_on "Add Number"
      end

      assert page.has_content?("You have successfully added a number to your account.")
      assert_equal dashboard_index_path, current_path
    end
  end

end
