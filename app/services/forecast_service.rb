require 'forecast_io'
class ForecastService
  include JsonHelper
  attr_reader :connection

  def initialize
    @connection = Faraday.new(:url => "https://api.forecast.io/forecast/#{ENV['FORECAST_API_KEY']}/") do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def three_day_forecast(user_resorts)
    user_resorts.map do |resort|
      full_forecast = parse_json(connection.get("#{resort[:latitude].to_f},#{resort[:longitude].to_f}?exclude=[minutely,flags,hourly]"))
      limit_days(full_forecast, 2)
    end
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

end
