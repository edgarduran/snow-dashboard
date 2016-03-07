require './test/test_helper'

class ForecastTest < ActiveSupport::TestCase

  test 'vcr setup correctly' do
    VCR.use_cassette("forecast_#index") do
      service = ForecastService.new

      assert_equal 8, service.weather[:daily][:data].count
    end
  end

end
