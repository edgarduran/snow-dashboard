class HistoricalSnowfallService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(:url => "https://api.weathersource.com/v1/934e20948454d328f58f/") do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def twenty_five_day_snow(resorts)
    resorts.map do |resort|
      days = parse_json(connection.get("history_by_postal_code.json?period=day&postal_code_eq=#{resort[:zip_code]}&country_eq=US&timestamp_between=2016-01-01T08:00+00:00,2016-01-31T23:00+00:00&limit=25&fields=postal_code,tempAvg,precip,snowfall,timestamp"))
      calculate_snowfall(days)
    end
  end

  def calculate_snowfall(days)
    days.map { |day| day[:snowfall] }.inject(:+)
  end

  private
  def parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

end
