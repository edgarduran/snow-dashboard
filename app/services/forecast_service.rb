require 'forecast_io'
class ForecastService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(:url => "https://api.forecast.io/forecast/2f0b7cab287907f249c7216344eea871/") do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def weather
    binding.pry
    parse_json(connection.get("39.7392,-104.9903"))
  end


  private

  def parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

end
