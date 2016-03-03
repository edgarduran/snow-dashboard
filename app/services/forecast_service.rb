require 'forecast_io'
class ForecastService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(:url => 'https://api.forecast.io/forecast/') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      faraday.headers['X-Forecast-API'] = ENV["FORECAST_API_KEY"]
    end
  end

end
