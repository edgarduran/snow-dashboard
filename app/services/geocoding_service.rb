class GeocodingService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(:url => 'https://maps.googleapis.com/maps/api/geocode/') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def check
    parse_json(connection.get("json?latlng=40.714224,-73.961452&key=AIzaSyAqFCE_WcES8oPiBY4bbNSS3r6p-9BtIgM"))
  end

  private
  def parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

end
