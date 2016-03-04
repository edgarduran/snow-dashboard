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
    parse_json(connection.get("39.7392,-104.9903?exclude=[minutely,flags,hourly]"))
  end

  def three_day_forecast
    full_forecast = parse_json(connection.get("39.7392,-104.9903?exclude=[minutely,flags,hourly]"))
    limit_days(full_forecast, 2)
  end

  def five_day_forecast
    full_forecast = parse_json(connection.get("39.7392,-104.9903?exclude=[minutely,flags,hourly]"))
    limit_days(full_forecast, 4)
  end

  def limit_days(data, days)
    days = data[:daily][:data][0..days]
    days.map do |day|
      {
        summary:     day[:summary],
        icon:        day[:icon],
        precip_prob: day[:precipProbability],
        min_temp:    day[:temperatureMin],
        max_temp:    day[:temperatureMax],
        humidity:    day[:humidity]
      }
    end
  end

  private

  def parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

end
