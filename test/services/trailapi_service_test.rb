require './test/test_helper'

class TrailapiTest < ActiveSupport::TestCase

  test 'vcr setup correctly' do
    VCR.use_cassette("trailapi_#index") do
      service = TrailapiService.new

      assert_equal 20, service.some_info[:places].count
    end
  end

end
